import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/common_provider.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
import 'package:kaustubha_medtech/utils/routes/route_names/route_names.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class VideoCallScreen extends StatefulWidget {

  const VideoCallScreen({super.key});

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late String userId;
  String clientId='';
  IO.Socket? socket;
  RTCVideoRenderer localRenderer = RTCVideoRenderer();
  RTCVideoRenderer remoteRenderer = RTCVideoRenderer();
  MediaStream? localStream;
  String? idToCall;
  bool callAccepted = false;
  bool callEnded = false;
  bool isMuted = false;
  bool isVideoOff = false;
  bool isPeerMuted=false;
  bool isPeerVideoOff=false;
  RTCPeerConnection? _peerConnection;
  bool answerCall=false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getData();
    });
  }

  Future<void> _initRenderers() async {
    await localRenderer.initialize();
    await remoteRenderer.initialize();
    _connectSocket();
  }

  Future<void> _connectSocket() async {
    UserInfo? userInfo = await LocalDB.getUserInfo();
    userId = userInfo?.id ?? "cm1xxge4v000112v3ircefnm9";
    try {
      socket = IO.io('https://chatapi.kaustubhamedtech.com', IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect()  // Optional, disable auto-connect
          .build());
      socket?.connect();
      List<String> data = [userId, clientId];
      socket?.emit('getSocketIds', [data]);

      socket?.on('socketIds', (socketIds) {
        if(mounted) {
          setState(() {
            idToCall = socketIds[clientId];
          });
          _answerCall();
          if(!answerCall){
            _callUser();
          }
        }
      });

      socket?.on('error', (data) {
        log('Socket error: $data');
        CustomPopUp.showSnackBar(context, "Socket error occurred", Colors.red);
      });

      socket?.on('toggleAudio', (data) {
        log('audio_toggle$data');
        if(data.toString()=='true'){
          isPeerMuted=true;
        }else if(data.toString()=='false'){
          isPeerMuted=false;
        }
        setState(() {});
      });

      socket?.on('callUser', (signal)async{
        log('callUser $signal');
        if(signal['signal'].toString()=='call' && mounted){
          return;
        }

        if(mounted && signal['signal']!=null && signal['signal'].toString()!='call' && signal['signal'].toString()!='endCall' && signal['signal']['offer']!=null ){
          await _setRemoteDescription(signal['signal']['offer']);
          _createAnswer((answer){
            socket?.emit('answerCall', {
              'signal':{'answer':answer.toMap()},
              'to': idToCall,
            });
          });
        }

        if ( mounted && signal['signal'] != null && signal['signal'].toString()!='call' && signal['signal'].toString()!='endCall' && signal['signal']['candidate'] != null) {
          log('$signal Signal Data');
          final candidate = signal['signal']['candidate'];
          await _peerConnection?.addCandidate(RTCIceCandidate(
            candidate['candidate'],
            candidate['sdpMid'],
            candidate['sdpMLineIndex'],
          ));
        }

      });

      socket?.on('callAccepted', (signal)async{

        if(signal!=null && signal.toString()=='endCall' && mounted){
          _endCall();
        }

        if(signal!=null && signal.toString().contains('audio_') && mounted){
          if(signal.toString().replaceAll('audio_', '')=='true') {
            isPeerMuted=true;
            setState(() {});
          }else{
            isPeerMuted=false;
            setState(() {});
          }
          return;
        }

        if(signal!=null && signal.toString().contains('video_') && mounted){
          if(signal.toString().replaceAll('video_', '')=='true') {
            isPeerVideoOff=true;
            setState(() {});
          }else{
            isPeerVideoOff=false;
            setState(() {});
          }
          return;
        }


        if(signal!=null && signal=='Declined_Call' && mounted){
          if(mounted && Navigator.of(context).canPop()) {
            CustomPopUp.showSnackBar(context, "Declined Call", Colors.red);
            Navigator.of(context).pop();
          }
          return;
        }

        if(signal!=null && signal=='Accepted_Call' && mounted){
          await _createPeerConnection((candidate){
            socket?.emit('callUser', {
              'signalData': {
                'candidate': {
                  'candidate': candidate.candidate,
                  'sdpMid': candidate.sdpMid,
                  'sdpMLineIndex': candidate.sdpMLineIndex,
                },
              },
              'from': userId,
              'name': clientId,
              'userToCall': idToCall,
            });
          });

          await _createOffer((offer){
            socket?.emit('callUser', {
              'signalData':{'offer':offer.toMap()},
              'userToCall':idToCall
            });
          });
          return;
        }

        if(signal!=null && signal!='Accepted_Call' && signal!='Declined_Call' && !signal.toString().contains('audio_') && !signal.toString().contains('video_') && signal.toString()!='endCall' && signal['answer']!=null && mounted){
          _setRemoteDescription(signal['answer']);
          return;
        }

        if(signal!=null && signal!='Accepted_Call' && signal!='Declined_Call' && !signal.toString().contains('audio_') && !signal.toString().contains('video_') && signal.toString()!='endCall' && signal['candidate']!=null && mounted){
          final candidate=signal['candidate'];
          await _peerConnection?.addCandidate(
              RTCIceCandidate(
            candidate['candidate'],
            candidate['sdpMid'],
            candidate['sdpMLineIndex'],
          ));
        }
        return;
      });

      socket?.on('callEnded', (_) {
        _endCall();
      });

    } catch (e) {
      log('Error connecting socket: $e');
      CustomPopUp.showSnackBar(context, "Error connecting to the server", Colors.red);
    }
  }

  Future<void> _createPeerConnection(Function(RTCIceCandidate)? onIceCandidate) async{
    var configuration = <String, dynamic>{
      'iceServers': [
        {'url': 'stun:stun.l.google.com:19302'}
      ]
    };
    localStream = await navigator.mediaDevices.getUserMedia({
      'video': {
        'facingMode': 'user',
      },
      'audio': true, // Set this to true if you want audio; otherwise, you can set it to false.
    });

    localRenderer.srcObject = localStream;
    _peerConnection = await createPeerConnection(configuration);
    localRenderer.value.copyWith(height: 1.sh,width: 1.sw);

    localStream?.getTracks().forEach((track) {
      _peerConnection?.addTrack(track, localStream!);
    });
    _peerConnection?.onIceCandidate = onIceCandidate;

    _peerConnection?.onAddStream = (stream) {
      remoteRenderer.srcObject = stream;
      setState(() {});
    };

    setState(() {});

  }




  Future<void> _requestPermissions() async {
    await [Permission.camera, Permission.microphone].request();
    _initRenderers();
  }

  void _callUser() async {
    UserInfo? user= await LocalDB.getUserInfo();
    socket?.emit('callUser', {
      'userToCall': idToCall,
      'signalData': 'call',
      'from': userId,
      'name': user?.name,
    });
    Future.delayed(const Duration(seconds: 30),checkCallAccepted);

  }


  void _answerCall() async {
    
   await _createPeerConnection((candidate){
      socket?.emit('answerCall', {
        'signal':{
          'candidate': {
            'candidate': candidate.candidate,
            'sdpMid':candidate.sdpMid,
            'sdpMLineIndex': candidate.sdpMLineIndex,
          }
        },
        'to': idToCall,
      });
    });

   socket?.emit('answerCall', {
     'signal':'Accepted_Call',
     'to': idToCall,
   });
  }

  void _endCall() {
    if(mounted) {
      setState(() {
        callAccepted = false;
        callEnded = true;
      });
      if(Navigator.of(context).canPop()){
        CustomPopUp.showSnackBar(context, "Call Ended", Colors.white,textStyle: GoogleFonts.dmSans(color: Colors.red,fontWeight: FontWeight.w500));
        Navigator.of(context).pop();
      }
      if(remoteRenderer.srcObject!=null) {
        socket?.emit('answerCall', {
          'signal': 'endCall',
          'to': idToCall,
        });
      }else{
        socket?.emit('callUser', {
          'userToCall': idToCall,
          'signalData': 'endCall',
          'from': userId,
        });
      }
    }
  }

  void _toggleMute() {
    if (localStream != null) {
      localStream?.getAudioTracks().forEach((track) {
        track.enabled = !track.enabled;
      });
      setState(() {
        isMuted = !isMuted;
        socket?.emit('answerCall', {
          'signal':'audio_$isMuted',
          'to': idToCall,
        });
      });
    }
  }

  void _toggleVideo() {
    if (localStream != null) {
      localStream?.getVideoTracks().forEach((track) {
        track.enabled = !track.enabled;
      });
      setState(() {
        isVideoOff = !isVideoOff;
      });
      socket?.emit('answerCall', {
        'signal':'video_$isVideoOff',
        'to': idToCall,
      });
    }
  }

  @override
  void dispose() {
    remoteRenderer.srcObject?.getTracks().forEach((track) async {
      await track.stop();
    });
    localRenderer.srcObject?.getTracks().forEach((track) async {
      await track.stop();
    });
    if(_peerConnection!=null) {
      _peerConnection?.close();
      _peerConnection?.dispose();
    }
    localRenderer.dispose();
    remoteRenderer.dispose();
    socket=null;
    _peerConnection=null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (canPop,_){
        context.read<CommonProvider>().setCurrentRoute(RoutesName.doctorChat);
      },
      child: Scaffold(
        body: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            children: [
              Positioned.fill(
                child: RTCVideoView(remoteRenderer,objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,),
              ),
              Positioned(
                top: 40,
                right: 20,
                  child: Visibility(
                      visible: remoteRenderer.srcObject!=null && isPeerMuted,
                      child: Icon(Icons.mic_off,color: Colors.white,size: 20.sp,)) ),
              Align(
                alignment: Alignment.center,
                child:Visibility(
                    visible: isPeerVideoOff,
                    child: Icon(Icons.videocam_off,color: Colors.white,size: 20.sp,)) ,
              ),

              Positioned(
                bottom:remoteRenderer.srcObject!=null? 10:0,
                right: remoteRenderer.srcObject!=null? 10:0,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: remoteRenderer.srcObject!=null? 160.h:1.sh,
                    width: remoteRenderer.srcObject!=null? 90.w:1.sw,
                    child: Stack(
                      children: [
                        RTCVideoView(localRenderer,mirror: true,objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,),
                        Positioned(
                            top: 10,
                            right: 10,
                            child: Visibility(
                                visible: remoteRenderer.srcObject!=null && isMuted,
                                child: Icon(Icons.mic_off,color: Colors.white,size: 20.sp,)) ),
                        Align(
                          alignment: Alignment.center,
                          child:Visibility(
                              visible: remoteRenderer.srcObject!=null && isVideoOff,
                              child: Icon(Icons.videocam_off,color: Colors.white,size: 20.sp,)) ,
                        )
                      ],
                    )),
              ),
              Positioned.fill(
                child:Visibility(
                  visible: remoteRenderer.srcObject==null,
                  child: Container(
                    color: Colors.black54,
                    child: Center(
                      child: Text(idToCall!=null? answerCall?'Connecting..':'Ringing..':'Calling..',style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,color: Colors.white,fontSize: 16.sp),),
                    ),
                  ),
                ),
              ),
                Positioned(
                  bottom: 10,
                  child: SizedBox(
                    width: 1.sw,
                    child: Container(
                      margin: EdgeInsets.only(right: 24.w,left: 24.w),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(20.sp)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(isMuted ? Icons.mic_off : Icons.mic,color: Colors.white,),
                            onPressed: _toggleMute,
                          ),
                          IconButton(
                            icon: Icon(isVideoOff ? Icons.videocam_off : Icons.videocam,color: Colors.white,),
                            onPressed: _toggleVideo,
                          ),
                          IconButton(
                            icon: Icon(Icons.call_end),
                            onPressed: _endCall,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createOffer(Function(RTCSessionDescription offer) onOffer) async {
    final offer = await _peerConnection?.createOffer();
    await _peerConnection?.setLocalDescription(offer!);
    onOffer(offer!);
    log('offer created');
  }

  Future<void> _createAnswer(Function(RTCSessionDescription answer) onAnswer) async {
    if(_peerConnection==null){
    }
    final answer = await _peerConnection?.createAnswer();
    await _peerConnection?.setLocalDescription(answer!);
    log('answer created');
    onAnswer(answer!);
  }

  Future<void> _setRemoteDescription(Map<String, dynamic> data) async {
    final remoteDescription = RTCSessionDescription(
      data['sdp'],
      data['type'],
    );
    await _peerConnection?.setRemoteDescription(remoteDescription);
  }

  void getData(){
    Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
    if(data!=null && data['clientId']!=null){
      clientId=data['clientId'];
      if(data['answer']!=null && data['answer']==true){
        answerCall=true;
      }
      setState(() {});
    }
    _requestPermissions();
  }

  void checkCallAccepted() {
    if (mounted) {
      if (remoteRenderer.srcObject == null && Navigator.of(context).canPop()) {
        CustomPopUp.showSnackBar(
            context, "Not Responding to Call", Colors.white,
            textStyle: GoogleFonts.dmSans(color: Colors.red,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500));
        Navigator.of(context).pop();
      }
    }
  }

}

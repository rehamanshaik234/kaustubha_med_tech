import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class VideoCallScreen extends StatefulWidget {
  final String clientId;

  const VideoCallScreen({super.key, required this.clientId});

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late String userId;
  IO.Socket? socket;
  RTCVideoRenderer localRenderer = RTCVideoRenderer();
  RTCVideoRenderer remoteRenderer = RTCVideoRenderer();
  MediaStream? localStream;
  String? idToCall;
  bool callAccepted = false;
  bool callEnded = false;
  bool isMuted = false;
  bool isVideoOff = false;
  late RTCPeerConnection _peerConnection;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
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
      socket!.connect();

      List<String> data = [userId, widget.clientId];
      socket?.emit('getSocketIds', [data]);

      socket?.on('socketIds', (socketIds) {
        log('Received socketIds: $socketIds');
        setState(() {
          idToCall = socketIds[widget.clientId];
        });
      });

      socket?.on('error', (data) {
        log('Socket error: $data');
        CustomPopUp.showSnackBar(context, "Socket error occurred", Colors.red);
      });

      socket?.on('callUser', (signal)async{
        log('callUser$signal');
        if(signal['signal'].toString().isEmpty){
          CustomPopUp.showSnackBar(
            context,
            "Receiving Call",
            Colors.greenAccent,
            child: IconButton(
              onPressed: _answerCall,
              icon: const Icon(Icons.call_rounded, color: Colors.green),
            ),
          );
          return;
        }

        if(signal['signal']!=null && signal['signal']['offer']!=null){
          await _setRemoteDescription(signal['signal']['offer']);
          _createAnswer((answer){
            socket?.emit('answerCall', {
              'signal':{'answer':answer.toMap()},
              'to': idToCall,
            });
          });
        }

        if (signal['signal'] != null && signal['signal']['candidate'] != null) {
          log('$signal Signal Data');
          final candidate = signal['signal']['candidate'];
          await _peerConnection.addCandidate(RTCIceCandidate(
            candidate['candidate'],
            candidate['sdpMid'],
            candidate['sdpMLineIndex'],
          ));
        }

      });

      socket?.on('callAccepted', (signal)async{
        log('callAccepted$signal');

        if(signal!=null && signal=='Accepted_Call'){
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
              'name': widget.clientId,
              'userToCall': idToCall,
            });
          });

          await _createOffer((offer){
            socket?.emit('callUser', {
              'signalData':{'offer':offer.toMap()},
              'userToCall':idToCall
            });
          });
        }

        if(signal!=null && signal!='Accepted_Call' && signal['answer']!=null){
          _setRemoteDescription(signal['answer']);
        }

        if(signal!=null && signal!='Accepted_Call' && signal['candidate']!=null){
          final candidate=signal['candidate'];
          await _peerConnection.addCandidate(
              RTCIceCandidate(
            candidate['candidate'],
            candidate['sdpMid'],
            candidate['sdpMLineIndex'],
          ));
        }

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
      'video': true,
      'audio': false,
    });

    localRenderer.srcObject = localStream;
    _peerConnection = await createPeerConnection(configuration);

    localStream?.getTracks().forEach((track) {
      _peerConnection.addTrack(track, localStream!);
    });
    _peerConnection.onIceCandidate = onIceCandidate;

    _peerConnection.onAddStream = (stream) {
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
    // Send the SDP offer to the other user
    socket?.emit('callUser', {
      'userToCall': idToCall,
      'signalData': '',
      'from': userId,
      'name': widget.clientId,
    });
  }


  void _answerCall() async {

    socket?.emit('answerCall', {
      'signal':'Accepted_Call',
      'to': idToCall,
    });

    _createPeerConnection((candidate){
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

  }

  void _endCall() {
    setState(() {
      callAccepted = false;
      callEnded = true;
    });

    socket?.emit('endCall', {'to': idToCall});
  }

  void _toggleMute() {
    if (localStream != null) {
      localStream?.getAudioTracks().forEach((track) {
        track.enabled = !track.enabled;
      });
      setState(() {
        isMuted = !isMuted;
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
    }
  }

  @override
  void dispose() {
    localRenderer.dispose();
    remoteRenderer.dispose();
    _peerConnection.close();
    socket?.dispose();  // Dispose the socket connection
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call with ${widget.clientId}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Transform.flip(
              flipX: true,
              child: RTCVideoView(localRenderer),
            ),
          ),
          Expanded(
            child: RTCVideoView(remoteRenderer),
          ),
          if (callAccepted && !callEnded)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(isMuted ? Icons.mic_off : Icons.mic),
                  onPressed: _toggleMute,
                ),
                IconButton(
                  icon: Icon(isVideoOff ? Icons.videocam_off : Icons.videocam),
                  onPressed: _toggleVideo,
                ),
                IconButton(
                  icon: Icon(Icons.call_end),
                  onPressed: _endCall,
                  color: Colors.red,
                ),
              ],
            ),
          if (!callAccepted && !callEnded)
            ElevatedButton(
              onPressed: _callUser,
              child: Text("Call $idToCall"),
            ),
        ],
      ),
    );
  }

  Future<void> _createOffer(Function(RTCSessionDescription offer) onOffer) async {
    final offer = await _peerConnection.createOffer();
    await _peerConnection.setLocalDescription(offer);
    onOffer(offer);
    log('offer created');
  }

  Future<void> _createAnswer(Function(RTCSessionDescription answer) onAnswer) async {
    final answer = await _peerConnection.createAnswer();
    await _peerConnection.setLocalDescription(answer);
    log('answer created');
    onAnswer(answer);
  }

  Future<void> _setRemoteDescription(Map<String, dynamic> data) async {
    final remoteDescription = RTCSessionDescription(
      data['sdp'],
      data['type'],
    );
    await _peerConnection.setRemoteDescription(remoteDescription);
  }

}

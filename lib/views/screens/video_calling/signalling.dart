import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebRTCService {
  late RTCPeerConnection _peerConnection;
  late IO.Socket _socket;
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  WebRTCService() {
    _initializeRenderers();
    _initializeSocket();
  }

  Future<void> _initializeRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  void _initializeSocket() {
    _socket = IO.io('http://your-server-url', <String, dynamic>{
      'transports': ['websocket'],
    });

    _socket.on('connect', (_) => print('Connected to signaling server'));

    _socket.on('offer', (data) async {
      await _setRemoteDescription(data);
      await _createAnswer();
    });

    _socket.on('answer', (data) async {
      await _setRemoteDescription(data);
    });

    _socket.on('ice-candidate', (data) async {
      await _peerConnection.addCandidate(RTCIceCandidate(
        data['candidate'],
        data['sdpMid'],
        data['sdpMLineIndex'],
      ));
    });
  }

  Future<void> startCall() async {
    await _createPeerConnection();
    await _createOffer();
  }

  Future<void> _createPeerConnection() async {
    _peerConnection = await createPeerConnection({
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ]
    });

    _peerConnection.onIceCandidate = (candidate) {
      _socket.emit('ice-candidate', {
        'candidate': candidate.candidate,
        'sdpMid': candidate.sdpMid,
        'sdpMLineIndex': candidate.sdpMLineIndex,
      });
    };

    _peerConnection.onTrack = (event) {
      if (event.track.kind == 'video') {
        _remoteRenderer.srcObject = event.streams[0];
      }
    };

    // Get local stream
    final localStream = await navigator.mediaDevices.getUserMedia({
      'video': true,
      'audio': false,
    });
    _localRenderer.srcObject = localStream;

    // Add local stream to peer connection
    localStream.getTracks().forEach((track) {
      _peerConnection.addTrack(track, localStream);
    });
  }

  Future<void> _createOffer() async {
    final offer = await _peerConnection.createOffer();
    await _peerConnection.setLocalDescription(offer);
    _socket.emit('offer', offer.toMap());
  }

  Future<void> _createAnswer() async {
    final answer = await _peerConnection.createAnswer();
    await _peerConnection.setLocalDescription(answer);
    _socket.emit('answer', answer.toMap());
  }

  Future<void> _setRemoteDescription(Map<String, dynamic> data) async {
    final remoteDescription = RTCSessionDescription(
      data['sdp'],
      data['type'],
    );
    await _peerConnection.setRemoteDescription(remoteDescription);
  }

  Future<void> dispose() async {
    await _localRenderer.dispose();
    await _remoteRenderer.dispose();
    await _peerConnection.close();
    _socket.dispose();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIoExample extends StatefulWidget {
  @override
  _SocketIoExampleState createState() => _SocketIoExampleState();
}

class _SocketIoExampleState extends State<SocketIoExample> {
  IO.Socket? socket;
  String receivedMessage = ''; // State variable to hold received data

  @override
  void initState() {
    super.initState();
    initializeSocket();
  }

  void initializeSocket() {
    // Initialize the socket connection
    socket = IO.io('http://localhost:8000', IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect()  // Optional, disable auto-connect
        .build());

    // Connect to the server
    socket!.connect();

    // Listen for connection event
    socket!.on('connect', (_) {
      print('Connected to the server');
      // Emit the `getsetId` event once connected
      socket!.emit('joinRoom',{'clientId':"cm1x5yjs10000qznrztks3tg2","doctorId":"cm1uq5u8s0000fy9bm7sogayz"});
    });

    // Listen for any responses from the server
    socket!.on('joinRoom', (data) {
      print('Received message: $data');
      setState(() {
        receivedMessage = data.toString();  // Update state with the received data
      });
    });

    socket!.on('receivedMessage', (data) {
      print('Received message: $data');
      setState(() {
        receivedMessage = data.toString();  // Update state with the received data
      });
    });

    socket!.on('conversationId', (data) {
      print('Received message: $data');
      setState(() {
        receivedMessage = data.toString();  // Update state with the received data
      });
    });

    socket!.on('previousMessages', (data) {
      print('Received message: $data');
      setState(() {
        receivedMessage = data.toString();  // Update state with the received data
      });
    });


    // Handle disconnection
    socket!.on('error', (_) {
      print(_);
      print('Disconnected from the server');
    });
  }

  @override
  void dispose() {
    socket?.dispose(); // Close the socket connection when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Socket.IO Example'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                 final data= {
                    "conversationType": "PRIVATE",
                  "conversationId": "cm1uxk6g000003yrdxus4lc63",
                  "senderId": "cm1uq5u8s0000fy9bm7sogayz",
                  "message": "Heyy",
                   "roomId":" room_cm1uq5u8s0000fy9bm7sogayz_cm1x5yjs10000qznrztks3tg2"
                };
                 socket?.emit("sendMessage",data);
                },
                child: Text('Join Room'),
              ),
              SizedBox(height: 20),
              Text(
                'Received Message:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                receivedMessage,  // Display the received message
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

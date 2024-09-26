import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/models/chat/ContactInfo.dart';
import 'package:kaustubha_medtech/models/chat/MessageModel.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
import 'package:kaustubha_medtech/views/widgets/chat_bubble.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PatientChatScreen extends StatefulWidget {
  @override
  _PatientChatScreenState createState() => _PatientChatScreenState();
}

class _PatientChatScreenState extends State<PatientChatScreen> {
  IO.Socket? socket;
  String receivedMessage = '';
  ContactInfo contactInfo=ContactInfo();
  List<MessageModel> messages=[];
  bool loader=true;
  TextEditingController message=TextEditingController();
  String conversationId='';
  Widget? sendingMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getClientData();
    });
  }

  void initializeSocket(String userId,String clientId) {
    // Initialize the socket connection
    socket = IO.io('wss://mtapi.adarsh.tech', IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect()  // Optional, disable auto-connect
        .build());
    print('init');

    // Connect to the server
    socket!.connect();

    // Listen for connection event
    socket!.on('connect', (_) {
      socket!.emit('joinRoom',{'clientId':userId,"doctorId":clientId});
    });

    // Listen for any responses from the server
    socket!.on('joinRoom', (data) {

    });

    socket!.on('receivedMessage', (data) {
      if(data!=null){
        messages.insert(0,MessageModel.fromJson(data));
        sendingMessage=null;
        setState(() {});
      }
    });

    socket!.on('conversationId', (data) {
      setState(() {
        conversationId = data.toString();  // Update state with the received data
      });
    });

    socket!.on('previousMessages', (data) {
      if(data!=null && data['message']!=null){
        final _messages = data['message'] as List;
        for (var i = _messages.length - 1; i >= 0; i--) {
          messages.add(MessageModel.fromJson(_messages[i]));
        }

        loader=false;
        setState(() {});
      }
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
        elevation: 0,
        title: Text(
          contactInfo.doctorName ?? "",
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: !loader ? messages.isEmpty ? Center(
        child: Text(
          "No Messages Found",
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
      ) : Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.zero,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                MessageModel messageModel = messages[index];
                return card(
                  margin: index == 0
                      ? EdgeInsets.only(right: 10.w, left: 10.w, top: 5.h)
                      : null,
                  messageModel.content.toString(),
                  messageModel.senderId == contactInfo.userId,
                  messageModel.createdAt.toString(),
                );
              },
            ),
          ),
          sendingMessage ?? const SizedBox(height: 0,),
          SizedBox(height: 100.h), // Add space below the ListView
        ],
      )
          : const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(bottom: 30.h, right: 8.w, left: 8.w, top: 8.h),
        color: Colors.white,
        child: CustomTextField(
          hintText: "Enter Message",
          includeSpacing: true,
          textEditingController: message,
          outlinedBorder: true,
          border: InputBorder.none,
          suffix: SizedBox(
            width: 0.15.sw,
            child: Row(
              children: [
                InkWell(
                  child: Icon(
                    CupertinoIcons.paperclip,
                    size: 20.sp,
                  ),
                  onTap: () {},
                ),
                SizedBox(width: 8.w),
                InkWell(
                  child: Icon(
                    Icons.send,
                    size: 20.sp,
                  ),
                  onTap: sendMessage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget card(String message, bool isSender, String date,{EdgeInsets? margin}) {
    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 0.5.sw,
          minWidth: 0.3.sw// Set the maximum width
        ),
        child: ClipPath(
          clipper: isSender ? ChatBubbleClipperSender() : ChatBubbleClipperReceiver(),
          child: Container(
            padding: EdgeInsets.all(8.sp),
            margin:margin ?? EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            decoration: BoxDecoration(
              color: isSender ? AppColors.primaryColor : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: GoogleFonts.dmSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isSender ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 5.h), // Add some space between message and date
                Align(
                  alignment: Alignment.centerRight, // Align date to the right
                  child: Text(
                    Constants.dateConverted(date),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getClientData(){
    Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
    if(data!=null){
      contactInfo=ContactInfo.fromJson(data);
      setState(() {});
      initializeSocket(contactInfo.userId.toString(), contactInfo.doctorId.toString());
    }
  }

  void sendMessage(){
    final data= {
      "conversationType": "PRIVATE",
      "conversationId": conversationId,
      "senderId": contactInfo.userId,
      "message": message.text,
      "roomId":"room_${contactInfo.doctorId}_${contactInfo.userId}"
    };
    socket?.emit("sendMessage",data);
    sendingMessage=sendingTextWidget(message.text, true, DateTime.now().toString());
    message.text='';
    setState(() {});
  }

  Widget sendingTextWidget(String message,bool isSender,String date){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        card(message, isSender, date),
        Icon(CupertinoIcons.circle,color: AppColors.primaryColor,)
      ],
    );
  }


}

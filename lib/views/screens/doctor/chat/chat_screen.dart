import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/views/screens/video_calling/video_call.dart';
import 'package:kaustubha_medtech/views/widgets/file_viewer_modal.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/repo/chat-repo/chat_repo.dart';
import 'package:kaustubha_medtech/models/chat/ContactInfo.dart';
import 'package:kaustubha_medtech/models/chat/MessageModel.dart';
import 'package:kaustubha_medtech/models/connectivity/error_model.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
import 'package:kaustubha_medtech/views/widgets/chat_bubble.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../alerts/custom_alerts.dart';

class DoctorChatScreen extends StatefulWidget {
  @override
  _DoctorChatScreenState createState() => _DoctorChatScreenState();
}

class _DoctorChatScreenState extends State<DoctorChatScreen> {
  IO.Socket? userSocket;
  String receivedMessage = '';
  ContactInfo contactInfo=ContactInfo();
  List<MessageModel> messages=[];
  bool loader=true;
  TextEditingController message=TextEditingController();
  String conversationId='';
  Widget? sendingMessage;
  ChatRepo chatRepo=ChatRepo();
  ScrollController scrollController=ScrollController();
  DateTime dateTime=DateTime.now();
  String roomId='';
  UserInfo? user;
  FocusNode messageFocus=FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getClientData();
    });
  }



  void initializeSocket(String userId,String clientId) {
    // Initialize the socket connection
    userSocket = IO.io('https://chatapi.kaustubhamedtech.com', IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect()  // Optional, disable auto-connect
        .build());

    // Connect to the server
    userSocket!.connect();

    // Listen for connection event
      userSocket!.emit('joinRoom',{'clientId':userId,"doctorId":clientId});
      userSocket!.emit('joinRoom',{'clientId':clientId,"doctorId":userId});

    // Listen for any responses from the server
    userSocket!.on('joinRoom', (data) {

    });

    userSocket!.on('receivedMessage', (data) {
      print(data);
      if(data!=null){
        messages.insert(0,MessageModel.fromJson(data));
        sendingMessage=null;
        scrollToBottom();
        setState(() {});
      }
    });

    userSocket!.on('conversationId', (data) {
      setState(() {
        conversationId = data.toString();  // Update state with the received data
      });
    });

    userSocket!.on('previousMessages', (data) {
      if (data != null && messages.isEmpty) {
        final _messages = data['message'] as List;
        for (var i = _messages.length - 1; i >= 0; i--) {
          messages.add(MessageModel.fromJson(_messages[i]));
        }
        loader = false;
        setState(() {});
        scrollToBottom();
      }
    });
    // Handle disconnection
    userSocket!.on('error', (_) {
      print(_);
      print('Disconnected from the server');
    });
  }


  @override
  void dispose() {
    super.dispose();
  }

  bool get isPatient => user?.role==Constants.patientRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(onTap: ()=>Navigator.pop(context), child: Icon(Icons.arrow_back,color: Colors.black,size: 20.sp,)),
        title: Text(
          (isPatient? contactInfo.doctorName:contactInfo.name) ?? "",
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            color: AppColors.primaryColor,
          ),
        ),
        actions: [
          IconButton(onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideoCallScreen(clientId: (user?.role==Constants.patientRole?contactInfo.doctorId : contactInfo.userId) ?? "")));
          }, icon: Icon(CupertinoIcons.video_camera_solid,color: AppColors.primaryColor,size: 20.sp,))
        ],
      ),
      body: !loader ? messages.isEmpty && sendingMessage==null? Center(
        child: Text(
          "No Messages Found",
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
      ) : SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Visibility(
              visible: messages.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getDate(DateTime.parse(messages.isNotEmpty? messages.last.createdAt ?? DateTime.now().toString():DateTime.now().toString())),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    // Continue with your message widget below this
                  ],
                ),
              ),
            ),
            SizedBox(
              child: ListView.separated(
                separatorBuilder: (context, i) {
                  MessageModel message = messages[i];
                  DateTime currentMessageDate = DateTime.parse(message.createdAt ?? DateTime.now().toString());
                  DateTime? nextMessageDate;
                  if (i < messages.length - 1) {
                    MessageModel nextMessage = messages[i + 1];
                    nextMessageDate = DateTime.parse(nextMessage.createdAt ?? DateTime.now().toString());
                  }
                  bool shouldShowDate = i == messages.length - 1 || nextMessageDate == null ||
                      currentMessageDate.day != nextMessageDate.day ||
                      currentMessageDate.month != nextMessageDate.month ||
                      currentMessageDate.year != nextMessageDate.year;
                  return shouldShowDate? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                getDate(currentMessageDate),
                                style: GoogleFonts.dmSans(color: Colors.grey),
                              ),
                            ],
                          ),
                        // Continue with your message widget below this// This can be replaced with the actual message widget
                      ],
                    ),
                  ): SizedBox();
                },
                reverse: true,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  MessageModel messageModel = messages[index];
                  if(messageModel.filePath!=null){
                    return fileView(
                        margin: index == 0
                            ? EdgeInsets.only(right: 10.w, left: 10.w, top: 5.h)
                            : null,
                        messageModel.filePath,
                        messageModel.senderId==(isPatient? contactInfo.userId:contactInfo.doctorId),
                        messageModel.createdAt ?? DateTime.now().toString());
                  }
                  return textCard(
                    margin: index == 0
                        ? EdgeInsets.only(right: 10.w, left: 10.w, top: 5.h)
                        : null,
                    messageModel.content.toString(),
                    messageModel.senderId == (isPatient? contactInfo.userId:contactInfo.doctorId),
                    messageModel.createdAt.toString(),
                  );
                },
              ),
            ),
            sendingMessage ?? SizedBox(height: 0,),
            SizedBox(height: 90.h), // Add space below the ListView
          ],
        ),
      )
          : const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 30.h, right: 8.w, left: 8.w),
        child: CustomTextField(
          hintText: "Enter Message",
          includeSpacing: true,
          textEditingController: message,
          outlinedBorder: true,
          border: InputBorder.none,
          textInputAction: TextInputAction.send,
          focusNode: messageFocus,
          onEditingCompleted: sendMessage,
          suffix: SizedBox(
            width: 0.15.sw,
            child: Row(
              children: [
                InkWell(
                  child: Icon(
                    CupertinoIcons.paperclip,
                    size: 20.sp,
                  ),
                  onTap: selectFile,
                ),
                SizedBox(width: 8.w),
                InkWell(
                  onTap: sendMessage,
                  child: Icon(
                    Icons.send,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textCard(String message, bool isSender, String date,{EdgeInsets? margin}) {
    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: 0.7.sw,
        ),
        child: FittedBox(
          child: Container(
            padding: EdgeInsets.all(8.sp),
            margin:margin ?? EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            decoration: BoxDecoration(
              color: isSender ? AppColors.primaryColor : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      message,
                      style: GoogleFonts.dmSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: isSender ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 50.w,
                    ),
                  ],
                ),
                SizedBox(height: 5.h), // Add some space between message and date
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12.sp),
                      child: Text(
                        Constants.timeConverted(date),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fileView(String filePath,bool isSender,String date,{EdgeInsets? margin,File? localFile}) {
    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: InkWell(
        onTap: (){
          if(localFile==null){
             FileViewerModal.showNetworkFilePopUp(context, filePath);
          }
        },
        child: Container(
          constraints: BoxConstraints(
              maxWidth: 0.7.sw,
          ),
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
                Visibility(
                  visible:!filePath.toString().endsWith('.pdf'),
                  child: Container(
                    height: 100.h,
                    width: 0.7.sw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      border: Border.all(color: Colors.white,width: 2.w)
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.sp),
                        child: localFile!=null?Image.file(localFile,width: 0.7.sw,fit: BoxFit.cover,):
                        Image.network(filePath,width: 0.7.sw,fit: BoxFit.cover,)),
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: localFile==null,
                      child: Visibility(
                        visible: isSender,
                        child: Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Icon(Icons.folder_rounded,color: isSender? Colors.white:Colors.black,size: 20.sp,),
                        ),
                      ),
                    ),
                    SizedBox(width:localFile==null && isSender? 4.w:0,),
                    Expanded(
                      child: Text(path.basename(filePath),style: GoogleFonts.dmSans( fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: isSender ? Colors.white : Colors.black,),),
                    ),
                    SizedBox(width:!isSender? 4.w:0,),
                    Visibility(
                      visible: !isSender,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Icon(Icons.folder_rounded,color: isSender? Colors.white:Colors.black,size: 20.sp,),
                      ),
                    ),
                  ],
                ),// Add some space between message and date
                SizedBox(height: 5.h), // Add some space between message and date
                Align(
                  alignment: Alignment.centerRight, // Align date to the right
                  child: Text(
                    Constants.timeConverted(date.toString()),
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

  void getClientData()async{
    Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
     user=await LocalDB.getUserInfo();
    if(data!=null){
      contactInfo=ContactInfo.fromJson(data);
      setState(() {});
      if(user?.role==Constants.patientRole){
        roomId="room_${contactInfo.userId}_${contactInfo.doctorId}";
        initializeSocket(contactInfo.userId.toString(),contactInfo.doctorId.toString());
        setState(() {});
      }else {
        roomId="room_${contactInfo.doctorId}_${contactInfo.userId}";
        initializeSocket(contactInfo.doctorId.toString(), contactInfo.userId.toString());
        setState(() {});
      }
      print(roomId);
    }
  }

  void sendMessage(){
    if(message.text.isEmpty ){
      if(messageFocus.hasFocus) {
        messageFocus.unfocus();
      }
      return;
    }
    final data= {
      "conversationType": "PRIVATE",
      "conversationId": conversationId,
      "senderId": isPatient?contactInfo.userId:contactInfo.doctorId,
      "message": message.text,
      'roomId':roomId
    };
    userSocket?.emit("sendMessage",data);
    sendingMessage=sendingTextWidget(message.text, true, DateTime.now().toString());
    message.text='';
    setState(() {});
    scrollToBottom();
  }

  void sendFile(String file){
    final data= {
      "message":"",
      "conversationType": "PRIVATE",
      "conversationId": conversationId,
      "senderId": isPatient?contactInfo.userId:contactInfo.doctorId,
      "roomId": roomId,
      "fileName":path.basename(file),
      "filePath":file,
    };
    userSocket?.emit("sendMessage",data);
    scrollToBottom();
    setState(() {});
  }

  Widget sendingTextWidget(String message,bool isSender,String date){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        textCard(message, isSender, date),
        Icon(Icons.schedule_send_outlined,color: AppColors.primaryColor,)
      ],
    );
  }

  Widget sendingFileWidget(File file){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        fileView(file.path,true,DateTime.now().toString(),localFile: File(file.path)),
        Icon(Icons.schedule_send_outlined,color: AppColors.primaryColor,)
      ],
    );
  }

  void selectFile()async{
    late PermissionStatus permission;
    if(Platform.isAndroid){
      permission = await Permission.storage.request();
    }else{
      permission = await Permission.photos.request();
    }
    if (permission.isDenied) {
      CustomPopUp.showSnackBar(context, 'Access Denied', Colors.red);
      return;
    }
    final image = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['pdf','jpg','png']);
    if (image != null) {
      print('image');
      File file = File(image.files.first.path ?? "");
      setState(() {
        sendingMessage=sendingFileWidget(file);
      });
      scrollToBottom();
      File? compressedImage= await Constants.compressFile(file);
      if(compressedImage!=null){
        final filePath=await fileUpload(file);
        if(filePath==null){
          sendingMessage=null;
        }else{
          sendFile(filePath);
        }
        setState(() {});
      }else{
        sendingMessage=null;
        setState(() {});
        CustomPopUp.showSnackBar(context, 'Unable to Compress Image', Colors.redAccent);
      }
    }
  }

  Future<String?> fileUpload(File file)async{
    try{
      final resp=await chatRepo.uploadFile(file);
         print(resp.response?.data);
          if(resp.response?.statusCode==200 && resp.response?.data!=null){
            final response=ResponseMessage.fromJson(resp.response?.data);
            if(response.filePath!=null){
              return response.filePath.toString();
            }else{
              CustomPopUp.showSnackBar(context, "Unable to Upload File", Colors.redAccent);
              return null;
            }
          }else{
            CustomPopUp.showSnackBar(context, "Unable to Upload File", Colors.redAccent);
            return null;
          }
    }catch(e){
      CustomPopUp.showSnackBar(context, "Unable to Upload File", Colors.redAccent);
      return null;
    }
  }


  void scrollToBottom(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);  // Scroll to the top
      }
    });
  }

  String getDate(DateTime date){
    if(!DateTime.now().isAfter(date) && !DateTime.now().isBefore(date)){
      return "Today";
    }
    return DateFormat('MMM dd yyyy').format(date);
  }
}

import 'package:kaustubha_medtech/models/user/user_info.dart';

class ResponseMessage{
  String? error;
  dynamic success;
  dynamic user;
  String? message;
  bool? status;
  dynamic data;
  dynamic reviews;
  dynamic doctor;
  dynamic filePath;
  ResponseMessage({this.success, this.error,this.message,this.status,this.data});

  ResponseMessage.fromJson(dynamic json){
    error = json["error"];
    success = json["success"];
    status = json["status"];
    message = json["message"];
    user = json["user"];
    data=json['data'];
    doctor=json['doctor'];
    reviews=json['reviews'];
    filePath=json['url'];
  }
}
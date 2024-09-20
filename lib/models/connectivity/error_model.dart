import 'package:kaustubha_medtech/models/user/user_info.dart';

class ResponseMessage{
  String? error;
  String? success;
  UserInfo? user;
  String? message;
  bool? status;
  ResponseMessage({this.success, this.error,this.message,this.status});

  ResponseMessage.fromJson(dynamic json){
    error = json["error"];
    success = json["success"];
    status = json["status"];
    message = json["message"];
    if(json['user']!=null) {
      user = UserInfo.fromJson(json["user"]);
    }
  }
}
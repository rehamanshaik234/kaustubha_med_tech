import 'package:kaustubha_medtech/models/user/user_info.dart';

class ResponseMessage{
  String? error;
  dynamic success;
  UserInfo? user;
  String? message;
  bool? status;
  dynamic data;
  ResponseMessage({this.success, this.error,this.message,this.status,this.data});

  ResponseMessage.fromJson(dynamic json){
    error = json["error"];
    success = json["success"];
    status = json["status"];
    message = json["message"];
    if(json['user']!=null) {
      user = UserInfo.fromJson(json["user"]);
    }
    data=json['data'];
  }
}
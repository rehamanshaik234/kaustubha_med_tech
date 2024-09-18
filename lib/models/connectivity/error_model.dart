import 'package:kaustubha_medtech/models/user/user_info.dart';

class ResponseMessage{
  String? error;
  String? success;
  UserInfo? user;
  ResponseMessage({this.success, this.error});

  ResponseMessage.fromJson(dynamic json){
    error = json["error"];
    success = json["success"];
    if(json['user']!=null) {
      user = UserInfo.fromJson(json["user"]);
    }
  }
}
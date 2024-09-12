class ResponseMessage{
  String? error;
  String? success;
  String? email;
  ResponseMessage({this.success, this.error});

  ResponseMessage.fromJson(dynamic json){
    error = json["error"];
    success = json["success"];
    email = json["email"];
  }
}
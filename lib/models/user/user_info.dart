import 'package:kaustubha_medtech/models/patient_document/PatientDocuments.dart';

class UserInfo {
  static const String userIdKey = 'id';
  static const String userNameKey = 'name';
  static const String userEmailKey = 'email';
  static const String userEmailVerifiedKey = 'emailVerified';
  static const String userPasswordKey = 'password';
  static const String userRoleKey = 'role';
  static const String userPhoneKey = 'phone';
  static const String userNumberVerifiedKey = 'numberVerified';
  static const String userImageKey = 'image';
  static const String userAboutKey = 'about';
  static const String socketKey = 'socket_id';
  static const String patientReportsDocKey = 'patientReportsDoc';

  UserInfo({
    String? id,
    String? name,
    String? email,
    String? emailVerified,
    String? password,
    String? role,
    String? phone,
    bool? numberVerified,
    dynamic image,
    dynamic about,
    PatientDocumentsModel? documentModel,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _emailVerified = emailVerified;
    _password = password;
    _role = role;
    _phone = phone;
    _numberVerified = numberVerified;
    _image = image;
    _about = about;
    _documentsModel=documentModel;
  }

  UserInfo.fromJson(dynamic json) {
    _id = json[userIdKey];
    _name = json[userNameKey];
    _email = json[userEmailKey];
    _emailVerified = json[userEmailVerifiedKey];
    _password = json[userPasswordKey];
    _role = json[userRoleKey];
    _phone = json[userPhoneKey];
    _numberVerified = json[userNumberVerifiedKey];
    _image = json[userImageKey];
    _about = json[userAboutKey];
    _socket = json[socketKey];
    if(json['patientReportsDoc']!=null){
      _documentsModel=PatientDocumentsModel.fromJson(json['patientReportsDoc']);
    }
  }

  String? _id;
  String? _name;
  String? _email;
  String? _emailVerified;
  String? _password;
  String? _role;
  String? _phone;
  bool? _numberVerified;
  dynamic _image;
  dynamic _about;
  dynamic _socket;
  PatientDocumentsModel? _documentsModel;

  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get emailVerified => _emailVerified;
  String? get password => _password;
  String? get role => _role;
  String? get phone => _phone;
  bool? get numberVerified => _numberVerified;
  dynamic get image => _image;
  dynamic get about => _about;
  dynamic get socket => _socket;
  PatientDocumentsModel? get documentsModel => _documentsModel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[userIdKey] = _id;
    map[userNameKey] = _name;
    map[userEmailKey] = _email;
    map[userEmailVerifiedKey] = _emailVerified;
    map[userPasswordKey] = _password;
    map[userRoleKey] = _role;
    map[userPhoneKey] = _phone;
    map[userNumberVerifiedKey] = _numberVerified;
    map[userImageKey] = _image;
    map[userAboutKey] = _about;
    map[socketKey] = _socket;
    if(_documentsModel!=null){
    map[patientReportsDocKey]=_documentsModel?.toJson();
    }
    return map;
  }
}

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
  static const String userCityKey = 'city';
  static const String userStateKey = 'state';
  static const String userGenderKey = 'gender';
  static const String userCountryKey = 'country';
  static const String userAgeKey = 'age';

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
    String? city,
    String? state,
    String? gender,
    String? country,
    String? age,
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
    _documentsModel = documentModel;
    _city = city;
    _state = state;
    _gender = gender;
    _country = country;
    _age = age;
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
    if (json[patientReportsDocKey] != null) {
      _documentsModel = PatientDocumentsModel.fromJson(json[patientReportsDocKey]);
    }
    _city = json[userCityKey];
    _state = json[userStateKey];
    _gender = json[userGenderKey];
    _country = json[userCountryKey];
    _age = json[userAgeKey];
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
  String? _city;
  String? _state;
  String? _gender;
  String? _country;
  String? _age;

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
  String? get city => _city;
  String? get state => _state;
  String? get gender => _gender;
  String? get country => _country;
  String? get age => _age;

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
    if (_documentsModel != null) {
      map[patientReportsDocKey] = _documentsModel?.toJson();
    }
    map[userCityKey] = _city;
    map[userStateKey] = _state;
    map[userGenderKey] = _gender;
    map[userCountryKey] = _country;
    map[userAgeKey] = _age;
    return map;
  }
}


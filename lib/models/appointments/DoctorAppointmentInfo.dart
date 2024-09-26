import '../patient_document/PatientDocuments.dart';

class DoctorAppointmentInfo {
  DoctorAppointmentInfo({
      String? id, 
      String? name, 
      String? email, 
      String? password, 
      String? role, 
      String? phone, 
      bool? numberVerified, 
      String? image, 
      dynamic about, 
      String? emailVerified, 
      dynamic socketId,
    PatientDocumentsModel? patientReportsDoc,}){
    _id = id;
    _name = name;
    _email = email;
    _password = password;
    _role = role;
    _phone = phone;
    _numberVerified = numberVerified;
    _image = image;
    _about = about;
    _emailVerified = emailVerified;
    _socketId = socketId;
    _patientReportsDoc = patientReportsDoc;
}

  DoctorAppointmentInfo.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _password = json['password'];
    _role = json['role'];
    _phone = json['phone'];
    _numberVerified = json['numberVerified'];
    _image = json['image'];
    _about = json['about'];
    _emailVerified = json['emailVerified'];
    _socketId = json['socket_id'];
    _patientReportsDoc = json['patientReportsDoc'] != null ? PatientDocumentsModel.fromJson(json['patientReportsDoc']) : null;
  }
  String? _id;
  String? _name;
  String? _email;
  String? _password;
  String? _role;
  String? _phone;
  bool? _numberVerified;
  String? _image;
  dynamic _about;
  String? _emailVerified;
  dynamic _socketId;
  PatientDocumentsModel? _patientReportsDoc;
DoctorAppointmentInfo copyWith({  String? id,
  String? name,
  String? email,
  String? password,
  String? role,
  String? phone,
  bool? numberVerified,
  String? image,
  dynamic about,
  String? emailVerified,
  dynamic socketId,
  PatientDocumentsModel? patientReportsDoc,
}) => DoctorAppointmentInfo(  id: id ?? _id,
  name: name ?? _name,
  email: email ?? _email,
  password: password ?? _password,
  role: role ?? _role,
  phone: phone ?? _phone,
  numberVerified: numberVerified ?? _numberVerified,
  image: image ?? _image,
  about: about ?? _about,
  emailVerified: emailVerified ?? _emailVerified,
  socketId: socketId ?? _socketId,
  patientReportsDoc: patientReportsDoc ?? _patientReportsDoc,
);
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get password => _password;
  String? get role => _role;
  String? get phone => _phone;
  bool? get numberVerified => _numberVerified;
  String? get image => _image;
  dynamic get about => _about;
  String? get emailVerified => _emailVerified;
  dynamic get socketId => _socketId;
  PatientDocumentsModel? get patientReportsDoc => _patientReportsDoc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['password'] = _password;
    map['role'] = _role;
    map['phone'] = _phone;
    map['numberVerified'] = _numberVerified;
    map['image'] = _image;
    map['about'] = _about;
    map['emailVerified'] = _emailVerified;
    map['socket_id'] = _socketId;
    if (_patientReportsDoc != null) {
      map['patientReportsDoc'] = _patientReportsDoc?.toJson();
    }
    return map;
  }

}
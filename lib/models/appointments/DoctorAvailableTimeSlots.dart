class DoctorAvailableTimeSlots {
  DoctorAvailableTimeSlots({
      num? id,
      String? userId, 
      String? doctorId, 
      String? time, 
      String? date, 
      String? doctorName, 
      String? purpose, 
      String? reschedule, 
      String? status, 
      String? mode, 
      num? age, 
      String? name, 
      String? gender,}){
    _id = id;
    _userId = userId;
    _doctorId = doctorId;
    _time = time;
    _date = date;
    _doctorName = doctorName;
    _purpose = purpose;
    _reschedule = reschedule;
    _status = status;
    _mode = mode;
    _age = age;
    _name = name;
    _gender = gender;
}

  DoctorAvailableTimeSlots.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _doctorId = json['doctor_id'];
    _time = json['time'];
    _date = json['date'];
    _doctorName = json['doctorName'];
    _purpose = json['purpose'];
    _reschedule = json['reschedule'];
    _status = json['status'];
    _mode = json['mode'];
    _age = json['age'];
    _name = json['name'];
    _gender = json['gender'];
  }
  num? _id;
  String? _userId;
  String? _doctorId;
  String? _time;
  String? _date;
  String? _doctorName;
  String? _purpose;
  String? _reschedule;
  String? _status;
  String? _mode;
  num? _age;
  String? _name;
  String? _gender;

  num? get id => _id;
  String? get userId => _userId;
  String? get doctorId => _doctorId;
  String? get time => _time;
  String? get date => _date;
  String? get doctorName => _doctorName;
  String? get purpose => _purpose;
  String? get reschedule => _reschedule;
  String? get status => _status;
  String? get mode => _mode;
  num? get age => _age;
  String? get name => _name;
  String? get gender => _gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['doctor_id'] = _doctorId;
    map['time'] = _time;
    map['date'] = _date;
    map['doctorName'] = _doctorName;
    map['purpose'] = _purpose;
    map['reschedule'] = _reschedule;
    map['status'] = _status;
    map['mode'] = _mode;
    map['age'] = _age;
    map['name'] = _name;
    map['gender'] = _gender;
    return map;
  }

}
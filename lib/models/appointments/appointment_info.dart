class AppointmentInfo {
  AppointmentInfo({
    int? id,
    String? userId,
    String? doctorId,
    String? time,
    String? date,
    int? slot,
    String? doctorName,
    String? purpose,
    String? reschedule,
    String? status,
    String? mode,
    int? age,
    String? name,
    String? gender,
  }) {
    _id = id;
    _userId = userId;
    _doctorId = doctorId;
    _time = time;
    _date = date;
    _slot = slot;
    _doctorName = doctorName;
    _purpose = purpose;
    _reschedule = reschedule;
    _status = status;
    _mode = mode;
    _age = age;
    _name = name;
    _gender = gender;
  }

  AppointmentInfo.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _doctorId = json['doctor_id'];
    _time = json['time'];
    _date = json['date'];
    _slot = json['slot'];
    _doctorName = json['doctorName'];
    _purpose = json['purpose'];
    _reschedule = json['reschedule'];
    _status = json['status'];
    _mode = json['mode'];
    _age = json['age'];
    _name = json['name'];
    _gender = json['gender'];
  }

  int? _id;
  String? _userId;
  String? _doctorId;
  String? _time;
  String? _date;
  int? _slot;
  String? _doctorName;
  String? _purpose;
  String? _reschedule;
  String? _status;
  String? _mode;
  int? _age;
  String? _name;
  String? _gender;

  AppointmentInfo copyWith({
    int? id,
    String? userId,
    String? doctorId,
    String? time,
    String? date,
    int? slot,
    String? doctorName,
    String? purpose,
    String? reschedule,
    String? status,
    String? mode,
    int? age,
    String? name,
    String? gender,
  }) => AppointmentInfo(
    id: id ?? _id,
    userId: userId ?? _userId,
    doctorId: doctorId ?? _doctorId,
    time: time ?? _time,
    date: date ?? _date,
    slot: slot ?? _slot,
    doctorName: doctorName ?? _doctorName,
    purpose: purpose ?? _purpose,
    reschedule: reschedule ?? _reschedule,
    status: status ?? _status,
    mode: mode ?? _mode,
    age: age ?? _age,
    name: name ?? _name,
    gender: gender ?? _gender,
  );

  int? get id => _id;
  String? get userId => _userId;
  String? get doctorId => _doctorId;
  String? get time => _time;
  String? get date => _date;
  int? get slot => _slot;
  String? get doctorName => _doctorName;
  String? get purpose => _purpose;
  String? get reschedule => _reschedule;
  String? get status => _status;
  String? get mode => _mode;
  int? get age => _age;
  String? get name => _name;
  String? get gender => _gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['doctor_id'] = _doctorId;
    map['time'] = _time;
    map['date'] = _date;
    map['slot'] = _slot;
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

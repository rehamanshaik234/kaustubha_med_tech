class AppointmentInfo {
  AppointmentInfo({
    String? doctorName,
    String? doctorSpecialist,
    String? address,
    String? dateTime,
    num? reviewsCount,}){
    _doctorName = doctorName;
    _doctorSpecialist = doctorSpecialist;
    _address = address;
    _dateTime = dateTime;
    _reviewsCount = reviewsCount;
  }

  AppointmentInfo.fromJson(dynamic json) {
    _doctorName = json['doctor_name'];
    _doctorSpecialist = json['doctor_specialist'];
    _address = json['address'];
    _dateTime = json['ratings'];
    _reviewsCount = json['reviews_count'];
  }
  String? _doctorName;
  String? _doctorSpecialist;
  String? _address;
  String? _dateTime;
  num? _reviewsCount;
  AppointmentInfo copyWith({  String? doctorName,
    String? doctorSpecialist,
    String? address,
    String? dateTime,
    num? reviewsCount,
  }) => AppointmentInfo(  doctorName: doctorName ?? _doctorName,
    doctorSpecialist: doctorSpecialist ?? _doctorSpecialist,
    address: address ?? _address,
    dateTime: dateTime ?? _dateTime,
    reviewsCount: reviewsCount ?? _reviewsCount,
  );
  String? get doctorName => _doctorName;
  String? get doctorSpecialist => _doctorSpecialist;
  String? get address => _address;
  String? get dateTime => _dateTime;
  num? get reviewsCount => _reviewsCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['doctor_name'] = _doctorName;
    map['doctor_specialist'] = _doctorSpecialist;
    map['address'] = _address;
    map['ratings'] = _dateTime;
    map['reviews_count'] = _reviewsCount;
    return map;
  }

}
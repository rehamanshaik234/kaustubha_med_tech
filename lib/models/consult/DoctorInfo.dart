class DoctorInfo {
  DoctorInfo({
      String? doctorName, 
      String? doctorSpecialist, 
      String? address, 
      num? ratings, 
      num? reviewsCount,}){
    _doctorName = doctorName;
    _doctorSpecialist = doctorSpecialist;
    _address = address;
    _ratings = ratings;
    _reviewsCount = reviewsCount;
}

  DoctorInfo.fromJson(dynamic json) {
    _doctorName = json['doctor_name'];
    _doctorSpecialist = json['doctor_specialist'];
    _address = json['address'];
    _ratings = json['ratings'];
    _reviewsCount = json['reviews_count'];
  }
  String? _doctorName;
  String? _doctorSpecialist;
  String? _address;
  num? _ratings;
  num? _reviewsCount;
DoctorInfo copyWith({  String? doctorName,
  String? doctorSpecialist,
  String? address,
  num? ratings,
  num? reviewsCount,
}) => DoctorInfo(  doctorName: doctorName ?? _doctorName,
  doctorSpecialist: doctorSpecialist ?? _doctorSpecialist,
  address: address ?? _address,
  ratings: ratings ?? _ratings,
  reviewsCount: reviewsCount ?? _reviewsCount,
);
  String? get doctorName => _doctorName;
  String? get doctorSpecialist => _doctorSpecialist;
  String? get address => _address;
  num? get ratings => _ratings;
  num? get reviewsCount => _reviewsCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['doctor_name'] = _doctorName;
    map['doctor_specialist'] = _doctorSpecialist;
    map['address'] = _address;
    map['ratings'] = _ratings;
    map['reviews_count'] = _reviewsCount;
    return map;
  }

}
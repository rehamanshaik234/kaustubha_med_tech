class EnrollmentStatusModel {
  EnrollmentStatusModel({
      bool? profile, 
      bool? availability, 
      bool? liscense,}){
    _profile = profile;
    _availability = availability;
    _liscense = liscense;
}

  EnrollmentStatusModel.fromJson(dynamic json) {
    _profile = json['profile'];
    _availability = json['availability'];
    _liscense = json['liscense'];
  }
  bool? _profile;
  bool? _availability;
  bool? _liscense;
EnrollmentStatusModel copyWith({  bool? profile,
  bool? availability,
  bool? liscense,
}) => EnrollmentStatusModel(  profile: profile ?? _profile,
  availability: availability ?? _availability,
  liscense: liscense ?? _liscense,
);
  bool? get profile => _profile;
  bool? get availability => _availability;
  bool? get liscense => _liscense;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profile'] = _profile;
    map['availability'] = _availability;
    map['liscense'] = _liscense;
    return map;
  }

}
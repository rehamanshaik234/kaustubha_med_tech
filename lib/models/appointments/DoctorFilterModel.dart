class DoctorFilterModel {
  DoctorFilterModel({
      String? country, 
      String? experienceYears, 
      String? specialization, 
      String? state, 
      String? city, 
      String? qualification,}){
    _country = country;
    _experienceYears = experienceYears;
    _specialization = specialization;
    _state = state;
    _city = city;
    _qualification = qualification;
}

  DoctorFilterModel.fromJson(dynamic json) {
    _country = json['country'];
    _experienceYears = json['experienceYears'];
    _specialization = json['specialization'];
    _state = json['state'];
    _city = json['city'];
    _qualification = json['qualification'];
  }



  String? _country;
  String? _experienceYears;
  String? _specialization;
  String? _state;
  String? _city;
  String? _qualification;

DoctorFilterModel copyWith({  String? country,
  String? experienceYears,
  String? specialization,
  String? state,
  String? city,
  String? qualification,
  bool? resetSpecialisation,
  bool? resetCity,
  bool? resetQualification,
  bool? resetExp,
  bool? resetCountry,
  bool? resetState,
}) => DoctorFilterModel(
  country: resetCountry==true? null :country ?? _country,
  experienceYears: resetExp==true? null:experienceYears ?? _experienceYears,
  specialization:resetSpecialisation==true? null: (specialization ?? _specialization),
  state:resetState==true? null: state ?? _state,
  city: resetCity==true? null: city ?? _city,
  qualification: resetQualification==true? null: qualification ?? _qualification,
);
  String? get country => _country;
  String? get experienceYears => _experienceYears;
  String? get specialization => _specialization;
  String? get state => _state;
  String? get city => _city;
  String? get qualification => _qualification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if(_country!=null){
      map['country'] = _country;
    }
    if(_experienceYears!=null){
      map['experienceYears'] = _experienceYears;
    }
    if(_specialization!=null){
      map['specialization'] = _specialization;
    }
    if(_state!=null){
      map['state'] = _state;
    }
    if(_city!=null){
      map['city'] = _city;
    }
    if(_qualification!=null){
      map['qualification'] = _qualification;
    }
    return map;
  }

}
/// legalName : "Adarsh"
/// gender : "Male"
/// dateOfBirth : "12/12/2323"
/// qualification : "wer"
/// specialization : "wr"
/// subSpecialist : "wer"
/// experienceYears : "4"
/// consultationFees : "100"
/// address : "sdf"
/// country : "IN"
/// state : "efwe"
/// city : "fwef"
/// BookedAppointment : 0

class DoctorOfficialDetModel {
  DoctorOfficialDetModel({
      String? legalName, 
      String? gender, 
      String? dateOfBirth, 
      String? qualification, 
      String? specialization, 
      String? subSpecialist, 
      String? experienceYears, 
      String? consultationFees, 
      String? address, 
      String? country, 
      String? state, 
      String? city, 
      num? bookedAppointment,}){
    _legalName = legalName;
    _gender = gender;
    _dateOfBirth = dateOfBirth;
    _qualification = qualification;
    _specialization = specialization;
    _subSpecialist = subSpecialist;
    _experienceYears = experienceYears;
    _consultationFees = consultationFees;
    _address = address;
    _country = country;
    _state = state;
    _city = city;
    _bookedAppointment = bookedAppointment;
}

  DoctorOfficialDetModel.fromJson(dynamic json) {
    _legalName = json['legalName'];
    _gender = json['gender'];
    _dateOfBirth = json['dateOfBirth'];
    _qualification = json['qualification'];
    _specialization = json['specialization'];
    _subSpecialist = json['subSpecialist'];
    _experienceYears = json['experienceYears'];
    _consultationFees = json['consultationFees'];
    _address = json['address'];
    _country = json['country'];
    _state = json['state'];
    _city = json['city'];
    _bookedAppointment = json['BookedAppointment'];
  }
  String? _legalName;
  String? _gender;
  String? _dateOfBirth;
  String? _qualification;
  String? _specialization;
  String? _subSpecialist;
  String? _experienceYears;
  String? _consultationFees;
  String? _address;
  String? _country;
  String? _state;
  String? _city;
  num? _bookedAppointment;
DoctorOfficialDetModel copyWith({  String? legalName,
  String? gender,
  String? dateOfBirth,
  String? qualification,
  String? specialization,
  String? subSpecialist,
  String? experienceYears,
  String? consultationFees,
  String? address,
  String? country,
  String? state,
  String? city,
  num? bookedAppointment,
}) => DoctorOfficialDetModel(  legalName: legalName ?? _legalName,
  gender: gender ?? _gender,
  dateOfBirth: dateOfBirth ?? _dateOfBirth,
  qualification: qualification ?? _qualification,
  specialization: specialization ?? _specialization,
  subSpecialist: subSpecialist ?? _subSpecialist,
  experienceYears: experienceYears ?? _experienceYears,
  consultationFees: consultationFees ?? _consultationFees,
  address: address ?? _address,
  country: country ?? _country,
  state: state ?? _state,
  city: city ?? _city,
  bookedAppointment: bookedAppointment ?? _bookedAppointment,
);
  String? get legalName => _legalName;
  String? get gender => _gender;
  String? get dateOfBirth => _dateOfBirth;
  String? get qualification => _qualification;
  String? get specialization => _specialization;
  String? get subSpecialist => _subSpecialist;
  String? get experienceYears => _experienceYears;
  String? get consultationFees => _consultationFees;
  String? get address => _address;
  String? get country => _country;
  String? get state => _state;
  String? get city => _city;
  num? get bookedAppointment => _bookedAppointment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['legalName'] = _legalName;
    map['gender'] = _gender;
    map['dateOfBirth'] = _dateOfBirth;
    map['qualification'] = _qualification;
    map['specialization'] = _specialization;
    map['subSpecialist'] = _subSpecialist;
    map['experienceYears'] = _experienceYears;
    map['consultationFees'] = _consultationFees;
    map['address'] = _address;
    map['country'] = _country;
    map['state'] = _state;
    map['city'] = _city;
    map['BookedAppointment'] = _bookedAppointment;
    return map;
  }

}
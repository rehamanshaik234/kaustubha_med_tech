class DoctorInfo {
  DoctorInfo({
    String? doctorName,
    String? doctorSpecialist,
    String? address,
    num? ratings,
    num? reviewsCount,
    String? legalName,
    String? gender,
    String? dateOfBirth,
    String? country,
    String? state,
    String? city,
    String? qualification,
    int? bookedAppointment,
    String? specialization,
    String? subSpecialist,
    String? experienceYears,
    String? consultationFees,
  }) {
    _doctorName = doctorName;
    _doctorSpecialist = doctorSpecialist;
    _address = address;
    _ratings = ratings;
    _reviewsCount = reviewsCount;
    _legalName = legalName;
    _gender = gender;
    _dateOfBirth = dateOfBirth;
    _country = country;
    _state = state;
    _city = city;
    _qualification = qualification;
    _bookedAppointment = bookedAppointment;
    _specialization = specialization;
    _subSpecialist = subSpecialist;
    _experienceYears = experienceYears;
    _consultationFees = consultationFees;
  }

  DoctorInfo.fromJson(dynamic json) {
    _doctorName = json['doctor_name'];
    _doctorSpecialist = json['doctor_specialist'];
    _address = json['address'];
    _ratings = json['ratings'];
    _reviewsCount = json['reviews_count'];
    _legalName = json['legalName'];
    _gender = json['gender'];
    _dateOfBirth = json['dateOfBirth'];
    _country = json['country'];
    _state = json['state'];
    _city = json['city'];
    _qualification = json['qualification'];
    _bookedAppointment = json['BookedAppointment'];
    _specialization = json['specialization'];
    _subSpecialist = json['subSpecialist'];
    _experienceYears = json['experienceYears'];
    _consultationFees = json['consultationFees'];
  }

  String? _doctorName;
  String? _doctorSpecialist;
  String? _address;
  num? _ratings;
  num? _reviewsCount;
  String? _legalName;
  String? _gender;
  String? _dateOfBirth;
  String? _country;
  String? _state;
  String? _city;
  String? _qualification;
  int? _bookedAppointment;
  String? _specialization;
  String? _subSpecialist;
  String? _experienceYears;
  String? _consultationFees;

  DoctorInfo copyWith({
    String? doctorName,
    String? doctorSpecialist,
    String? address,
    num? ratings,
    num? reviewsCount,
    String? legalName,
    String? gender,
    String? dateOfBirth,
    String? country,
    String? state,
    String? city,
    String? qualification,
    int? bookedAppointment,
    String? specialization,
    String? subSpecialist,
    String? experienceYears,
    String? consultationFees,
  }) => DoctorInfo(
    doctorName: doctorName ?? _doctorName,
    doctorSpecialist: doctorSpecialist ?? _doctorSpecialist,
    address: address ?? _address,
    ratings: ratings ?? _ratings,
    reviewsCount: reviewsCount ?? _reviewsCount,
    legalName: legalName ?? _legalName,
    gender: gender ?? _gender,
    dateOfBirth: dateOfBirth ?? _dateOfBirth,
    country: country ?? _country,
    state: state ?? _state,
    city: city ?? _city,
    qualification: qualification ?? _qualification,
    bookedAppointment: bookedAppointment ?? _bookedAppointment,
    specialization: specialization ?? _specialization,
    subSpecialist: subSpecialist ?? _subSpecialist,
    experienceYears: experienceYears ?? _experienceYears,
    consultationFees: consultationFees ?? _consultationFees,
  );

  String? get doctorName => _doctorName;
  String? get doctorSpecialist => _doctorSpecialist;
  String? get address => _address;
  num? get ratings => _ratings;
  num? get reviewsCount => _reviewsCount;
  String? get legalName => _legalName;
  String? get gender => _gender;
  String? get dateOfBirth => _dateOfBirth;
  String? get country => _country;
  String? get state => _state;
  String? get city => _city;
  String? get qualification => _qualification;
  int? get bookedAppointment => _bookedAppointment;
  String? get specialization => _specialization;
  String? get subSpecialist => _subSpecialist;
  String? get experienceYears => _experienceYears;
  String? get consultationFees => _consultationFees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['doctor_name'] = _doctorName;
    map['doctor_specialist'] = _doctorSpecialist;
    map['address'] = _address;
    map['ratings'] = _ratings;
    map['reviews_count'] = _reviewsCount;
    map['legalName'] = _legalName;
    map['gender'] = _gender;
    map['dateOfBirth'] = _dateOfBirth;
    map['country'] = _country;
    map['state'] = _state;
    map['city'] = _city;
    map['qualification'] = _qualification;
    map['BookedAppointment'] = _bookedAppointment;
    map['specialization'] = _specialization;
    map['subSpecialist'] = _subSpecialist;
    map['experienceYears'] = _experienceYears;
    map['consultationFees'] = _consultationFees;
    return map;
  }
}

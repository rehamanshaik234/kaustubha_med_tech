class DoctorDetailsModel {
  DoctorDetailsModel({
    dynamic? id,
      String? name, 
      String? email, 
      String? emailVerified, 
      String? password, 
      String? role, 
      String? phone, 
      bool? numberVerified, 
      dynamic image, 
      dynamic about, 
      Profile? profile, 
      Availability? availability,
      num? totalReviews,
      num? avgRatings,
      Liscense? liscense,}){
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
    _profile = profile;
    _availability = availability;
    _liscense = liscense;
    _totalReviews=totalReviews;
    _avgRatings=avgRatings;
}

  DoctorDetailsModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _emailVerified = json['emailVerified'];
    _password = json['password'];
    _role = json['role'];
    _phone = json['phone'];
    _numberVerified = json['numberVerified'];
    _image = json['image'];
    _about = json['about'];
    _profile = json['doctorProfile'] != null ? Profile.fromJson(json['doctorProfile']) : null;
    _availability = json['doctorAvailabilityDetails'] != null ? Availability.fromJson(json['doctorAvailabilityDetails']) : null;
    _liscense = json['doctorLicenses'] != null ? Liscense.fromJson(json['doctorLicenses']) : null;
    print(json['doctorLicenses']);
  }


  DoctorDetailsModel copyWith({
    dynamic? id,
    String? name,
    String? email,
    String? emailVerified,
    String? password,
    String? role,
    String? phone,
    bool? numberVerified,
    dynamic image,
    dynamic about,
    Profile? profile,
    Availability? availability,
    num? totalReviews,
    num? avgRatings,
    Liscense? liscense,
  }) {
    return DoctorDetailsModel(
      id: id ?? _id,
      name: name ?? _name,
      email: email ?? _email,
      emailVerified: emailVerified ?? _emailVerified,
      password: password ?? _password,
      role: role ?? _role,
      phone: phone ?? _phone,
      numberVerified: numberVerified ?? _numberVerified,
      image: image ?? _image,
      about: about ?? _about,
      profile: profile ?? _profile,
      availability: availability ?? _availability,
      totalReviews: totalReviews ?? _totalReviews,
      avgRatings: avgRatings ?? _avgRatings,
      liscense: liscense ?? _liscense,
    );
  }

  dynamic _id;
  String? _name;
  String? _email;
  String? _emailVerified;
  String? _password;
  String? _role;
  String? _phone;
  bool? _numberVerified;
  dynamic _image;
  dynamic _about;
  Profile? _profile;
  Availability? _availability;
  Liscense? _liscense;
  num? _totalReviews;
  num? _avgRatings;

  dynamic? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get emailVerified => _emailVerified;
  String? get password => _password;
  String? get role => _role;
  String? get phone => _phone;
  bool? get numberVerified => _numberVerified;
  num? get totalReviews => _totalReviews;
  num? get avgRatings => _avgRatings;
  dynamic get image => _image;
  dynamic get about => _about;
  Profile? get profile => _profile;
  Availability? get availability => _availability;
  Liscense? get liscense => _liscense;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['emailVerified'] = _emailVerified;
    map['password'] = _password;
    map['role'] = _role;
    map['phone'] = _phone;
    map['numberVerified'] = _numberVerified;
    map['image'] = _image;
    map['about'] = _about;
    if (_profile != null) {
      map['profile'] = _profile?.toJson();
    }
    if (_availability != null) {
      map['availability'] = _availability?.toJson();
    }
    if (_liscense != null) {
      map['liscense'] = _liscense?.toJson();
    }
    return map;
  }

}

class Liscense {
  Liscense({
      String? userId, 
      num? id, 
      String? imageUrl1, 
      String? imageUrl2, 
      String? registrationNumber1, 
      String? registrationNumber2,}){
    _userId = userId;
    _id = id;
    _imageUrl1 = imageUrl1;
    _imageUrl2 = imageUrl2;
    _registrationNumber1 = registrationNumber1;
    _registrationNumber2 = registrationNumber2;
}

  Liscense.fromJson(dynamic json) {
    _userId = json['userId'];
    _id = json['id'];
    _imageUrl1 = json['imageUrl1'];
    _imageUrl2 = json['imageUrl2'];
    _registrationNumber1 = json['registrationNumber1'];
    _registrationNumber2 = json['registrationNumber2'];
  }
  String? _userId;
  num? _id;
  String? _imageUrl1;
  String? _imageUrl2;
  String? _registrationNumber1;
  String? _registrationNumber2;

  String? get userId => _userId;
  num? get id => _id;
  String? get imageUrl1 => _imageUrl1;
  String? get imageUrl2 => _imageUrl2;
  String? get registrationNumber1 => _registrationNumber1;
  String? get registrationNumber2 => _registrationNumber2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['id'] = _id;
    map['imageUrl1'] = _imageUrl1;
    map['imageUrl2'] = _imageUrl2;
    map['registrationNumber1'] = _registrationNumber1;
    map['registrationNumber2'] = _registrationNumber2;
    return map;
  }

}

class Availability {
  Availability({
      String? userId, 
      num? id, 
      String? sessionFees, 
      String? sessionLength, 
      List<String>? languages, 
      List<String>? availableDays, 
      String? availableTimeFrom, 
      List<String>? availableTimeSlot,}){
    _userId = userId;
    _id = id;
    _sessionFees = sessionFees;
    _sessionLength = sessionLength;
    _languages = languages;
    _availableDays = availableDays;
    _availableTimeFrom = availableTimeFrom;
    _availableTimeSlot = availableTimeSlot;
}

  Availability.fromJson(dynamic json) {
    _userId = json['userId'];
    _id = json['id'];
    _sessionFees = json['sessionFees'];
    _sessionLength = json['sessionLength'];
    _languages = json['languages'] != null ? json['languages'].cast<String>() : [];
    _availableDays = json['availableDays'] != null ? json['availableDays'].cast<String>() : [];
    _availableTimeFrom = json['availableTimeFrom'];
    _availableTimeSlot = json['availableTimeSlot'] != null ? json['availableTimeSlot'].cast<String>() : [];
  }
  String? _userId;
  num? _id;
  String? _sessionFees;
  String? _sessionLength;
  List<String>? _languages;
  List<String>? _availableDays;
  String? _availableTimeFrom;
  List<String>? _availableTimeSlot;

  String? get userId => _userId;
  num? get id => _id;
  String? get sessionFees => _sessionFees;
  String? get sessionLength => _sessionLength;
  List<String>? get languages => _languages;
  List<String>? get availableDays => _availableDays;
  String? get availableTimeFrom => _availableTimeFrom;
  List<String>? get availableTimeSlot => _availableTimeSlot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['id'] = _id;
    map['sessionFees'] = _sessionFees;
    map['sessionLength'] = _sessionLength;
    map['languages'] = _languages;
    map['availableDays'] = _availableDays;
    map['availableTimeFrom'] = _availableTimeFrom;
    map['availableTimeSlot'] = _availableTimeSlot;
    return map;
  }

}

class Profile {
  Profile({
      String? userId, 
      num? id, 
      String? legalName, 
      String? gender, 
      String? dateOfBirth, 
      String? address, 
      String? country, 
      String? state, 
      String? city, 
      String? qualification, 
      num? bookedAppointment, 
      String? specialization, 
      String? subSpecialist, 
      String? experienceYears, 
      String? consultationFees,}){
    _userId = userId;
    _id = id;
    _legalName = legalName;
    _gender = gender;
    _dateOfBirth = dateOfBirth;
    _address = address;
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

  Profile.fromJson(dynamic json) {
    _userId = json['userId'];
    _id = json['id'];
    _legalName = json['legalName'];
    _gender = json['gender'];
    _dateOfBirth = json['dateOfBirth'];
    _address = json['address'];
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
  String? _userId;
  num? _id;
  String? _legalName;
  String? _gender;
  String? _dateOfBirth;
  String? _address;
  String? _country;
  String? _state;
  String? _city;
  String? _qualification;
  num? _bookedAppointment;
  String? _specialization;
  String? _subSpecialist;
  String? _experienceYears;
  String? _consultationFees;

  String? get userId => _userId;
  num? get id => _id;
  String? get legalName => _legalName;
  String? get gender => _gender;
  String? get dateOfBirth => _dateOfBirth;
  String? get address => _address;
  String? get country => _country;
  String? get state => _state;
  String? get city => _city;
  String? get qualification => _qualification;
  num? get bookedAppointment => _bookedAppointment;
  String? get specialization => _specialization;
  String? get subSpecialist => _subSpecialist;
  String? get experienceYears => _experienceYears;
  String? get consultationFees => _consultationFees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['id'] = _id;
    map['legalName'] = _legalName;
    map['gender'] = _gender;
    map['dateOfBirth'] = _dateOfBirth;
    map['address'] = _address;
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
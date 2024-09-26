/// availableTimeFrom : "8:00pm"
/// availableTimeTo : ["8:00pm","9:00pm"]
/// availableDays : ["M","Tu","W","F"]
/// sessionFees : "500"
/// sessionLength : "30"
/// languages : ["Hindi","english"]

class DoctorTImeSlotsModel {
  DoctorTImeSlotsModel({
      String? availableTimeFrom,
      List<String>? availableTimeSlot,
      List<String>? availableDays,
      String? sessionFees,
      String? sessionLength,
      List<String>? languages,}){
    _availableTimeFrom = availableTimeFrom;
    _availableTimeSlot = availableTimeSlot;
    _availableDays = availableDays;
    _sessionFees = sessionFees;
    _sessionLength = sessionLength;
    _languages = languages;
}

  DoctorTImeSlotsModel.fromJson(dynamic json) {
    _availableTimeFrom = json['availableTimeFrom'];
    _availableTimeSlot = json['availableTimeSlot'] != null ? json['availableTimeSlot'].cast<String>() : [];
    _availableDays = json['availableDays'] != null ? json['availableDays'].cast<String>() : [];
    _sessionFees = json['sessionFees'];
    _sessionLength = json['sessionLength'];
    _languages = json['languages'] != null ? json['languages'].cast<String>() : [];
  }
  String? _availableTimeFrom;
  List<String>? _availableTimeSlot;
  List<String>? _availableDays;
  String? _sessionFees;
  String? _sessionLength;
  List<String>? _languages;
DoctorTImeSlotsModel copyWith({  String? availableTimeFrom,
  List<String>? availableTimeSlot,
  List<String>? availableDays,
  String? sessionFees,
  String? sessionLength,
  List<String>? languages,
}) => DoctorTImeSlotsModel(  availableTimeFrom: availableTimeFrom ?? _availableTimeFrom,
  availableTimeSlot: availableTimeSlot ?? _availableTimeSlot,
  availableDays: availableDays ?? _availableDays,
  sessionFees: sessionFees ?? _sessionFees,
  sessionLength: sessionLength ?? _sessionLength,
  languages: languages ?? _languages,
);
  String? get availableTimeFrom => _availableTimeFrom;
  List<String>? get availableTimeSlot => _availableTimeSlot;
  List<String>? get availableDays => _availableDays;
  String? get sessionFees => _sessionFees;
  String? get sessionLength => _sessionLength;
  List<String>? get languages => _languages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['availableTimeFrom'] = _availableTimeFrom;
    map['availableTimeSlot'] = _availableTimeSlot;
    map['availableDays'] = _availableDays;
    map['sessionFees'] = _sessionFees;
    map['sessionLength'] = _sessionLength;
    map['languages'] = _languages;
    return map;
  }

}
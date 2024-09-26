/// availableTimeFrom : "8:00pm"
/// availableTimeTo : ["8:00pm","9:00pm"]
/// availableDays : ["M","Tu","W","F"]
/// sessionFees : "500"
/// sessionLength : "30"
/// languages : ["Hindi","english"]

class DoctorTImeSlotsModel {
  DoctorTImeSlotsModel({
      String? availableTimeFrom, 
      List<String>? availableTimeTo, 
      List<String>? availableDays, 
      String? sessionFees, 
      String? sessionLength, 
      List<String>? languages,}){
    _availableTimeFrom = availableTimeFrom;
    _availableTimeTo = availableTimeTo;
    _availableDays = availableDays;
    _sessionFees = sessionFees;
    _sessionLength = sessionLength;
    _languages = languages;
}

  DoctorTImeSlotsModel.fromJson(dynamic json) {
    _availableTimeFrom = json['availableTimeFrom'];
    _availableTimeTo = json['availableTimeTo'] != null ? json['availableTimeTo'].cast<String>() : [];
    _availableDays = json['availableDays'] != null ? json['availableDays'].cast<String>() : [];
    _sessionFees = json['sessionFees'];
    _sessionLength = json['sessionLength'];
    _languages = json['languages'] != null ? json['languages'].cast<String>() : [];
  }
  String? _availableTimeFrom;
  List<String>? _availableTimeTo;
  List<String>? _availableDays;
  String? _sessionFees;
  String? _sessionLength;
  List<String>? _languages;
DoctorTImeSlotsModel copyWith({  String? availableTimeFrom,
  List<String>? availableTimeTo,
  List<String>? availableDays,
  String? sessionFees,
  String? sessionLength,
  List<String>? languages,
}) => DoctorTImeSlotsModel(  availableTimeFrom: availableTimeFrom ?? _availableTimeFrom,
  availableTimeTo: availableTimeTo ?? _availableTimeTo,
  availableDays: availableDays ?? _availableDays,
  sessionFees: sessionFees ?? _sessionFees,
  sessionLength: sessionLength ?? _sessionLength,
  languages: languages ?? _languages,
);
  String? get availableTimeFrom => _availableTimeFrom;
  List<String>? get availableTimeTo => _availableTimeTo;
  List<String>? get availableDays => _availableDays;
  String? get sessionFees => _sessionFees;
  String? get sessionLength => _sessionLength;
  List<String>? get languages => _languages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['availableTimeFrom'] = _availableTimeFrom;
    map['availableTimeTo'] = _availableTimeTo;
    map['availableDays'] = _availableDays;
    map['sessionFees'] = _sessionFees;
    map['sessionLength'] = _sessionLength;
    map['languages'] = _languages;
    return map;
  }

}
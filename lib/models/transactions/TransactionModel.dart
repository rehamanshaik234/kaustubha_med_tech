class TransactionModel {
  TransactionModel({
      String? id, 
      num? amount, 
      String? paymentStatus, 
      String? createdAt, 
      String? updatedAt, 
      String? patientId, 
      String? doctorId, 
      String? paymentId, 
      String? currency, 
      num? amountPaid, 
      num? appointmentId, 
      Doctor? doctor,}){
    _id = id;
    _amount = amount;
    _paymentStatus = paymentStatus;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _patientId = patientId;
    _doctorId = doctorId;
    _paymentId = paymentId;
    _currency = currency;
    _amountPaid = amountPaid;
    _appointmentId = appointmentId;
    _doctor = doctor;
}

  TransactionModel.fromJson(dynamic json) {
    _id = json['id'];
    _amount = json['amount'];
    _paymentStatus = json['paymentStatus'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _patientId = json['patientId'];
    _doctorId = json['doctorId'];
    _paymentId = json['paymentId'];
    _currency = json['currency'];
    _amountPaid = json['amount_paid'];
    _appointmentId = json['appointmentId'];
    _doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
  }
  String? _id;
  num? _amount;
  String? _paymentStatus;
  String? _createdAt;
  String? _updatedAt;
  String? _patientId;
  String? _doctorId;
  String? _paymentId;
  String? _currency;
  num? _amountPaid;
  num? _appointmentId;
  Doctor? _doctor;
TransactionModel copyWith({  String? id,
  num? amount,
  String? paymentStatus,
  String? createdAt,
  String? updatedAt,
  String? patientId,
  String? doctorId,
  String? paymentId,
  String? currency,
  num? amountPaid,
  num? appointmentId,
  Doctor? doctor,
}) => TransactionModel(  id: id ?? _id,
  amount: amount ?? _amount,
  paymentStatus: paymentStatus ?? _paymentStatus,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  patientId: patientId ?? _patientId,
  doctorId: doctorId ?? _doctorId,
  paymentId: paymentId ?? _paymentId,
  currency: currency ?? _currency,
  amountPaid: amountPaid ?? _amountPaid,
  appointmentId: appointmentId ?? _appointmentId,
  doctor: doctor ?? _doctor,
);
  String? get id => _id;
  num? get amount => _amount;
  String? get paymentStatus => _paymentStatus;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get patientId => _patientId;
  String? get doctorId => _doctorId;
  String? get paymentId => _paymentId;
  String? get currency => _currency;
  num? get amountPaid => _amountPaid;
  num? get appointmentId => _appointmentId;
  Doctor? get doctor => _doctor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['amount'] = _amount;
    map['paymentStatus'] = _paymentStatus;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['patientId'] = _patientId;
    map['doctorId'] = _doctorId;
    map['paymentId'] = _paymentId;
    map['currency'] = _currency;
    map['amount_paid'] = _amountPaid;
    map['appointmentId'] = _appointmentId;
    if (_doctor != null) {
      map['doctor'] = _doctor?.toJson();
    }
    return map;
  }

}

class Doctor {
  Doctor({
      String? name, 
      dynamic image,}){
    _name = name;
    _image = image;
}

  Doctor.fromJson(dynamic json) {
    _name = json['name'];
    _image = json['image'];
  }
  String? _name;
  dynamic _image;
Doctor copyWith({  String? name,
  dynamic image,
}) => Doctor(  name: name ?? _name,
  image: image ?? _image,
);
  String? get name => _name;
  dynamic get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['image'] = _image;
    return map;
  }

}
class ReviewModel {
  ReviewModel({
      num? id, 
      String? userId, 
      String? rating, 
      String? message, 
      String? patientName, 
      String? patientId, 
      String? patientProfilePic, 
      String? createdAt,}){
    _id = id;
    _userId = userId;
    _rating = rating;
    _message = message;
    _patientName = patientName;
    _patientId = patientId;
    _patientProfilePic = patientProfilePic;
    _createdAt = createdAt;
}

  ReviewModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _rating = json['rating'];
    _message = json['message'];
    _patientName = json['patientName'];
    _patientId = json['patientId'];
    _patientProfilePic = json['patientProfilePic'];
    _createdAt = json['createdAt'];
  }
  num? _id;
  String? _userId;
  String? _rating;
  String? _message;
  String? _patientName;
  String? _patientId;
  String? _patientProfilePic;
  String? _createdAt;
ReviewModel copyWith({  num? id,
  String? userId,
  String? rating,
  String? message,
  String? patientName,
  String? patientId,
  String? patientProfilePic,
  String? createdAt,
}) => ReviewModel(  id: id ?? _id,
  userId: userId ?? _userId,
  rating: rating ?? _rating,
  message: message ?? _message,
  patientName: patientName ?? _patientName,
  patientId: patientId ?? _patientId,
  patientProfilePic: patientProfilePic ?? _patientProfilePic,
  createdAt: createdAt ?? _createdAt,
);
  num? get id => _id;
  String? get userId => _userId;
  String? get rating => _rating;
  String? get message => _message;
  String? get patientName => _patientName;
  String? get patientId => _patientId;
  String? get patientProfilePic => _patientProfilePic;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['rating'] = _rating;
    map['message'] = _message;
    map['patientName'] = _patientName;
    map['patientId'] = _patientId;
    map['patientProfilePic'] = _patientProfilePic;
    map['createdAt'] = _createdAt;
    return map;
  }

}
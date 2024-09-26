class PatientDocumentsModel {
  PatientDocumentsModel({
      num? id, 
      String? userId, 
      String? imageUrl1, 
      String? imageUrl2,}){
    _id = id;
    _userId = userId;
    _imageUrl1 = imageUrl1;
    _imageUrl2 = imageUrl2;
}

  PatientDocumentsModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
     if(json['imageUrl1']!='') {
       _imageUrl1 = json['imageUrl1'];
     }
    if(json['imageUrl2']!='') {
      _imageUrl2 = json['imageUrl2'];
    }
  }
  num? _id;
  String? _userId;
  String? _imageUrl1;
  String? _imageUrl2;
PatientDocumentsModel copyWith({  num? id,
  String? userId,
  String? imageUrl1,
  String? imageUrl2,
}) => PatientDocumentsModel(  id: id ?? _id,
  userId: userId ?? _userId,
  imageUrl1: imageUrl1 ?? _imageUrl1,
  imageUrl2: imageUrl2 ?? _imageUrl2,
);
  num? get id => _id;
  String? get userId => _userId;
  String? get imageUrl1 => _imageUrl1;
  String? get imageUrl2 => _imageUrl2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['imageUrl1'] = _imageUrl1;
    map['imageUrl2'] = _imageUrl2;
    return map;
  }
}
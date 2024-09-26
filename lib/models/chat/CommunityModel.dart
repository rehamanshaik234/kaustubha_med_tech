class CommunityModel {
  CommunityModel({
      String? id, 
      String? communityName, 
      String? type,}){
    _id = id;
    _communityName = communityName;
    _type = type;
}

  CommunityModel.fromJson(dynamic json) {
    _id = json['id'];
    _communityName = json['communityName'];
    _type = json['type'];
  }
  String? _id;
  String? _communityName;
  String? _type;
CommunityModel copyWith({  String? id,
  String? communityName,
  String? type,
}) => CommunityModel(  id: id ?? _id,
  communityName: communityName ?? _communityName,
  type: type ?? _type,
);
  String? get id => _id;
  String? get communityName => _communityName;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['communityName'] = _communityName;
    map['type'] = _type;
    return map;
  }

}
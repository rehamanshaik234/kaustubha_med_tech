class MessageModel {
  MessageModel({
      num? id, 
      String? content, 
      String? senderId, 
      String? conversationId, 
      String? createdAt, 
      dynamic fileName, 
      dynamic filePath, 
      dynamic fileType, 
      Sender? sender, 
      List<SeenBy>? seenBy, 
      String? senderName,}){
    _id = id;
    _content = content;
    _senderId = senderId;
    _conversationId = conversationId;
    _createdAt = createdAt;
    _fileName = fileName;
    _filePath = filePath;
    _fileType = fileType;
    _sender = sender;
    _seenBy = seenBy;
    _senderName = senderName;
}

  MessageModel.fromJson(dynamic json) {
    _id = json['id'];
    _content = json['content'];
    _senderId = json['senderId'];
    _conversationId = json['conversationId'];
    _createdAt = json['createdAt'];
    _fileName = json['fileName'];
    _filePath = json['filePath'];
    _fileType = json['fileType'];
    _sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    if (json['seenBy'] != null) {
      _seenBy = [];
      json['seenBy'].forEach((v) {
        _seenBy?.add(SeenBy.fromJson(v));
      });
    }
    _senderName = json['senderName'];
  }
  num? _id;
  String? _content;
  String? _senderId;
  String? _conversationId;
  String? _createdAt;
  dynamic _fileName;
  dynamic _filePath;
  dynamic _fileType;
  Sender? _sender;
  List<SeenBy>? _seenBy;
  String? _senderName;
MessageModel copyWith({  num? id,
  String? content,
  String? senderId,
  String? conversationId,
  String? createdAt,
  dynamic fileName,
  dynamic filePath,
  dynamic fileType,
  Sender? sender,
  List<SeenBy>? seenBy,
  String? senderName,
}) => MessageModel(  id: id ?? _id,
  content: content ?? _content,
  senderId: senderId ?? _senderId,
  conversationId: conversationId ?? _conversationId,
  createdAt: createdAt ?? _createdAt,
  fileName: fileName ?? _fileName,
  filePath: filePath ?? _filePath,
  fileType: fileType ?? _fileType,
  sender: sender ?? _sender,
  seenBy: seenBy ?? _seenBy,
  senderName: senderName ?? _senderName,
);
  num? get id => _id;
  String? get content => _content;
  String? get senderId => _senderId;
  String? get conversationId => _conversationId;
  String? get createdAt => _createdAt;
  dynamic get fileName => _fileName;
  dynamic get filePath => _filePath;
  dynamic get fileType => _fileType;
  Sender? get sender => _sender;
  List<SeenBy>? get seenBy => _seenBy;
  String? get senderName => _senderName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['content'] = _content;
    map['senderId'] = _senderId;
    map['conversationId'] = _conversationId;
    map['createdAt'] = _createdAt;
    map['fileName'] = _fileName;
    map['filePath'] = _filePath;
    map['fileType'] = _fileType;
    if (_sender != null) {
      map['sender'] = _sender?.toJson();
    }
    if (_seenBy != null) {
      map['seenBy'] = _seenBy?.map((v) => v.toJson()).toList();
    }
    map['senderName'] = _senderName;
    return map;
  }

}

class SeenBy {
  SeenBy({
      String? userId, 
      String? seenAt,}){
    _userId = userId;
    _seenAt = seenAt;
}

  SeenBy.fromJson(dynamic json) {
    _userId = json['userId'];
    _seenAt = json['seenAt'];
  }
  String? _userId;
  String? _seenAt;
SeenBy copyWith({  String? userId,
  String? seenAt,
}) => SeenBy(  userId: userId ?? _userId,
  seenAt: seenAt ?? _seenAt,
);
  String? get userId => _userId;
  String? get seenAt => _seenAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['seenAt'] = _seenAt;
    return map;
  }

}

class Sender {
  Sender({
      String? id, 
      String? name, 
      String? email, 
      String? password, 
      String? role, 
      String? phone, 
      bool? numberVerified, 
      dynamic image, 
      String? about, 
      String? emailVerified, 
      String? socketId,}){
    _id = id;
    _name = name;
    _email = email;
    _password = password;
    _role = role;
    _phone = phone;
    _numberVerified = numberVerified;
    _image = image;
    _about = about;
    _emailVerified = emailVerified;
    _socketId = socketId;
}

  Sender.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _password = json['password'];
    _role = json['role'];
    _phone = json['phone'];
    _numberVerified = json['numberVerified'];
    _image = json['image'];
    _about = json['about'];
    _emailVerified = json['emailVerified'];
    _socketId = json['socket_id'];
  }
  String? _id;
  String? _name;
  String? _email;
  String? _password;
  String? _role;
  String? _phone;
  bool? _numberVerified;
  dynamic _image;
  String? _about;
  String? _emailVerified;
  String? _socketId;
Sender copyWith({  String? id,
  String? name,
  String? email,
  String? password,
  String? role,
  String? phone,
  bool? numberVerified,
  dynamic image,
  String? about,
  String? emailVerified,
  String? socketId,
}) => Sender(  id: id ?? _id,
  name: name ?? _name,
  email: email ?? _email,
  password: password ?? _password,
  role: role ?? _role,
  phone: phone ?? _phone,
  numberVerified: numberVerified ?? _numberVerified,
  image: image ?? _image,
  about: about ?? _about,
  emailVerified: emailVerified ?? _emailVerified,
  socketId: socketId ?? _socketId,
);
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get password => _password;
  String? get role => _role;
  String? get phone => _phone;
  bool? get numberVerified => _numberVerified;
  dynamic get image => _image;
  String? get about => _about;
  String? get emailVerified => _emailVerified;
  String? get socketId => _socketId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['password'] = _password;
    map['role'] = _role;
    map['phone'] = _phone;
    map['numberVerified'] = _numberVerified;
    map['image'] = _image;
    map['about'] = _about;
    map['emailVerified'] = _emailVerified;
    map['socket_id'] = _socketId;
    return map;
  }

}
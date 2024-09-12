class SignUpModel {
  SignUpModel({
      String? name, 
      String? role, 
      String? email, 
      String? phone, 
      String? password,}){
    _name = name;
    _role = role;
    _email = email;
    _phone = phone;
    _password = password;
}

  SignUpModel.fromJson(dynamic json) {
    _name = json['name'];
    _role = json['role'];
    _email = json['email'];
    _phone = json['phone'];
    _password = json['password'];
  }
  String? _name;
  String? _role;
  String? _email;
  String? _phone;
  String? _password;

  String? get name => _name;
  String? get role => _role;
  String? get email => _email;
  String? get phone => _phone;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if(_name!=null){
      map['name'] = _name;
    }
    if(_role!=null){
      map['role'] = _role;
    }
    if(_email!=null) {
      map['email'] = _email;
    }
    if(_phone!=null) {
      map['phone'] = _phone;
    }
    if(_password!=null) {
      map['password'] = _password;
    }
    return map;
  }

}
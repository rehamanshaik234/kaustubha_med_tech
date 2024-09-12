class UserAccount {
  UserAccount({
    String? email,
    String? alternativeContact,
    String? fullName,
    String? mobileNumber,
    String? password,
    String? role,
    String? selectedSociety,
    String? selectedBlock,
    String? selectedFloor,
    String? selectedFlatNum,
    List<Vehicles>? vehicles,
    bool? approval,
  }) {
    _email = email;
    _alternativeContact = alternativeContact;
    _fullName = fullName;
    _mobileNumber = mobileNumber;
    _password = password;
    _role = role;
    _selectedSociety = selectedSociety;
    _selectedBlock = selectedBlock;
    _selectedFloor = selectedFloor;
    _selectedFlatNumber = selectedFlatNum;
    _vehicles = vehicles;
    _approval = approval ?? false; // Default value for approval is false
  }

  UserAccount.fromJson(dynamic json) {
    _email = json['email'];
    _alternativeContact = json['alternative_contact'];
    _fullName = json['full_name'];
    _mobileNumber = json['mobile_number'];
    _password = json['password'];
    _role = json['role'];
    _selectedSociety = json['selected_society'];
    _selectedBlock = json['selected_block'];
    _selectedFloor = json['selected_floor'];
    _selectedFlatNumber = json['selected_flat_num'];
    _approval = json['approval'] ?? false; // Default value for approval is false
    if (json['vehicles'] != null) {
      _vehicles = [];
      json['vehicles'].forEach((v) {
        _vehicles?.add(Vehicles.fromJson(v));
      });
    }
  }

  String? _email;
  String? _alternativeContact;
  String? _fullName;
  String? _mobileNumber;
  String? _password;
  String? _role;
  String? _selectedSociety;
  String? _selectedBlock;
  String? _selectedFloor;
  String? _selectedFlatNumber;
  List<Vehicles>? _vehicles;
  bool? _approval;

  UserAccount copyWith({
    String? email,
    String? alternativeContact,
    String? fullName,
    String? mobileNumber,
    String? password,
    String? role,
    String? selectedSociety,
    String? selectedBlock,
    String? selectedFloor,
    String? selectedFlatNum,
    List<Vehicles>? vehicles,
    bool? approval,
  }) => UserAccount(
    email: email ?? _email,
    alternativeContact: alternativeContact ?? _alternativeContact,
    fullName: fullName ?? _fullName,
    mobileNumber: mobileNumber ?? _mobileNumber,
    password: password ?? _password,
    role: role ?? _role,
    selectedSociety: selectedSociety ?? _selectedSociety,
    selectedBlock: selectedBlock ?? _selectedBlock,
    selectedFloor: selectedFloor ?? _selectedFloor,
    selectedFlatNum: selectedFlatNum ?? _selectedFlatNumber,
    vehicles: vehicles ?? _vehicles,
    approval: approval ?? _approval, // Preserve the existing approval value or set default
  );

  String? get email => _email;
  String? get alternativeContact => _alternativeContact;
  String? get fullName => _fullName;
  String? get mobileNumber => _mobileNumber;
  String? get password => _password;
  String? get role => _role;
  String? get selectedSociety => _selectedSociety;
  String? get selectedBlock => _selectedBlock;
  String? get selectedFloor => _selectedFloor;
  String? get selectedFlatNumber => _selectedFlatNumber;
  List<Vehicles>? get vehicles => _vehicles;
  bool? get approval => _approval;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['alternative_contact'] = _alternativeContact;
    map['full_name'] = _fullName;
    map['mobile_number'] = _mobileNumber;
    map['password'] = _password;
    map['role'] = _role;
    map['selected_society'] = _selectedSociety;
    map['selected_block'] = _selectedBlock;
    map['selected_floor'] = _selectedFloor;
    map['selected_flat_num'] = _selectedFlatNumber;
    map['approval'] = _approval; // Add approval to JSON
    if (_vehicles != null) {
      map['vehicles'] = _vehicles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}


/// vehicle_number : "String"
/// vehicle_name : "String"
/// vehicle_type : "String"

class Vehicles {
  Vehicles({
      String? vehicleNumber, 
      String? vehicleName, 
      String? vehicleType,}){
    _vehicleNumber = vehicleNumber;
    _vehicleName = vehicleName;
    _vehicleType = vehicleType;
}

  Vehicles.fromJson(dynamic json) {
    _vehicleNumber = json['vehicle_number'];
    _vehicleName = json['vehicle_name'];
    _vehicleType = json['vehicle_type'];
  }
  String? _vehicleNumber;
  String? _vehicleName;
  String? _vehicleType;
Vehicles copyWith({  String? vehicleNumber,
  String? vehicleName,
  String? vehicleType,
}) => Vehicles(  vehicleNumber: vehicleNumber ?? _vehicleNumber,
  vehicleName: vehicleName ?? _vehicleName,
  vehicleType: vehicleType ?? _vehicleType,
);
  String? get vehicleNumber => _vehicleNumber;
  String? get vehicleName => _vehicleName;
  String? get vehicleType => _vehicleType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vehicle_number'] = _vehicleNumber;
    map['vehicle_name'] = _vehicleName;
    map['vehicle_type'] = _vehicleType;
    return map;
  }

}
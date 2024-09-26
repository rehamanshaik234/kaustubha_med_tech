import 'package:flutter/cupertino.dart';

class CommonProvider extends ChangeNotifier{

  String? _currentRoute;
  String? get currentRoute => _currentRoute;

  bool _showingCallPopup=false;
  bool get showingCallPopup => _showingCallPopup;

  void setCurrentRoute(String? currentRoute){
    _currentRoute=currentRoute;
    notifyListeners();
  }

  void setShowingCallPopup(bool showingCallPopup){
    _showingCallPopup= showingCallPopup;
    notifyListeners();
  }


}
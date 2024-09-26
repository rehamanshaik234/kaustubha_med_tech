import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaustubha_medtech/controller/repo/user_repo/user_repo.dart';

class VideoCallProvider extends ChangeNotifier{
  UserRepo userRepo = UserRepo();
  bool _loader=false;
  bool get loader => _loader;

  String _socketId='';
  String get socketId => _socketId;

  bool _doctorDetailLoader=false;
  bool get doctorDetailLoader => _doctorDetailLoader;

  String _error= '';
  String get errorMessage => _error;

  void setSocketId(String id){
    _socketId=id;
    notifyListeners();
  }

}
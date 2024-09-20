import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/repo/user_repo/user_repo.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';

import '../../../models/connectivity/error_model.dart';
import '../../apis/api_responses/api_response.dart';

class UserProvider extends ChangeNotifier{
  UserRepo userRepo = UserRepo();
  bool _loader=false;
  bool get loader => _loader;

  String _error= '';
  String get errorMessage => _error;

  UserInfo _userModel =UserInfo();
  UserInfo get user => _userModel;

  void setError(String error)async{
    _error=error;
    notifyListeners();
  }

  Future<void> getUserInfo(Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    UserInfo? userid = await LocalDB.getUserInfo();
    Map<String,dynamic> params= { 'userId' : userid?.id} ;
    ApiResponse apiResponse = await userRepo.getUserInfo(params);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.error==null && apiResponse.response?.data!=null){
        _userModel=UserInfo.fromJson(map);
        notifyListeners();
      }else{
        _error=response.error ?? '';
        notifyListeners();
      }
      onResponse(response);
      _loader=false;
      notifyListeners();
    }else{
      onResponse(ResponseMessage(error: apiResponse.error));
      _loader=false;
      _error=apiResponse.error;
      notifyListeners();
      print("Provider : APiResponse.Error");
    }
  }


  Future<void> updateProfile(Map<String,dynamic> params, Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await userRepo.updateProfile(params);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data;
      final response = ResponseMessage.fromJson(map);
      if(response.error==null && response.user!=null){
        _userModel=response.user!;
        notifyListeners();
      }else{
        _error=response.error ?? '';
        notifyListeners();
      }
      onResponse(response);
      _loader=false;
      notifyListeners();
    }else{
      onResponse(ResponseMessage(error: apiResponse.error));
      _loader=false;
      _error=apiResponse.error;
      notifyListeners();
      print("Provider : APiResponse.Error");
    }
  }
}
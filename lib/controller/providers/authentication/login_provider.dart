
import 'package:flutter/material.dart';
import 'package:kaustubha_medtech/controller/repo/authentication/login_repo.dart';
import 'package:kaustubha_medtech/controller/repo/authentication/signup_repo.dart';
import 'package:kaustubha_medtech/models/login/LoginModel.dart';
import 'package:kaustubha_medtech/models/connectivity/error_model.dart';

import '../../apis/api_responses/api_response.dart';

class LoginProvider extends ChangeNotifier{
  SignUpRepo signUpRepo=SignUpRepo();

  LoginRepo loginRepo=LoginRepo();
  bool _isNumberVerified=false;
  bool get isNumberVerified => _isNumberVerified;
  String _number='';
  String get number => _number;

  bool _loader=false;
  bool get loader => _loader;

  bool _signInLoader=false;
  bool get signInLoader => _signInLoader;

  LoginModel _signUpModel= LoginModel();
  LoginModel get signUpModel => _signUpModel;


  void setLoader(bool load){
    _loader=load;
    notifyListeners();
  }

  void setNumber(String num){
    _number=num;
    notifyListeners();
  }


  Future<void> loginWithEmilPwd(LoginModel login,Function(ResponseMessage message) onResponse)async{
       _loader=true;
      notifyListeners();
      ApiResponse apiResponse = await loginRepo.signInWithEmailPwd(login.toJson());
      print(" apiResponse.Data.success ${apiResponse.response?.data.toString()}");
      if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
        Map map = apiResponse.response!.data;
        final response = ResponseMessage.fromJson(map);
        onResponse(response);
        _loader=false;
        notifyListeners();
      }else{
        onResponse(ResponseMessage(error: apiResponse.error));
        _loader=false;
        notifyListeners();
        print("Provider : APiResponse.Error");
      }
  }

  Future<void> loginWithEmail(String email,Function(ResponseMessage message) onResponse)async{
    _signInLoader=true;
      notifyListeners();
      ApiResponse apiResponse = await loginRepo.signInWithEmail(email);
      print(" apiResponse.Data.success ${apiResponse.response?.data.toString()}");
      if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
        Map map = apiResponse.response!.data;
        final response = ResponseMessage.fromJson(map);
        onResponse(response);
        _signInLoader=false;
        notifyListeners();
      }else{
        onResponse(ResponseMessage(error: apiResponse.error));
        _signInLoader=false;
        notifyListeners();
        print("Provider : APiResponse.Error");
      }
  }

  Future<void> sendOTPNumber(LoginModel login,Function(ResponseMessage message) onResponse)async{
      _loader=true;
      notifyListeners();
      ApiResponse apiResponse = await loginRepo.sendOTPNumber(login.toJson());
      print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
      if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
        Map map = apiResponse.response!.data;
        final response = ResponseMessage.fromJson(map);
        onResponse(response);
        _loader=false;
        notifyListeners();
      }else{
        onResponse(ResponseMessage(error: apiResponse.error));
        _loader=false;
        notifyListeners();
        print("Provider : APiResponse.Error");
      }
  }


  Future<void> verifyLoginNumberOTP(Map<String,dynamic> login,Function(ResponseMessage message) onResponse)async{
    _loader=true;
    notifyListeners();
    print(login);
    ApiResponse apiResponse = await loginRepo.verifyNumberOTP(login);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data;
      final response = ResponseMessage.fromJson(map);
      onResponse(response);
      _loader=false;
      notifyListeners();
    }else{
      onResponse(ResponseMessage(error: apiResponse.error));
      _loader=false;
      notifyListeners();
      print("Provider : APiResponse.Error");
    }
  }





}
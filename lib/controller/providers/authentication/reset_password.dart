
import 'package:flutter/material.dart';
import 'package:kaustubha_medtech/controller/repo/authentication/login_repo.dart';
import 'package:kaustubha_medtech/controller/repo/authentication/reset_password_repo.dart';
import 'package:kaustubha_medtech/controller/repo/authentication/signup_repo.dart';
import 'package:kaustubha_medtech/models/login/LoginModel.dart';
import 'package:kaustubha_medtech/models/connectivity/error_model.dart';

import '../../apis/api_responses/api_response.dart';

class ResetPasswordProvider extends ChangeNotifier{
  SignUpRepo signUpRepo=SignUpRepo();

  ResetPasswordRepo resetPasswordRepo=ResetPasswordRepo();
  bool _isNumberVerified=false;
  bool get isNumberVerified => _isNumberVerified;
  String _number='';
  String get number => _number;

  bool _loader=false;
  bool get loader => _loader;

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


  Future<void> resetPassword(String password,String token,Function(ResponseMessage message) onResponse)async{
       _loader=true;
      notifyListeners();
      ApiResponse apiResponse = await resetPasswordRepo.resetPassword({'token':token,'password':password});
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

  Future<void> sendOTP(Function(ResponseMessage message) onResponse,{String? number,String? email})async{
      _loader=true;
      notifyListeners();
      late ApiResponse apiResponse;
      if(number!=null){
        apiResponse = await resetPasswordRepo.sendPhoneOtp({'phone': number});
      }else {
        apiResponse = await resetPasswordRepo.sendEmailOtp({'email': email});
      }
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


  Future<void> verifyOTP(String otp,Function(ResponseMessage message) onResponse)async{
    _loader=true;
    notifyListeners();
    ApiResponse apiResponse = await resetPasswordRepo.verifyOtp({"otp":otp});
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
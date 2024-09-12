
import 'package:flutter/material.dart';
import 'package:kaustubha_medtech/controller/firebase/firestore_database.dart';
import 'package:kaustubha_medtech/controller/repo/authentication/signup_repo.dart';
import 'package:kaustubha_medtech/models/create_account/UserAccount.dart';
import 'package:kaustubha_medtech/models/sign_up/SignUpModel.dart';
import 'package:kaustubha_medtech/models/connectivity/error_model.dart';
import 'package:kaustubha_medtech/utils/firestore_urls.dart';

import '../../apis/api_responses/api_response.dart';

class SignUpProvider extends ChangeNotifier{
  SignUpRepo signUpRepo=SignUpRepo();
  bool _isNumberVerified=false;
  bool get isNumberVerified => _isNumberVerified;
  String _number='';
  String get number => _number;
  String _docRef ='';
  String get docRef => _docRef;
  bool _loader=false;
  bool get loader => _loader;

  SignUpModel _signUpModel= SignUpModel();
  SignUpModel get signUpModel => _signUpModel;

  void setVerifiedNumber(bool verify){
    _isNumberVerified=verify;
    notifyListeners();
  }

  void setLoader(bool load){
    _loader=load;
    notifyListeners();
  }

  void setNumber(String num){
    _number=num;
    notifyListeners();
  }

  void setSignUpModel(SignUpModel model){
    _signUpModel=model;
    notifyListeners();
  }

  Future<void> signUpWithEmail(SignUpModel signUp,Function(ResponseMessage message) onResponse)async{
       _loader=true;
      notifyListeners();
      ApiResponse apiResponse = await signUpRepo.signUpWithEmail(signUp.toJson());
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

  Future<void> signUpWithNumber(Map<String,dynamic> signUp,Function(ResponseMessage message) onResponse)async{
      _loader=true;
      notifyListeners();
      ApiResponse apiResponse = await signUpRepo.signUpWithNumber(signUp);
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


  Future<void> sendOTPNumber(SignUpModel signUp,Function(ResponseMessage message) onResponse)async{
      _loader=true;
      notifyListeners();
      ApiResponse apiResponse = await signUpRepo.sendOTPNumber(signUp.toJson());
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


  Future<void> verifyEmail(Map<String,dynamic> signUp,Function(ResponseMessage message) onResponse)async{
    _loader=true;
    notifyListeners();
    ApiResponse apiResponse = await signUpRepo.verifyEmail(signUp);
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
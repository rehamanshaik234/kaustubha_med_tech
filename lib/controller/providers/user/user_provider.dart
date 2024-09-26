import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/repo/patient/appointment_repo.dart';
import 'package:kaustubha_medtech/controller/repo/user_repo/user_repo.dart';
import 'package:kaustubha_medtech/models/user/EnrollmentStatusModel.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';

import '../../../models/appointments/DoctorDetailsModel.dart';
import '../../../models/connectivity/error_model.dart';
import '../../apis/api_responses/api_response.dart';

class UserProvider extends ChangeNotifier{
  UserRepo userRepo = UserRepo();
  PatientAppointmentRepo appointmentRepo=PatientAppointmentRepo();
  bool _loader=false;
  bool get loader => _loader;

  bool _doctorDetailLoader=false;
  bool get doctorDetailLoader => _doctorDetailLoader;

  String _error= '';
  String get errorMessage => _error;

  UserInfo _userModel =UserInfo();
  UserInfo get user => _userModel;

  EnrollmentStatusModel _enrollStatus=EnrollmentStatusModel();
  EnrollmentStatusModel get enrollStatus=>_enrollStatus;

  DoctorDetailsModel _doctorDetails=DoctorDetailsModel();
  DoctorDetailsModel get doctorDetails=>_doctorDetails;

  void setError(String error)async{
    _error=error;
    notifyListeners();
  }

  Future<void> getUserInfo(Function(ResponseMessage message) onResponse,)async{
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
        _userModel = UserInfo.fromJson(map);
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
        _userModel= UserInfo.fromJson(response.user!);
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




  Future<void> sendEmailOTP(Map<String,dynamic> params, Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await userRepo.sendEmailOTP(params);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if(apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data;
      print(map);
      final response = ResponseMessage.fromJson(map);
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

  Future<void> sendNumberOTP(Map<String,dynamic> params, Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await userRepo.sendNumberOTP(params);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if(apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data;
      final response = ResponseMessage.fromJson(map);
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

  Future<void> verifyEmailOTP(Map<String,dynamic> params, Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await userRepo.verifyEmailOTP(params);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if(apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data;
      final response = ResponseMessage.fromJson(map);
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

  Future<void> verifyNumberOTP(Map<String,dynamic> params, Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await userRepo.verifyNumberOTP(params);
    print("apiResponse.Data.success Verifynumber ${apiResponse.response?.data.toString()}");
    if(apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data;
      final response = ResponseMessage.fromJson(map);
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

  Future<void> updateUserProfilePic(File? image, Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    UserInfo? userInfo =await LocalDB.getUserInfo();
    ApiResponse apiResponse = await userRepo.updateProfilePic(userInfo?.id ??"cm1iub2ut0000agrhtuhk97y9", image);
    print("apiResponse.Data.success Verifynumber ${apiResponse.response?.data.toString()}");
    if(apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data;
      final response = ResponseMessage.fromJson(map);
      if(response.error!=null){
        await getUserInfo((r){});
      }
      _loader=false;
      notifyListeners();
      onResponse(response);
    }else{
      onResponse(ResponseMessage(error: apiResponse.error));
      _loader=false;
      _error=apiResponse.error;
      notifyListeners();
      print("Provider : APiResponse.Error");
    }
  }

  Future<void> getDoctorEnrollmentStatus( Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await userRepo.getEnrollmentStatus();
    print("apiResponse.Data.success Verifynumber ${apiResponse.response?.data.toString()}");
    if(apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data;
      final response = ResponseMessage.fromJson(map);
      if(response.success!=null && response.data!=null){
        onResponse(response);
        _enrollStatus=EnrollmentStatusModel.fromJson(response.data);
        _loader=false;
        notifyListeners();
      }else{
        _loader=false;
        notifyListeners();
        onResponse(response);
      }
    }else{
      onResponse(ResponseMessage(error: apiResponse.error));
      _loader=false;
      _error=apiResponse.error;
      notifyListeners();
      print("Provider : APiResponse.Error");
    }
  }

  Future<void> getDoctorDetails(String id, Function(ResponseMessage message) onResponse)async{
    _doctorDetailLoader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await appointmentRepo.getDoctorInfo(id);
    notifyListeners();
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      ResponseMessage response = ResponseMessage.fromJson(map);
      if(response.success!=null && response.data!=null){
        ResponseMessage response2 =ResponseMessage.fromJson(response.data);
        _doctorDetails= DoctorDetailsModel.fromJson(response2.doctor).copyWith(totalReviews: response.data['totalReviews'],
            avgRatings: response.data['avgRating']);
      }else{
        _error=response.error ?? '';
        notifyListeners();
      }
      onResponse(response);
      _doctorDetailLoader=false;
      notifyListeners();
    }else{
      onResponse(ResponseMessage(error: apiResponse.error));
      _doctorDetailLoader=false;
      _error=apiResponse.error;
      notifyListeners();
      print("Provider : APiResponse.Error");
    }
  }


}
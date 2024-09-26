import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/repo/doctor_enrollment/enrollment_repo.dart';
import 'package:kaustubha_medtech/controller/repo/user_repo/user_repo.dart';
import 'package:kaustubha_medtech/models/doctor_enrollment/DoctorPersonalDetModel.dart';
import 'package:kaustubha_medtech/models/doctor_enrollment/DoctorTImeSlotsModel.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';

import '../../../models/connectivity/error_model.dart';
import '../../apis/api_responses/api_response.dart';

class DoctorEnrollmentProvider extends ChangeNotifier{
  EnrollmentRepo enrollmentRepo=EnrollmentRepo();
  bool _loader=false;
  bool get loader => _loader;

  String _error= '';
  String get errorMessage => _error;

  DoctorPersonalDetModel _personalDetModel = DoctorPersonalDetModel();
  DoctorPersonalDetModel get personalDetModel => _personalDetModel;

  DoctorTImeSlotsModel _timeSlotsDetModel = DoctorTImeSlotsModel();
  DoctorTImeSlotsModel get timeSlotsDetModel => _timeSlotsDetModel;


  File? _profilePic;
  File? get profilePic => _profilePic;

  File? _license;
  File? get license => _license;

  File? _certificate;
  File? get certificate => _certificate;

  String _licenseNumber= '';
  String get licenseNumber => _licenseNumber;

  String _certificateNumber= '';
  String get certificateNumber => _certificateNumber;



  void setProfile(File? profilePic){
    _profilePic=profilePic;
    notifyListeners();
  }

  void setLicense(File? license){
    _license=license;
    notifyListeners();
  }

  void setCertificate(File? certificate){
    _certificate=certificate;
    notifyListeners();
  }

  void setLicenseNum(String num)async{
    _licenseNumber=num;
    notifyListeners();
  }

  void setCertificateNum(String num)async{
    _certificateNumber=num;
    notifyListeners();
  }


  void setError(String error)async{
    _error=error;
    notifyListeners();
  }

  void setPersonalDet(DoctorPersonalDetModel details)async{
    print(details.toJson());
  _personalDetModel=details;
    notifyListeners();
  }

  void setTimeSlotsDet(DoctorTImeSlotsModel details)async{
  _timeSlotsDetModel=details;
    notifyListeners();
  }

  Future<void> enrollPersonalDetails(Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    UserInfo? userid = await LocalDB.getUserInfo();
    Map<String,dynamic> params= {
      'values':personalDetModel.toJson(),
      'userId' : userid?.id
    } ;
    ApiResponse apiResponse = await enrollmentRepo.enrollPersonalDetails(params);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
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

  Future<void> updatePersonalDetails(Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    UserInfo? userid = await LocalDB.getUserInfo();
    Map<String,dynamic> params= {
      'values':personalDetModel.toJson(),
      'userId' : userid?.id
    };
    ApiResponse apiResponse = await enrollmentRepo.updateEnrollDetails(params);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
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

  Future<void> enrollTimingDetails(Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    UserInfo? userid = await LocalDB.getUserInfo();
    Map<String,dynamic> params= {
      'values':timeSlotsDetModel.toJson(),
      'userId' : userid?.id ?? ''
    } ;
    ApiResponse apiResponse = await enrollmentRepo.enrolTimingDetails(params);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.error!=null){
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

  Future<void> updateTimingDetails(Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    UserInfo? userid = await LocalDB.getUserInfo();
    Map<String,dynamic> params= {
      'values':timeSlotsDetModel.toJson(),
      'userId' : userid?.id ?? ""
    } ;
    ApiResponse apiResponse = await enrollmentRepo.updateTimingDetails(params);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.error!=null){
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

  Future<void> enrollCertificateAndLicense(Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    UserInfo? userid = await LocalDB.getUserInfo();
    Map<String,dynamic> params= {
      'userId' : userid?.id ?? '',
      'registrationNumber1':licenseNumber,
      'registrationNumber2':certificateNumber
    } ;
    ApiResponse apiResponse = await enrollmentRepo.enrollLicenseAndCertificate(params,license,certificate);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.error==null){
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

  Future<void> updateCertificateAndLicense(Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    UserInfo? userid = await LocalDB.getUserInfo();
    Map<String,dynamic> params= {
      'userId' : userid?.id ?? '',
      'registrationNumber1':licenseNumber,
      'registrationNumber2':certificateNumber
    } ;
    ApiResponse apiResponse = await enrollmentRepo.updateLicenseAndCertificate(params,license,certificate);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.error==null){
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
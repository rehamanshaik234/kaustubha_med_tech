import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/repo/doctor/appointment_repo.dart';
import 'package:kaustubha_medtech/controller/repo/doctor/patients_repo.dart';
import 'package:kaustubha_medtech/controller/repo/patient/appointment_repo.dart';
import 'package:kaustubha_medtech/controller/repo/patient/patient_home_repo.dart';
import 'package:kaustubha_medtech/controller/repo/user_repo/user_repo.dart';
import 'package:kaustubha_medtech/models/appointments/DoctorAvailableTimeSlots.dart';
import 'package:kaustubha_medtech/models/appointments/DoctorFilterModel.dart';
import 'package:kaustubha_medtech/models/appointments/DoctorDetailsModel.dart';
import 'package:kaustubha_medtech/models/appointments/appointment_info.dart';
import 'package:kaustubha_medtech/models/consult/DoctorInfo.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/views/screens/doctor/calendar/childrens/doctor_details.dart';

import '../../../models/connectivity/error_model.dart';
import '../../apis/api_responses/api_response.dart';

class DoctorPatientsProvider extends ChangeNotifier{
  DoctorPatientsRepo appointmentRepo = DoctorPatientsRepo();
  bool _loader=false;
  bool get loader => _loader;

  bool _confirmLoader=false;
  bool get confirmLoader => _confirmLoader;

  String _error= '';
  String get errorMessage => _error;


  DoctorDetailsModel _doctorDetails=DoctorDetailsModel();
  DoctorDetailsModel get doctorDetails=>_doctorDetails;

  List<UserInfo> _patients=[];
  List<UserInfo> get patients => _patients;

  bool isPatientsFetched=false;



  void setError(String error)async{
    _error=error;
    notifyListeners();
  }

  Future<void> getDoctorDetails(String id, Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await appointmentRepo.getPatientsList();
    notifyListeners();
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      ResponseMessage response = ResponseMessage.fromJson(map);
      if(response.success!=null && response.data!=null){
        ResponseMessage response2 =ResponseMessage.fromJson(response.data);
        _doctorDetails=DoctorDetailsModel.fromJson(response2.doctor).copyWith(totalReviews: response.data['totalReviews'],
            avgRatings: response.data['avgRating']);
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

  Future<void> getPatientsList(Function(ResponseMessage message) onResponse,{bool? applyFilter})async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await appointmentRepo.getPatientsList();
    isPatientsFetched=true;
    notifyListeners();
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      ResponseMessage responseMessage=ResponseMessage.fromJson(apiResponse.response?.data);
      if(responseMessage.data!=null){
        List patients= responseMessage.data as List;
        _patients.clear();
        notifyListeners();
        for (var doctor in patients) {
          _patients.add(UserInfo.fromJson(doctor));
          notifyListeners();
        }
        onResponse(responseMessage);
      }else{
        onResponse(ResponseMessage(error: "not found"));
        _error= '';
        notifyListeners();
      }
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
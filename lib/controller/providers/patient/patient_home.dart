import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/repo/patient/patient_home_repo.dart';
import 'package:kaustubha_medtech/controller/repo/user_repo/user_repo.dart';
import 'package:kaustubha_medtech/models/consult/DoctorInfo.dart';
import 'package:kaustubha_medtech/models/patient_document/PatientDocuments.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';

import '../../../models/connectivity/error_model.dart';
import '../../apis/api_responses/api_response.dart';

class PatientHomeProvider extends ChangeNotifier{
  PatientHomeRepo homeRepo = PatientHomeRepo();
  bool _loader=false;
  bool get loader => _loader;

  String _error= '';
  String get errorMessage => _error;

  List<DoctorInfo> _recommendedDoctors=[];
  List<DoctorInfo> get recommendedDRs => _recommendedDoctors;

  PatientDocumentsModel _patientDocumentsModel=PatientDocumentsModel();
  PatientDocumentsModel get patientDocumentsModel => _patientDocumentsModel;

  void setError(String error)async{
    _error=error;
    notifyListeners();
  }

  Future<void> getRecommendedDoctors(Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await homeRepo.getRecommendedDoctors();
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.error==null && apiResponse.response?.data!=null){
        final doctorsList=response.data as List;
        _recommendedDoctors.clear();
        notifyListeners();
        for (var doctor in doctorsList) {
            _recommendedDoctors.add(DoctorInfo.fromJson(doctor));
            notifyListeners();
        }
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

  Future<void> getPatientDocuments(Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await homeRepo.getPatientDocuments();
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.data!=null && response.status==true){
        _patientDocumentsModel=PatientDocumentsModel.fromJson(response.data);
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


  Future<void> uploadDocuments(Function(ResponseMessage message) onResponse,{File? file1,File? file2})async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await homeRepo.uploadPatient(file1, file2);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.error==null && response.status==true){
        await getPatientDocuments((r){});
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
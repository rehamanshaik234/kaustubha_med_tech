import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/repo/patient/appointment_repo.dart';
import 'package:kaustubha_medtech/controller/repo/patient/patient_home_repo.dart';
import 'package:kaustubha_medtech/controller/repo/user_repo/user_repo.dart';
import 'package:kaustubha_medtech/models/appointments/appointment_info.dart';
import 'package:kaustubha_medtech/models/consult/DoctorInfo.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';

import '../../../models/connectivity/error_model.dart';
import '../../apis/api_responses/api_response.dart';

class PatientAppointmentProvider extends ChangeNotifier{
  PatientAppointmentRepo appointmentRepo = PatientAppointmentRepo();
  bool _loader=false;
  bool get loader => _loader;

  String _error= '';
  String get errorMessage => _error;

  bool isUpcomingAptFetched=false;

  List<AppointmentInfo> _upcomingAppointments=[];
  List<AppointmentInfo> get upcomingAppointments => _upcomingAppointments;

  void setError(String error)async{
    _error=error;
    notifyListeners();
  }

  Future<void> getUpcomingAppointments(Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await appointmentRepo.getUpcomingAppointments();
    isUpcomingAptFetched=true;
    notifyListeners();
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.success!=null){
        final doctorsList=response.data as List;
        _upcomingAppointments.clear();
        notifyListeners();
        for (var doctor in doctorsList) {
            _upcomingAppointments.add(AppointmentInfo.fromJson(doctor));
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

}
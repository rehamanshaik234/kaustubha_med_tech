import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
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

class PatientAppointmentProvider extends ChangeNotifier{
  PatientAppointmentRepo appointmentRepo = PatientAppointmentRepo();
  bool _loader=false;
  bool get loader => _loader;
  bool _rescheduleLoader=false;
  bool get rescheduleLoader => _rescheduleLoader;
  bool _cancelLoader=false;
  bool get cancelLoader => _cancelLoader;

  String _error= '';
  String get errorMessage => _error;

  bool isUpcomingAptFetched=false;
  bool isCanceledAptFetched=false;
  bool isCompletedAptFetched=false;

  DoctorDetailsModel _doctorDetails=DoctorDetailsModel();
  DoctorDetailsModel get doctorDetails=>_doctorDetails;

  List<DoctorAvailableTimeSlots> _doctorTimeSlots =[];
  List<DoctorAvailableTimeSlots> get doctorTimeSlots=>_doctorTimeSlots;
  List<AppointmentInfo> _completedAppointments=[];
  List<AppointmentInfo> get completedAppointments => _completedAppointments;
  List<AppointmentInfo> _canceledAppointments=[];
  List<AppointmentInfo> get canceledAppointments => _canceledAppointments;
  List<AppointmentInfo> _upcomingAppointments=[];
  List<AppointmentInfo> get upcomingAppointments => _upcomingAppointments;

  List<DoctorDetailsModel> _doctorsList=[];
  List<DoctorDetailsModel> get doctorsList => _doctorsList;
  List<DoctorDetailsModel> _searchedDoctors=[];
  List<DoctorDetailsModel> get searched => _searchedDoctors;
  String? search;

  void setSearchedList(String? val){
    searched.clear();
    search=val;
    if(val==null || val.isEmpty==true){
      notifyListeners();
      return;
    }
    for (var element in doctorsList) {
      if(element.name?.toLowerCase().startsWith(val.toLowerCase())==true && !searched.contains(element)){
        searched.add(element);
      }
    }
    notifyListeners();
  }

  DoctorFilterModel _filterModel=DoctorFilterModel();
  DoctorFilterModel  get filterModel => _filterModel;


  void setFilter({  String? country, String? experienceYears, String? specialization,
    String? state, String? city, String? qualification,bool? resetSpecialization,bool? resetCity,bool? resetExp,bool? resetQualification,bool? resetCountry,bool? resetState}){
    _filterModel= _filterModel.copyWith(country: country,experienceYears: experienceYears,
         specialization: specialization,state: state,city: city,qualification: qualification,
        resetSpecialisation: resetSpecialization,resetCity:resetCity,resetExp: resetExp,resetQualification:resetQualification,resetCountry: resetCountry,resetState: resetState);
    notifyListeners();
  }

  void resetCity(){
  }

  void setError(String error)async{
    _error=error;
    notifyListeners();
  }

  Future<void> getDoctorsList(Function(ResponseMessage message) onResponse,{bool? applyFilter})async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await appointmentRepo.getDoctorsList(filter: applyFilter==true? filterModel.toJson():null);
    notifyListeners();
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      List map = apiResponse.response?.data ?? [];
      if(map.isNotEmpty){
        _doctorsList.clear();
        notifyListeners();
        for (var doctor in map) {
            _doctorsList.add(DoctorDetailsModel.fromJson(doctor));
            print(doctor);
            notifyListeners();
        }
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

  Future<void> getUpcomingAppointments(Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await appointmentRepo.getUpcomingAppointments();
    isUpcomingAptFetched=true;
    notifyListeners();
    log("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.success!=null&& response.data!=null){
        final doctorsList=response.data as List;
        _upcomingAppointments.clear();
        notifyListeners();
        for (var doctor in doctorsList) {
             log(doctor.toString());
            _upcomingAppointments.add(AppointmentInfo.fromJson(doctor));
            notifyListeners();
        }
      }else{
        _upcomingAppointments.clear();
        notifyListeners();
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
  Future<void> getCanceledAppointments(Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await appointmentRepo.getCanceledAppointments();
    isCanceledAptFetched=true;
    notifyListeners();
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.success!=null&& response.data!=null){
        final doctorsList=response.data as List;
        _canceledAppointments.clear();
        notifyListeners();
        for (var doctor in doctorsList) {
          _canceledAppointments.add(AppointmentInfo.fromJson(doctor));
            notifyListeners();
        }
      }else{
        _canceledAppointments.clear();
        notifyListeners();
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
  Future<void> getCompletedAppointments(Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await appointmentRepo.getCompletedAppointments();
    isCompletedAptFetched=true;
    notifyListeners();
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.success!=null&& response.data!=null){
        final doctorsList=response.data as List;
        _completedAppointments.clear();
        notifyListeners();
        for (var doctor in doctorsList) {
          _completedAppointments.add(AppointmentInfo.fromJson(doctor));
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

  Future<void> getDoctorDetails(String id, Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await appointmentRepo.getDoctorInfo(id);
    notifyListeners();
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      log('${map}doctorDetails');
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

  Future<void> getDoctorAvailableSlots(String date,String id, Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    Map<String,dynamic> data={
      'userId':"cm1fz5dov00026lqtgp43r38v",
      'date':date
    };
    ApiResponse apiResponse = await appointmentRepo.getDoctorTimingSlots(data);
    notifyListeners();
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.success!=null && response.data!=null){
        final doctorsTimeSlotsList=response.data as List;
        _doctorTimeSlots.clear();
        notifyListeners();
        for (var slot in doctorsTimeSlotsList) {
          _doctorTimeSlots.add(DoctorAvailableTimeSlots.fromJson(slot));
          notifyListeners();
        }
      }else{
        _doctorTimeSlots.clear();
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

  Future<void> bookAppointment(Map<String,dynamic> data, Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await appointmentRepo.bookAppointment(data);
    notifyListeners();
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
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

  Future<void> rescheduleAppointment(Map<String,dynamic> data, Function(ResponseMessage message) onResponse)async{
    _rescheduleLoader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await appointmentRepo.reScheduleAppointment(data);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      onResponse(response);
      await getUpcomingAppointments((r){});
      _rescheduleLoader=false;
      notifyListeners();
    }else{
      onResponse(ResponseMessage(error: apiResponse.error));
      _rescheduleLoader=false;
      _error=apiResponse.error;
      notifyListeners();
      print("Provider : ${apiResponse.error}");
    }
  }
  Future<void> cancelAppointment(Map<String,dynamic> data, Function(ResponseMessage message) onResponse)async{
    _cancelLoader=true;
    _error='';
    notifyListeners();
    print(data);
    ApiResponse apiResponse = await appointmentRepo.cancelAppointment(data);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      await getCanceledAppointments((r){});
      onResponse(response);
      _cancelLoader=false;
      notifyListeners();
    }else{
      onResponse(ResponseMessage(error: apiResponse.error));
      _cancelLoader=false;
      _error=apiResponse.error;
      notifyListeners();
      print("Provider : ${apiResponse.error}");
    }
  }

  Future<void> addReview(Map<String,dynamic> data, Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    print(data);
    ApiResponse apiResponse = await appointmentRepo.addReview(data);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      onResponse(response);
      _loader=false;
      notifyListeners();
    }else{
      onResponse(ResponseMessage(error: apiResponse.error));
      _loader=false;
      _error=apiResponse.error;
      notifyListeners();
      print("Provider : ${apiResponse.error}");
    }
  }

}
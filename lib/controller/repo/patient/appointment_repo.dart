import 'package:dio/dio.dart';
import 'package:kaustubha_medtech/controller/apis/api_responses/error_response.dart';
import 'package:kaustubha_medtech/controller/apis/api_urls.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
import '../../apis/api_responses/api_response.dart';
import '../../dio/dio_client.dart';

class PatientAppointmentRepo{
  final DioClient dioClient=DioClient(ApiUrls.baseUrl,Dio());

  Future<ApiResponse> getDoctorsList({Map<String,dynamic>? filter})async{
    try{
      UserInfo? userInfo=await LocalDB.getUserInfo();
      print({'userId':userInfo?.id,...?filter});
      Response response = await dioClient.post(ApiUrls.patientDoctorsList,data: {'userId':userInfo?.id,...?filter});
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getUpcomingAppointments()async{
    try{
      UserInfo? userInfo=await LocalDB.getUserInfo();
      Response response = await dioClient.post(ApiUrls.patientAppointment,data: {'userId':"${userInfo?.id}","status":[Constants.confirmed,Constants.notConfirm]});
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getCanceledAppointments()async{
    try{
      UserInfo? userInfo=await LocalDB.getUserInfo();
      Response response = await dioClient.post(ApiUrls.patientAppointment,data: {'userId':"${userInfo?.id}","status":[Constants.canceled]});
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCompletedAppointments()async{
    try{
      UserInfo? userInfo=await LocalDB.getUserInfo();
      Response response = await dioClient.post(ApiUrls.patientAppointment,data: {'userId':"${userInfo?.id}","status":[Constants.completed]});
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getDoctorInfo(String doctorId)async{
    try{
      Response response = await dioClient.post(ApiUrls.patientDoctorDetails,data: {'userId':doctorId});
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDoctorTimingSlots(Map<String,dynamic> data)async{
    try{
      Response response = await dioClient.post(ApiUrls.patientDoctorTimings,data:data);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> bookAppointment(Map<String,dynamic> data)async{
    try{
      Response response = await dioClient.post(ApiUrls.bookAppointment,data:data);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> reScheduleAppointment(Map<String,dynamic> data)async{
    try{
      Response response = await dioClient.post(ApiUrls.rescheduleAppointment,data:data);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print(e);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> cancelAppointment(Map<String,dynamic> data)async{
    try{
      Response response = await dioClient.post(ApiUrls.cancelAppointment,data:data);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print(e);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addReview(Map<String,dynamic> data)async{
    try{
      Response response = await dioClient.post(ApiUrls.addReview,data:data);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print(e);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}
import 'package:dio/dio.dart';
import 'package:kaustubha_medtech/controller/apis/api_responses/error_response.dart';
import 'package:kaustubha_medtech/controller/apis/api_urls.dart';

import '../../apis/api_responses/api_response.dart';
import '../../dio/dio_client.dart';

class UserRepo{
  final DioClient dioClient=DioClient(ApiUrls.baseUrl,Dio());

  Future<ApiResponse> getUserInfo(Map<String,dynamic> params)async{
    try{
      Response response = await dioClient.post(ApiUrls.userProfile, data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateProfile(Map<String,dynamic> params)async{
    try{
      Response response = await dioClient.post(ApiUrls.updateProfile, data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> sendNumberOTP(Map<String,dynamic> params)async{
    try{
      print(params);
      Response response = await dioClient.post(ApiUrls.updateSendNumberOTP, data:params );
      print(response.realUri.path);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> sendEmailOTP(Map<String,dynamic> params)async{
    try{
      Response response = await dioClient.post(ApiUrls.updateSendEmailOTP, data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyEmailOTP(Map<String,dynamic> params)async{
    try{
      print(params);
      Response response = await dioClient.post(ApiUrls.updateVerifyEmailOTP, data:params );
      print(response.realUri.path);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyNumberOTP(Map<String,dynamic> params)async{
    try{
      Response response = await dioClient.post(ApiUrls.updateVerifyNumberOTP, data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




}
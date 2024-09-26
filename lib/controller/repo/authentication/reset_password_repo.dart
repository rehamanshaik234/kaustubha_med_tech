import 'package:dio/dio.dart';
import 'package:kaustubha_medtech/controller/apis/api_responses/error_response.dart';
import 'package:kaustubha_medtech/controller/apis/api_urls.dart';
import 'package:kaustubha_medtech/views/screens/auth/login/forgot_password/verify_email.dart';

import '../../apis/api_responses/api_response.dart';
import '../../dio/dio_client.dart';

class ResetPasswordRepo{
  final DioClient dioClient=DioClient("https://www.kaustubhamedtech.com/api",Dio());

  Future<ApiResponse> sendEmailOtp(Map<String,dynamic> params)async{
    try{
      Response response = await dioClient.post(ApiUrls.sendResetPasswordEmailOtp,data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> sendPhoneOtp(Map<String,dynamic> params)async{
    try{
      print(params.toString());
      Response response = await dioClient.post(ApiUrls.sendResetPasswordPhoneOtp,data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> resetPassword(Map<String,dynamic> params)async{
    try{
      print(params.toString());
      Response response = await dioClient.post(ApiUrls.resetPassword, data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyOtp(Map<String,dynamic> params)async{
    try{
      Response response = await dioClient.post(ApiUrls.verifyResetPasswordOtp, data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}
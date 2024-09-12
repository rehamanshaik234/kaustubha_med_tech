import 'package:dio/dio.dart';
import 'package:kaustubha_medtech/controller/apis/api_responses/error_response.dart';
import 'package:kaustubha_medtech/controller/apis/api_urls.dart';
import 'package:kaustubha_medtech/views/screens/auth/login/forgot_password/verify_email.dart';

import '../../apis/api_responses/api_response.dart';
import '../../dio/dio_client.dart';

class LoginRepo{
  final DioClient dioClient=DioClient(ApiUrls.baseUrl,Dio());

  Future<ApiResponse> signInWithEmail(Map<String,dynamic> params)async{
    try{
      Response response = await dioClient.post(ApiUrls.logInWithEmail, data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> sendOTPNumber(Map<String,dynamic> params)async{
    try{
      print(params.toString());
      Response response = await dioClient.post(ApiUrls.sendLoginNumberOTP, data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyNumberOTP(Map<String,dynamic> params)async{
    try{
      Response response = await dioClient.post(ApiUrls.verifyLoginNumberOTP, data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}
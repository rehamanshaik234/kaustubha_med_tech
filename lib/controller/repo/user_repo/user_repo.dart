import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kaustubha_medtech/controller/apis/api_responses/error_response.dart';
import 'package:kaustubha_medtech/controller/apis/api_urls.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';

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
      print(params.toString());
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

  Future<ApiResponse> updateProfilePic(String userId,File? image)async{
    try{
      FormData formData = FormData.fromMap({
        'userId':userId,
        'image': await MultipartFile.fromFile(image!.path), // Add image file
      });
      Response response = await dioClient.post(ApiUrls.updateProfilePic, data:formData );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getEnrollmentStatus()async{
    try{
      UserInfo? userInfo=await LocalDB.getUserInfo();
      Map<String,dynamic> data={'userId':userInfo?.id};
      Response response = await dioClient.post(ApiUrls.enrollmentStatus, data:data );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kaustubha_medtech/controller/apis/api_responses/error_response.dart';
import 'package:kaustubha_medtech/controller/apis/api_urls.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';

import '../../apis/api_responses/api_response.dart';
import '../../dio/dio_client.dart';

class ChatRepo{
  final DioClient dioClient=DioClient(ApiUrls.baseUrl,Dio());

  Future<ApiResponse> getContactList(Map<String,dynamic> params)async{
    try{
      Response response = await dioClient.post(ApiUrls.contactLists, data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCommunities(Map<String,dynamic> params)async{
    try{
      Response response = await dioClient.post(ApiUrls.communities, data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> uploadFile(File? file)async{
    try{
      Options options = Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      );
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file!.path), // Add image file
      });
      print(file.path);
      Response response = await dioClient.post(ApiUrls.uploadFile, data:formData,options: options);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
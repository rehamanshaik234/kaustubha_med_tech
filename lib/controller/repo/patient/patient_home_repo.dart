import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kaustubha_medtech/controller/apis/api_responses/error_response.dart';
import 'package:kaustubha_medtech/controller/apis/api_urls.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';

import '../../apis/api_responses/api_response.dart';
import '../../dio/dio_client.dart';

class PatientHomeRepo{
  final DioClient dioClient=DioClient(ApiUrls.baseUrl,Dio());

  Future<ApiResponse> getRecommendedDoctors()async{
    try{
      Response response = await dioClient.get(ApiUrls.recommendedDoctors,);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getPatientDocuments()async{
    try{
      UserInfo? user=await LocalDB.getUserInfo();
      Response response = await dioClient.get("${ApiUrls.getPatientDocuments}?userId=${user?.id}",);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> uploadPatient(File? file1,File? file2)async{
    try{
      UserInfo? user=await LocalDB.getUserInfo();
      FormData formData =FormData.fromMap({'userId':user?.id});
      if(file1!=null){
        formData.files.add(MapEntry("document1", await MultipartFile.fromFile(file1.path)));
      }
      if(file2!=null){
        formData.files.add(MapEntry("document2", await MultipartFile.fromFile(file2.path)));
      }
      Response response = await dioClient.post(ApiUrls.uploadPatientDocument,data: formData);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




}
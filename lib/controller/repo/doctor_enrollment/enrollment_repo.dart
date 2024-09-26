import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kaustubha_medtech/controller/apis/api_responses/error_response.dart';
import 'package:kaustubha_medtech/controller/apis/api_urls.dart';

import '../../apis/api_responses/api_response.dart';
import '../../dio/dio_client.dart';

class EnrollmentRepo{
  final DioClient dioClient=DioClient(ApiUrls.baseUrl,Dio());

  Future<ApiResponse> enrollPersonalDetails(Map<String,dynamic> params)async{
    try{
      print(params.toString());
      Response response = await dioClient.post(ApiUrls.enrollPersonalDetails, data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> updateEnrollDetails(Map<String,dynamic> params)async{
    try{
      print(params.toString()+ApiUrls.updateProfileDetails);
      Response response = await dioClient.put(ApiUrls.updateProfileDetails, data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateTimingDetails(Map<String,dynamic> params)async{
    try{
      print(params.toString()+ApiUrls.updateTimingDetails);
      Response response = await dioClient.put(ApiUrls.updateTimingDetails, data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> enrolTimingDetails(Map<String,dynamic> params)async{
    try{
      print(params.toString());
      Response response = await dioClient.post(ApiUrls.enrollTimingsDetails, data:params );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> enrollLicenseAndCertificate(Map<String,dynamic> data,File? license,File? certificate)async{
    try{
      FormData formData = FormData.fromMap({
        ...data,
        'document1': await MultipartFile.fromFile(license!.path), // Add image file
        'document2': await MultipartFile.fromFile(certificate!.path), // Add image file
      });
      print(license.path);
      print(certificate.path);
      Response response = await dioClient.post(ApiUrls.enrollCertificates, data:formData );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateLicenseAndCertificate(Map<String,dynamic> data,File? license,File? certificate)async{
    try{
      FormData formData = FormData.fromMap({
        ...data, // Add your other data here
      });
      if (license != null) {
        formData.files.add(MapEntry(
          'document1',
          await MultipartFile.fromFile(license.path),
        ));
      }
      if (certificate != null) {
        formData.files.add(MapEntry(
          'document2',
          await MultipartFile.fromFile(certificate.path),
        ));
      }
      print(formData.files.length);
      Response response = await dioClient.put(ApiUrls.updateCertificateDetails, data:formData );
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}
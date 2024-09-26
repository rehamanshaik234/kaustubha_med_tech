import 'package:dio/dio.dart';
import 'package:kaustubha_medtech/controller/apis/api_responses/error_response.dart';
import 'package:kaustubha_medtech/controller/apis/api_urls.dart';
import 'package:kaustubha_medtech/views/screens/auth/login/forgot_password/verify_email.dart';

import '../../apis/api_responses/api_response.dart';
import '../../dio/dio_client.dart';

class TransactionRepo{
  final DioClient dioClient=DioClient(ApiUrls.baseUrl,Dio());

  Future<ApiResponse> getPatientTransactions(Map<String,dynamic> params)async{
    try{
      print(params.toString());
      Response response = await dioClient.get(ApiUrls.patientTransactions,queryParameters: params);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDoctorTransactions(Map<String,dynamic> params)async{
    try{
      print(params.toString());
      Response response = await dioClient.get(ApiUrls.doctorTransactions,queryParameters: params);
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
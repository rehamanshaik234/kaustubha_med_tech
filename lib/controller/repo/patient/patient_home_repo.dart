import 'package:dio/dio.dart';
import 'package:kaustubha_medtech/controller/apis/api_responses/error_response.dart';
import 'package:kaustubha_medtech/controller/apis/api_urls.dart';

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


}
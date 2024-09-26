import 'package:dio/dio.dart';
import 'package:kaustubha_medtech/controller/apis/api_responses/error_response.dart';
import 'package:kaustubha_medtech/controller/apis/api_urls.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import '../../apis/api_responses/api_response.dart';
import '../../dio/dio_client.dart';

class DoctorPatientsRepo{
  final DioClient dioClient=DioClient(ApiUrls.baseUrl,Dio());

  Future<ApiResponse> getPatientsList({Map<String,dynamic>? filter})async{
    try{
      UserInfo? userInfo=await LocalDB.getUserInfo();
      print({'userId':userInfo?.id,...?filter});
      Response response = await dioClient.post(ApiUrls.doctorPatients,data: {'userId':userInfo?.id,...?filter});
      return ApiResponse.withSuccess(response);
    }
    catch(e){
      print("Api Response data exceptionerror= $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
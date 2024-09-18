import 'package:flutter/cupertino.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/repo/tracker/tracker.dart';
import 'package:kaustubha_medtech/models/tracker/TrackerModel.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';

import '../../../models/connectivity/error_model.dart';
import '../../apis/api_responses/api_response.dart';

class TrackerProvider extends ChangeNotifier{
  bool _loader=false;
  bool get loader => _loader;

  String _error= '';
  String get errorMessage => _error;

  TrackerModel _trackerModel =TrackerModel();
  TrackerModel get tracker => _trackerModel;

  void setError(String error)async{
    _error=error;
    notifyListeners();
  }



  TrackerRepo trackerRepo=TrackerRepo();

  Future<void> getPatientTracker(Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    UserInfo? userid=await LocalDB.getUserInfo();
    Map<String,dynamic> params= { UserInfo.userIdKey :'cm17poi7w0000ezs4a5h6awyx'} ;
    ApiResponse apiResponse = await trackerRepo.getPatientTracker(params);
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data;
      final response = ResponseMessage.fromJson(map);
      if(response.error==null){
        _trackerModel=TrackerModel.fromJson(map);
        notifyListeners();
      }else{
        _error=response.error ?? '';
        notifyListeners();
      }
      onResponse(response);
      _loader=false;
      notifyListeners();
    }else{
      onResponse(ResponseMessage(error: apiResponse.error));
      _loader=false;
      _error=apiResponse.error;
      notifyListeners();
      print("Provider : APiResponse.Error");
    }
  }
}
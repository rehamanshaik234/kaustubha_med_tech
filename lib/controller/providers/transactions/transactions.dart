import 'package:flutter/cupertino.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/repo/tracker/tracker.dart';
import 'package:kaustubha_medtech/controller/repo/transactions_repo/transaction_repo.dart';
import 'package:kaustubha_medtech/models/tracker/TrackerModel.dart';
import 'package:kaustubha_medtech/models/transactions/TransactionModel.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';

import '../../../models/connectivity/error_model.dart';
import '../../apis/api_responses/api_response.dart';

class TransactionsProvider extends ChangeNotifier{
  bool _loader=false;
  bool get loader => _loader;

  String _error= '';
  String get errorMessage => _error;

  List<TransactionModel> _transactionModel =[];
  List<TransactionModel> get transactions => _transactionModel;

  void setError(String error)async{
    _error=error;
    notifyListeners();
  }



  TransactionRepo transactionRepo=TransactionRepo();

  Future<void> getPatientTransactions(Function(ResponseMessage message) onResponse,{String? date})async{
    _loader=true;
    _error='';
    notifyListeners();
    UserInfo? userid=await LocalDB.getUserInfo();
    Map<String,dynamic> params= {'userId' : userid?.id} ;
    if(date!=null){
      params['date']=date;
    }
    ApiResponse apiResponse = await transactionRepo.getPatientTransactions(params);
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data;
      final response = ResponseMessage.fromJson(map);
      if(response.error==null){
        List data=response.data as List;
        if(data.isNotEmpty) {
          _transactionModel.clear();
          notifyListeners();
          for (var review in data) {
            _transactionModel.add(TransactionModel.fromJson(review));
            notifyListeners();
          }
        }
        else{
          _transactionModel.clear();
          notifyListeners();
        }
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



  Future<void> getDoctorTransactions(Function(ResponseMessage message) onResponse,{String? date})async{
    _loader=true;
    _error='';
    notifyListeners();
    UserInfo? userid=await LocalDB.getUserInfo();
    Map<String,dynamic> params= {'doctorId' :userid?.id} ;
    if(date!=null){
      params['date']=date;
    }
    ApiResponse apiResponse = await transactionRepo.getDoctorTransactions(params);
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data;
      final response = ResponseMessage.fromJson(map);
      if(response.error==null){
        List data=response.data as List;
        if(data.isNotEmpty) {
          _transactionModel.clear();
          notifyListeners();
          for (var review in data) {
            _transactionModel.add(TransactionModel.fromJson(review));
            notifyListeners();
          }
        }
        else{
          _transactionModel.clear();
          notifyListeners();
        }
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
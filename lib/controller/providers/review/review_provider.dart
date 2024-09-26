import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaustubha_medtech/controller/repo/review/review_repo.dart';
import 'package:kaustubha_medtech/models/appointments/DoctorDetailsModel.dart';
import 'package:kaustubha_medtech/models/reviews/ReviewModel.dart';
import '../../../models/connectivity/error_model.dart';
import '../../apis/api_responses/api_response.dart';

class ReviewProvider extends ChangeNotifier{
  ReviewRepo reviewRepo=ReviewRepo();
  bool _loader=false;
  bool get loader => _loader;
  String _error= '';
  String get errorMessage => _error;
  List<ReviewModel> _reviews = [];
  List<ReviewModel> get reviews => _reviews;

  Future<void> getDoctorReviews(Map<String,dynamic> data, Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await reviewRepo.getReviews(data);
    notifyListeners();
    print("apiResponse.Data.success ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.message!=null && response.reviews!=null){
        List data=response.reviews as List;
        if(data.isNotEmpty) {
          _reviews.clear();
          notifyListeners();
          for (var review in data) {
            _reviews.add(ReviewModel.fromJson(review));
            notifyListeners();
          }
        }
        else{
          _reviews.clear();
          notifyListeners();
        }
        onResponse(response);
      }else{
        _reviews.clear();
        notifyListeners();
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
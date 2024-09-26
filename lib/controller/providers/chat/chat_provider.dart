import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaustubha_medtech/controller/repo/chat-repo/chat_repo.dart';
import 'package:kaustubha_medtech/controller/repo/review/review_repo.dart';
import 'package:kaustubha_medtech/models/appointments/DoctorDetailsModel.dart';
import 'package:kaustubha_medtech/models/chat/CommunityModel.dart';
import 'package:kaustubha_medtech/models/chat/ContactInfo.dart';
import 'package:kaustubha_medtech/models/reviews/ReviewModel.dart';
import '../../../models/connectivity/error_model.dart';
import '../../apis/api_responses/api_response.dart';

class ChatProvider extends ChangeNotifier{
  ChatRepo chatRepo=ChatRepo();
  bool _loader=false;
  bool get loader => _loader;
  String _error= '';
  String get errorMessage => _error;
  List<ContactInfo> _contacts = [];
  List<ContactInfo> get contacts => _contacts;

  List<CommunityModel> _communities = [];
  List<CommunityModel> get communities => _communities;


  void addCommunity(CommunityModel community){
    _communities.insert(0, community);
    notifyListeners();
  }



  Future<void> getContactLists(Map<String,dynamic> data, Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await chatRepo.getContactList(data);
    notifyListeners();
    log("apiResponse.Contact List ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.success!=null && response.data!=null && response.data['updatedData']!=null){
        List data=ResponseMessage(data: response.data['updatedData']).data as List;
        if(data.isNotEmpty) {
          _contacts.clear();
          notifyListeners();
          for (var contact in data) {
            _contacts.add(ContactInfo.fromJson(contact));
            notifyListeners();
          }
        }
        else{
          _contacts.clear();
          notifyListeners();
        }
        onResponse(response);
      }else{
        _contacts.clear();
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

  Future<void> getCommunities(Map<String,dynamic> data, Function(ResponseMessage message) onResponse)async{
    _loader=true;
    _error='';
    notifyListeners();
    ApiResponse apiResponse = await chatRepo.getCommunities(data);
    notifyListeners();
    log("apiResponse.Contact List ${apiResponse.response?.data.toString()}");
    if( apiResponse.response != null && apiResponse.response?.statusCode == 200 ){
      Map map = apiResponse.response!.data ?? {};
      final response = ResponseMessage.fromJson(map);
      if(response.success!=null && response.data!=null){
        final data= response.data as List;
        if(data.isNotEmpty) {
          _communities.clear();
          notifyListeners();
          for (var contact in data) {
            _communities.add(CommunityModel.fromJson(contact));
            notifyListeners();
          }
        }
        else{
          _communities.clear();
          notifyListeners();
        }
        onResponse(response);
      }else{
        _communities.clear();
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
import 'dart:convert';
import 'dart:math';

import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDB{
  static Future<SharedPreferences> get _preferences => SharedPreferences.getInstance();
  static String userInfoKey='userInfoKey';
  static String userLogin='user_login';
  static String shownBoardingScreen='shown_boarding';

  static Future<UserInfo?> getUserInfo()async{
    SharedPreferences sharedPreferences= await _preferences;
    String? info=sharedPreferences.getString(userInfoKey);
    if(info!=null){
      UserInfo userInfo= UserInfo.fromJson(jsonDecode(info));
      return userInfo;
    }
    return null;
  }


  static Future<bool> getUserLogin()async{
    SharedPreferences sharedPreferences= await _preferences;
    return sharedPreferences.getBool(userLogin) ?? false;
  }

  static Future<bool> getShownBoarding()async{
    SharedPreferences sharedPreferences= await _preferences;
    return sharedPreferences.getBool(shownBoardingScreen) ?? false;
  }



  ///set
  static Future<bool> setUserInfo(UserInfo userInfo)async{
    SharedPreferences sharedPreferences= await _preferences;
    String info=jsonEncode(userInfo);
    return await sharedPreferences.setString(userInfoKey, info);
  }

  static Future<bool> setShownBoarding(bool shown)async{
    print(shown);
    SharedPreferences sharedPreferences= await _preferences;
    return await sharedPreferences.setBool(shownBoardingScreen, shown);
  }

  static Future<bool> setUserLogin(bool login)async{
    SharedPreferences sharedPreferences= await _preferences;
    return await sharedPreferences.setBool(userLogin, login);
  }


  static Future<bool> logout()async{
    SharedPreferences sharedPreferences= await _preferences;
    await sharedPreferences.clear();
    return await setShownBoarding(true);
  }
}
import 'package:flutter/material.dart';
class ApiUrls{
  static String baseUrl='https://kaustubhamedtech.vercel.app/api/';

  ///signUp
  static String signUpWithEmail='v1/auth/register/email-register';
  static String signUpWithNumber='v1/auth/register/phone-register';
  static String sendSignUpOTPNumber='v1/auth/register/send-otp';
  static String verifyEmail='v1/auth/register/verify-email';


  ///login
  static String logInWithEmail='/v1/auth/login/password-login';
  static String verifyLoginNumberOTP='v1/auth/login/otp-login';
  static String sendLoginNumberOTP='v1/auth/login/send-otp';

}
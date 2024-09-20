import 'package:flutter/material.dart';
class ApiUrls{
  static String baseUrl='https://kaustubhamedtech.vercel.app/api/v1';

  ///signUp
  static String signUpWithEmail='/auth/register/email-register';
  static String signUpWithNumber='/auth/register/phone-register';
  static String sendSignUpOTPNumber='/auth/register/send-otp';
  static String verifyEmail='/auth/register/verify-email';


  ///login
  static String logInWithEmail='/auth/login/password-login';
  static String verifyLoginNumberOTP='/auth/login/otp-login';
  static String sendLoginNumberOTP='/auth/login/send-otp';

  ///Tracker
  static String patientTracker='/patients/tracker/get';

  ///profile
  static String userProfile='/profile/get-by-id';
  static String updateProfile='/profile/update';
  static String updateSendEmailOTP='/profile/update/send-email-otp';
  static String updateSendNumberOTP='/profile/update/send-number-otp';
  static String updateVerifyEmailOTP='/profile/update/verify-email-otp';
  static String updateVerifyNumberOTP='/profile/update/verify-number-otp';
}
import 'package:flutter/material.dart';
class ApiUrls{
  static String baseUrl='https://www.kaustubhamedtech.com/api/v1';

  ///signUp
  static String signUpWithEmail='/auth/register/email-register';
  static String signUpWithNumber='/auth/register/phone-register';
  static String sendSignUpOTPNumber='/auth/register/send-otp';
  static String verifyEmail='/auth/register/verify-email';
  static String enrollmentStatus='/doctor/enrollment-status';


  ///login
  static String logInWithEmail='/auth/login/password-login';
  static String verifyLoginNumberOTP='/auth/login/otp-login';
  static String sendLoginNumberOTP='/auth/login/send-otp';


  ///patientHome
  static String recommendedDoctors='/patients/dashboard/recomended-doctor';
  static String getPatientDocuments='/patients/document-upload/get';
  static String uploadPatientDocument='/patients/document-upload';


  ///doctor
  static String doctorAppointment='/doctor/appointment/get-all';
  static String doctorAppointmentConfirm='/doctor/appointment/confirm';
  static String doctorPatients='/doctor/all-patients-by-id';

  ///chat
  static String contactLists='/chat/contact-list';
  static String communities='/chat/get-communities';
  static String uploadFile='/chat/upload-file';

  ///patientAppointment
  static String patientDoctorsList='/patients/doctor-list';
  static String patientAppointment='/patients/appointment/get-all';
  static String patientDoctorDetails='/doctor/detail-by-id';
  static String patientDoctorTimings='/doctor/appointments-by-date';
  static String bookAppointment='/patients/appointment/book';
  static String rescheduleAppointment='/patients/appointment/reschedule';
  static String cancelAppointment='/patients/appointment/cancel';
  static String addReview='/doctor/review/add';
  static String doctorReviews='/doctor/review/get';

  ///Tracker
  static String patientTracker='/patients/tracker/get';

  ///Transactions
  static String patientTransactions='/patients/payment/get';
  static String doctorTransactions='/doctor/payment/get';

  ///profile
  static String userProfile='/profile/get-by-id';
  static String updateProfile='/profile/update';
  static String updateSendEmailOTP='/profile/update/send-email-otp';
  static String updateSendNumberOTP='/profile/update/send-number-otp';
  static String updateVerifyEmailOTP='/profile/update/verify-email-otp';
  static String updateVerifyNumberOTP='/profile/update/verify-number-otp';

  ///user
  static String updateProfilePic='/profile/profile-pic';

  ///doctorEnrollment
  static String updateProfileDetails='/doctor/enroll/update/profile';
  static String updateTimingDetails='/doctor/enroll/update/details';
  static String updateCertificateDetails='/doctor/enroll/update/certificate';

  ///updateDoctorEnrollment
  static String enrollPersonalDetails='/doctor/enroll/profile';
  static String enrollTimingsDetails='/doctor/enroll/details';
  static String enrollCertificates='/doctor/enroll/certificate';
}
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/authentication/login_provider.dart';
import 'package:kaustubha_medtech/models/login/LoginModel.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/utils/routes/route_names/route_names.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_logo_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
import 'package:kaustubha_medtech/views/widgets/dont_have_account.dart';
import 'package:kaustubha_medtech/views/widgets/logo.dart';
import 'package:kaustubha_medtech/views/widgets/phone_text_field.dart';
import 'package:phone_text_field/model/phone_number.dart';
import 'package:provider/provider.dart';

import '../../../../models/connectivity/error_model.dart';
import '../../../../utils/constants/constants.dart';
import '../../../alerts/custom_alerts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController password=TextEditingController();
  PhoneNumber? phoneNumber;
  late GoogleSignIn googleSignIn;

  @override
  void initState() {
    if(Platform.isAndroid) {
      googleSignIn = GoogleSignIn(scopes: ['email'],);
    }else{
      googleSignIn= GoogleSignIn(scopes: ['email'],clientId: '64130647433-3a8orgrdtrrntpnj3ltkgjh9g9odn0oo.apps.googleusercontent.com');
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<LoginProvider>(
        builder: (context,provider,child) {
          return Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 1.sh*0.08),
                  LogoWidget(),
                  SizedBox(height: 1.sh*0.08),
                  Text("Log in",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 24.sp)),
                  SizedBox(height: 1.sh*0.04),
                  Visibility(
                    visible: !Constants.emailRegex.hasMatch(email.text),
                    child: PhoneNumberTextField(hintText: "Phone", initialValue: phone.text,onChange: (text){
                      phone.text=text?.completeNumber ?? '';
                      phoneNumber=text;
                      setState(() {});
                      },
                      onSubmit:(number){
                        phone.text = number.toString();
                        setState(() {});
                      } ,
                    ),
                  ),
                  Visibility(
                    visible: !checkIsNumberValid(),
                      child: SizedBox(
                        child: Column(
                          children: [
                          SizedBox(height: 24.h,),
                          CustomTextField(hintText: "Email", textEditingController: email,onChange: (text){setState(() {});},),
                          SizedBox(height: 24.h,),
                          CustomTextField(hintText: "Password", textEditingController: password,isPassword: true,),
                        ],
                    ),
                  )),
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () => Navigator.pushNamed(context,RoutesName.selectVerificationType),
                          child: Text('Forgot Password?',style: GoogleFonts.inter(fontWeight: FontWeight.w500,fontSize: 14.sp),)),
                    ],
                  ),
                  SizedBox(height: 24.h,),
                  CustomButton(onPressed: ()=>login(provider), title: "Log in",loader: provider.loader,),
                  SizedBox(height: 32.h,),
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey,height: 2.h,)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text('Or Login with',style: GoogleFonts.inter(fontWeight: FontWeight.normal,fontSize: 16.sp,color: Colors.black54),),
                      ),
                      Expanded(child: Divider(color: Colors.grey,height: 2.h,))
                    ],
                  ),
                  SizedBox(height: 32.h,),
                  Row(
                    children: [
                      Expanded(
                        child: CustomLogoButton(onPressed: ()=>loginWithEmail(provider), title: "Continue With Google", logoUrl: AssetUrls.googleLogo,loading: provider.signInLoader,),
                      ),
                    ],
                  ),
                  // SizedBox(height: 24.h,),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: CustomLogoButton(onPressed: (){}, title: "Continue With Apple", logoUrl: AssetUrls.appleLogo),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 40.h,),
                  const DontHaveAccountWidget(),
                  SizedBox(height: 32.h,),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  void logInWithEmailPwd(LoginProvider provider)async{
    if(validateEmail()){
      LoginModel loginModel=LoginModel(email: email.text,password: password.text);
      provider.loginWithEmilPwd(loginModel, onLoginEmailResponse);
    }
  }

  void login(LoginProvider provider)async{
    if(phone.text.isNotEmpty && checkIsNumberValid()){
      logInWithNumber(provider);
    }else{
      logInWithEmailPwd(provider);
    }
  }

  void logInWithNumber(LoginProvider provider)async{
      if(validateNumber()){
        LoginModel loginModel = LoginModel(phone: phone.text);
        provider.sendOTPNumber(loginModel, onSendOTPNumberResponse);
      }
  }

  void loginWithEmail(LoginProvider provider)async {
    final result=await googleSignIn.signIn();
    googleSignIn.signOut();
    if(result==null && result?.email==null){
      return;
    }
    await provider.loginWithEmail(result!.email.toString(), onLoginEmailResponse);
  }

  void onSendOTPNumberResponse(ResponseMessage message) {
    if (message.success != null) {
      Map<String, dynamic>? arguments = {'number': phone.text};
      Navigator.pushNamed(context, RoutesName.verifyLoginOTP, arguments: arguments);
    } else {
      CustomPopUp.showSnackBar(context, "${message.error}", Colors.redAccent);
    }
  }

  void onLoginEmailResponse(ResponseMessage message) {
    if (message.success != null) {
      UserInfo userInfo=UserInfo.fromJson(message.user);
      if(userInfo.emailVerified==null&& userInfo.numberVerified==false){
        Navigator.pushNamed(context, RoutesName.verifySignUpOTP,arguments: {'email':userInfo.email});
        return;
      }
      CustomPopUp.showSnackBar(context, "${message.success}", Colors.green);
      LocalDB.setUserLogin(true);
      LocalDB.setUserInfo( UserInfo.fromJson(message.user));
      Navigator.pushNamedAndRemoveUntil(context,UserInfo.fromJson(message.user).role==Constants.patientRole? RoutesName.patientMain:RoutesName.doctorMain,(r)=>false);
    } else {
      CustomPopUp.showSnackBar(context, "${message.error}", Colors.redAccent);
    }
  }

  bool validateEmail(){
    if (email.text.isEmpty && phone.text.isEmpty) {
      CustomPopUp.showSnackBar(context, "Enter Email or Number", Colors.redAccent);
      return false;
    }
    else if (email.text.isNotEmpty && !Constants.emailRegex.hasMatch(email.text)) {
      CustomPopUp.showSnackBar(context, "Enter Valid Email", Colors.redAccent);
      return false;
    } else if(validatePasswords()){
      return true;
    } else {
      return true;
    }
  }

  bool validatePasswords() {
    if (password.text.isEmpty) {
      CustomPopUp.showSnackBar(context, "Enter Password", Colors.redAccent);
      return false;
    } else {
      return true;
    }
  }

  bool validateNumber() {
    if (phone.text.isEmpty) {
      CustomPopUp.showSnackBar(context, "Enter Phone Number", Colors.redAccent);
      return false;
    }
    try {
      if (phoneNumber?.isValidNumber() != true) {
        CustomPopUp.showSnackBar(context, "Enter Valid Number", Colors.redAccent);
        return false;
      }
    } catch (e) {
      if (e is NumberTooShortException) {
        CustomPopUp.showSnackBar(context, "Phone number is too short", Colors.redAccent);
      } else {
        CustomPopUp.showSnackBar(context, "Enter Valid Number", Colors.redAccent);
      }
      return false;
    }
    return true;
  }


  bool checkIsNumberValid(){
    try {
      if (phoneNumber?.isValidNumber() != true) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }


  void loginWithGmail()async{
    final resp= await googleSignIn.signIn();
    if(resp!=null && resp.email.isNotEmpty){

    }
  }



}

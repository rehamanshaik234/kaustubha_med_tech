import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/authentication/login_provider.dart';
import 'package:kaustubha_medtech/models/login/LoginModel.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_logo_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
import 'package:kaustubha_medtech/views/widgets/dont_have_account.dart';
import 'package:kaustubha_medtech/views/widgets/logo.dart';
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
  TextEditingController emailOrNumber=TextEditingController();
  TextEditingController password=TextEditingController();
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
                  CustomTextField(hintText: "Email or Number", textEditingController: emailOrNumber,onChange: (text){setState(() {});},),
                  Visibility(
                    visible: !Constants.isNumeric(emailOrNumber.text),
                    child: SizedBox(
                      child: Column(
                        children: [
                          SizedBox(height: 24.h,),
                          CustomTextField(hintText: "Password", textEditingController: password,isPassword: true,),
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: ()=>Navigator.pushNamed(context,RoutesName.selectVerificationType),
                                  child: Text('Forgot Password?',style: GoogleFonts.inter(fontWeight: FontWeight.w500,fontSize: 14.sp),)),
                            ],
                          ),
                        ],
                      ),
                    ),
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
                        child: CustomLogoButton(onPressed: (){}, title: "Continue With Google", logoUrl: AssetUrls.googleLogo),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h,),
                  Row(
                    children: [
                      Expanded(
                        child: CustomLogoButton(onPressed: (){}, title: "Continue With Apple", logoUrl: AssetUrls.appleLogo),
                      ),
                    ],
                  ),
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
      LoginModel loginModel=LoginModel(email: emailOrNumber.text,password: password.text);
      provider.loginWithEmilPwd(loginModel, onSignUpEmailResponse);
    }
  }

  void login(LoginProvider provider)async{
    if(Constants.isNumeric(emailOrNumber.text)){
      logInWithNumber(provider);
    }else{
      logInWithEmailPwd(provider);
    }
  }

  void logInWithNumber(LoginProvider provider)async{
    if(validateNumber()){
      LoginModel loginModel=LoginModel(phone: "+91${emailOrNumber.text}");
      provider.sendOTPNumber(loginModel, onSendOTPNumberResponse);
    }
  }

  void onSendOTPNumberResponse(ResponseMessage message) {
    if (message.success != null) {
      Map<String, dynamic>? arguments = {'number': "+91${emailOrNumber.text}"};
      Navigator.pushNamed(context, RoutesName.verifyLoginOTP, arguments: arguments);
    } else {
      CustomPopUp.showSnackBar(context, "${message.error}", Colors.redAccent);
    }
  }

  void onSignUpEmailResponse(ResponseMessage message) {
    if (message.success != null) {
      CustomPopUp.showSnackBar(context, "${message.success}", Colors.greenAccent);
    } else {
      CustomPopUp.showSnackBar(context, "${message.error}", Colors.redAccent);
    }
  }


  bool validateEmail(){
    if (emailOrNumber.text.isEmpty) {
      CustomPopUp.showSnackBar(context, "Enter Email or Number", Colors.redAccent);
      return false;
    } else if (!Constants.emailRegex.hasMatch(emailOrNumber.text)) {
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


  bool validateNumber(){
    if(emailOrNumber.text.replaceAll(" ", '').length!=10){
      CustomPopUp.showSnackBar(context, "Enter Valid Number", Colors.redAccent);
      return false;
    }else{
      return true;
    }
  }

}

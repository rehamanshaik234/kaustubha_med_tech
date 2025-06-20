import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kaustubha_medtech/models/connectivity/error_model.dart';
import 'package:kaustubha_medtech/models/sign_up/SignUpModel.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/views/widgets/already_have_acnt_widget.dart';
import 'package:kaustubha_medtech/views/widgets/logo.dart';
import 'package:provider/provider.dart';
import 'package:kaustubha_medtech/controller/providers/authentication/sign_up_provider.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';


class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController emailOrNumber=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController fullName=TextEditingController();
  TextEditingController confirmPassword=TextEditingController();
  bool agreeTerms=false;
  bool isUser=true;
  FocusNode numberScope=FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<SignUpProvider>(
          builder: (context,provider,child) {
            return Padding(
              padding: EdgeInsets.only(top:16.sp,left: 16.sp,right: 16.sp),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 1.sh*0.05),
                    const LogoWidget(),
                    SizedBox(height: 24.h),
                    Text("Sign Up",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 24.sp)),
                    SizedBox(height: 24.h),
                    selectUserTypeWidget(),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.sp),
                              border: Border.all(color: Colors.black54),
                            ),
                            child: Image(image: AssetImage(AssetUrls.fbLogo)),
                          ),
                        ),
                        SizedBox(width: 20.w,),
                        Expanded(
                          child: InkWell(
                            onTap: ()async{
                              await GoogleSignIn(clientId: "609903566583-ph449lcrplvca4hhiv3r0ddhlnsf3krr.apps.googleusercontent.com").signIn();
                            },
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(color: Colors.black54),
                              ),
                              child: Image(image: AssetImage(AssetUrls.googleLogo)),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w,),
                        Expanded(
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.sp),
                              border: Border.all(color: Colors.black54),
                            ),
                            child: Image(image: AssetImage(AssetUrls.appleLogo)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    CustomTextField(hintText: "Email or Number",textEditingController: emailOrNumber,onChange: (text){
                      setState(() {});
                    },),
                    SizedBox(height: 16.h,),
                    CustomTextField(hintText: "Full Name",textEditingController: fullName),
                    SizedBox(height: 16.h,),
                    CustomTextField(hintText: "Password",isPassword: true,textEditingController: password, onChange: (text)=>setState(() {}),),
                    SizedBox(height: 8.h,),
                    agreeWithTermsConditions(),
                    SizedBox(height: 24.h,),
                    CustomButton(onPressed: ()=>signUp(provider), title: "Sign Up",loader: provider.loader,),
                    SizedBox(height: 24.h,),
                    const AlreadyHaveAccountWidget(),
                    SizedBox(height: 24.h,),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }




  void signUp(SignUpProvider provider)async{
    if(validateFields()){
      // SignUpModel signUpModel=SignUpModel(email: emailOrNumber.text,role: isUser?'USER':'DOCTOR',name: fullName.text);
      // await provider.signUp(signUpModel, onResponse);
      Map<String,dynamic>? arguments;
      if(Constants.isNumeric(emailOrNumber.text)){
        arguments={'email':emailOrNumber.text};
      }else{
        arguments={'number':emailOrNumber.text};
      }
      Navigator.pushNamed(context, RoutesName.verifySignUpOTP,arguments: arguments);
    }
  }

  bool validateFields(){
    return validateEmailOrNumber() && validateName() && validatePasswords() && validateTerms();
  }

  bool validatePasswords(){
    if(password.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Enter Password", Colors.redAccent);
      return false;
    }else if(password.text.length<6){
      CustomPopUp.showSnackBar(context, "Password Must Contains 6 Characters", Colors.redAccent);
      return false;
    }else{
      return true;
    }
  }


  bool validateEmailOrNumber(){
    if (emailOrNumber.text.isEmpty) {
      CustomPopUp.showSnackBar(context, "Enter Email or Number", Colors.redAccent);
      return false;
    } else if(Constants.isNumeric(emailOrNumber.text)){
      return validateNumber();
    } else if (!Constants.emailRegex.hasMatch(emailOrNumber.text)) {
      CustomPopUp.showSnackBar(
          context, "Enter Valid Email", Colors.redAccent);
      return false;
    } else {
      return true;
    }
  }

  bool validateName(){
    if(fullName.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Enter Name", Colors.redAccent);
      return false;
    }else{
      return true;
    }
  }

  bool validateTerms(){
    if(!agreeTerms){
      CustomPopUp.showSnackBar(context, "Agree Terms and Conditions", Colors.redAccent);
      return false;
    }
    return true;
  }

  bool validateNumber(){
    if(emailOrNumber.text.replaceAll(" ", '').length!=10){
      CustomPopUp.showSnackBar(context, "Enter Valid Number", Colors.redAccent);
      numberScope.requestFocus();
      return false;
    }else{
      return true;
    }
  }

  Widget agreeWithTermsConditions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: agreeTerms, onChanged: (val){
          agreeTerms=val ?? false;
          setState(() {

          });
        },
          activeColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.sp)),),
        Expanded(
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: 'I agree With ',
              style: GoogleFonts.inter(color: Colors.black),
              children: [
                TextSpan(
                  text: 'Terms & Conditions',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline, // Add underline
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('Terms and Conditions tapped');
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget selectUserTypeWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Card(
          color:isUser? AppColors.secondaryColor:Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: InkWell(
            onTap: (){
              if(!isUser){
                isUser=true;
                setState(() {

                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp),
                border: Border.all(color: Colors.black),
              ),
              padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(isUser? Icons.person:Icons.person_outline,color: Colors.black,size: 22.sp,),
                  SizedBox(width: 8.w,),
                  Text("User",style: GoogleFonts.inter(fontWeight:isUser? FontWeight.bold:FontWeight.w500,fontSize: 20.sp)),
                ],
              ),
            ),
          ),
        ),
        Card(
          color:!isUser? AppColors.secondaryColor:Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: InkWell(
            onTap: (){
              if(isUser){
                isUser=false;
                setState(() {

                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp),
                border: Border.all(color: Colors.black),
              ),
              padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(!isUser? Icons.medical_services:Icons.medical_services_outlined,color: Colors.black,size: 22.sp,),
                  SizedBox(width: 8.w,),
                  Text("Doctor",style: GoogleFonts.inter(fontWeight:!isUser? FontWeight.bold:FontWeight.w500,fontSize: 20.sp)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void onResponse(ResponseMessage message){
    if(message.success!=null){
      CustomPopUp.showSnackBar(context, "${message.success}", Colors.green);
    }else{
      CustomPopUp.showSnackBar(context, "${message.error}", Colors.redAccent);
    }
  }
}

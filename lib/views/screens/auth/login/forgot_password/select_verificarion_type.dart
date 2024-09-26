import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/authentication/reset_password.dart';
import 'package:kaustubha_medtech/models/connectivity/error_model.dart';
import 'package:kaustubha_medtech/utils/routes/route_names/route_names.dart';
import 'package:kaustubha_medtech/views/widgets/phone_text_field.dart';
import 'package:phone_text_field/model/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:kaustubha_medtech/controller/providers/authentication/sign_up_provider.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_back_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';

class VerificationType extends StatefulWidget {
  const VerificationType({super.key});

  @override
  State<VerificationType> createState() => _VerificationTypeState();
}

class _VerificationTypeState extends State<VerificationType> {
  TextEditingController email=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController password=TextEditingController();
  FocusNode numberFocus=FocusNode();
  FocusNode emailFocus=FocusNode();
  PhoneNumber? phoneNumber;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<SignUpProvider>(context,listen: false).setVerifiedNumber(false);
      Provider.of<SignUpProvider>(context,listen: false).setNumber("");
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ResetPasswordProvider>(
          builder: (context,provider,child) {
            return Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h,),
                    CustomBackButton(onPressed: ()=>Navigator.pop(context),),
                    SizedBox(height: 20.h,),
                    Text("Forgot Password?",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 30.sp)),
                    Text("Please enter your email or number to reset the password",style: GoogleFonts.inter(fontWeight: FontWeight.normal,fontSize: 14.sp)),
                    SizedBox(height: 30.h,),
                    Text('Your Number',style: GoogleFonts.inter(fontWeight: FontWeight.normal,fontSize: 16.sp),),
                    SizedBox(height: 10.h,),
                    PhoneNumberTextField(hintText: "Enter Number",inputType: TextInputType.number,initialValue: number.text,focusNode: numberFocus,outlinedBorder: true,
                      onChange: (text){
                        number.text=text?.completeNumber ?? '';
                        phoneNumber=text;
                        setState(() {});
                      },
                      onSubmit:(number){
                        this.number.text = number.toString();
                        setState(() {});
                      } ,
                    ),
                    SizedBox(height: 20.h,),
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey,height: 2.h,)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text('Or',style: GoogleFonts.inter(fontWeight: FontWeight.normal,fontSize: 16.sp,color: Colors.black54),),
                        ),
                        Expanded(child: Divider(color: Colors.grey,height: 2.h,))
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Text('Your Email',style: GoogleFonts.inter(fontWeight: FontWeight.normal,fontSize: 16.sp),),
                    SizedBox(height: 10.h,),
                    CustomTextField(hintText: "Enter Email", textEditingController: email,focusNode: emailFocus,outlinedBorder: true,),
                    SizedBox(height: 30.h,),
                    CustomButton(onPressed: ()=>validateFields(provider), title: "Send Code",loader: provider.loader,),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }


  void validateFields(ResetPasswordProvider provider)async{
    if(email.text.isEmpty && number.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Enter Email or Number", Colors.redAccent);
      return;
    }
    if(email.text.isNotEmpty) {
      if (validateEmail()) {
        provider.sendOTP(onSendEmailOtpResponse,email: email.text);
      }
    }else if(number.text.isNotEmpty) {
      if (validateNumber()) {
        provider.sendOTP(onSendNumberOtpResponse,number: number.text);
      }
    }
  }


  void onSendEmailOtpResponse(ResponseMessage response){
    if(response.error!=null){
      CustomPopUp.showSnackBar(context, response.error.toString(), Colors.red);
      return;
    }
    Navigator.of(context).pushReplacementNamed(RoutesName.verifyResetPasswordOtp,arguments: {'email':email.text});
  }

  void onSendNumberOtpResponse(ResponseMessage response){
    if(response.error!=null){
      CustomPopUp.showSnackBar(context, response.error.toString(), Colors.red);
      return;
    }
    Navigator.of(context).pushReplacementNamed(RoutesName.verifyResetPasswordOtp,arguments: {'number':number.text});
  }


  bool validateEmail(){
    if(email.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Enter Email", Colors.redAccent);
      return false;
    }else if(!Constants.emailRegex.hasMatch(email.text)){
      CustomPopUp.showSnackBar(context, "Enter Valid Email", Colors.redAccent);
      return false;
    }
    return true;
  }

  bool validateNumber() {
    if (number.text.isEmpty) {
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

}
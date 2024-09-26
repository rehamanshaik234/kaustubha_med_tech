import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/authentication/login_provider.dart';
import 'package:kaustubha_medtech/controller/providers/authentication/reset_password.dart';
import 'package:kaustubha_medtech/models/login/LoginModel.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:provider/provider.dart';
import 'package:kaustubha_medtech/controller/providers/authentication/sign_up_provider.dart';
import 'package:kaustubha_medtech/views/widgets/custom_back_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/otp_text_field.dart';

import '../../../../../models/connectivity/error_model.dart';
import '../../../../../utils/routes/route_names/route_names.dart';
import '../../../../alerts/custom_alerts.dart';
class VerifyResetPasswordOtp extends StatefulWidget {
  const VerifyResetPasswordOtp({super.key});

  @override
  State<VerifyResetPasswordOtp> createState() => _VerifyResetPasswordOtpState();
}

class _VerifyResetPasswordOtpState extends State<VerifyResetPasswordOtp> {
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  FocusScopeNode focusNode=FocusScopeNode();
  String verificationId='';
  bool loader =false;
  TextEditingController otp1=TextEditingController();
  TextEditingController otp2=TextEditingController();
  TextEditingController otp3=TextEditingController();
  TextEditingController otp4=TextEditingController();
  TextEditingController otp5=TextEditingController();
  TextEditingController otp6=TextEditingController();

  String? email;
  String? number;
  bool resendOTPLoader=false;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      checkParams();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ResetPasswordProvider>(
          builder: (context,provider,child) {
            return Padding(
              padding: EdgeInsets.all(16.sp),
              child: FocusScope(
                node: focusNode,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h,),
                      CustomBackButton(onPressed: ()=>Navigator.pop(context),),
                      SizedBox(height: 30.h,),
                      Text("Please check your ${email!=null? "Email" : "SMS"}",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20.sp)),
                      Text("We’ve sent a code to ${email!=null? "$email" : "$number"}",style: GoogleFonts.inter(fontWeight: FontWeight.normal,fontSize: 14.sp)),
                      Text("Enter 6 digit code that mentioned in the sms",style: GoogleFonts.inter(fontWeight: FontWeight.normal,fontSize: 14.sp)),
                      SizedBox(height: 30.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OtpTextField(nextFocus: ()=>focusNode.nextFocus(),prevFocus: (){},textEditingController: otp1,onOtpPasted: (text){pasteOtp(text);verifyOTP(provider,pastedOtp: text);},),
                          OtpTextField(nextFocus: ()=>focusNode.nextFocus(),prevFocus: ()=>focusNode.previousFocus(),textEditingController: otp2,onOtpPasted: (text){pasteOtp(text);verifyOTP(provider,pastedOtp: text);},),
                          OtpTextField(nextFocus: ()=>focusNode.nextFocus(),prevFocus: ()=>focusNode.previousFocus(),textEditingController: otp3,onOtpPasted: (text){pasteOtp(text);verifyOTP(provider,pastedOtp: text);},),
                          OtpTextField(nextFocus: ()=>focusNode.nextFocus(),prevFocus: ()=>focusNode.previousFocus(),textEditingController: otp4,onOtpPasted: (text){pasteOtp(text);verifyOTP(provider,pastedOtp: text);},),
                          OtpTextField(nextFocus: ()=>focusNode.nextFocus(),prevFocus: ()=>focusNode.previousFocus(),textEditingController: otp5,onOtpPasted: (text){pasteOtp(text);verifyOTP(provider,pastedOtp: text);},),
                          OtpTextField(nextFocus:() {},prevFocus: ()=>focusNode.previousFocus(),textEditingController: otp6,onOtpPasted: (text){pasteOtp(text);verifyOTP(provider,pastedOtp: text);},),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomButton(onPressed: ()=> verifyOTP(provider), title: "verify",loader: provider.loader && !resendOTPLoader,),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Haven’t got the OTP yet?",style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.grey)),
                          SizedBox(width: 8.w,),
                          InkWell(
                              onTap: ()=>resendOTP(provider),
                              child: Text(provider.loader && resendOTPLoader?'Resending...':"Resend",style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 14.sp,),))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );

  }
  void pasteOtp(String otp){
    if(otp.length==6){
      otp1.text=otp[0];
      otp2.text=otp[1];
      otp3.text=otp[2];
      otp4.text=otp[3];
      otp5.text=otp[4];
      otp6.text=otp[5];
      setState(() {});
    }
  }

  void verifyLoginOtp(ResetPasswordProvider provider,String otp)async{
    provider.verifyOTP(otp, onLoginNumberResponse);
  }

  void onLoginNumberResponse(ResponseMessage message) {
    if (message.success != null && message.token!=null) {
      Navigator.pushReplacementNamed(context,RoutesName.resetPassword,arguments: {'token':message.token});
    } else {
      CustomPopUp.showSnackBar(context, "${message.error}", Colors.redAccent);
    }
  }

  void verifyOTP(ResetPasswordProvider provider,{String? pastedOtp})async {
    String otp = pastedOtp ?? (otp1.text + otp2.text + otp3.text + otp4.text + otp5.text + otp6.text);
    if(otp.length==6) {
        verifyLoginOtp(provider, otp);
    }else{
      CustomPopUp.showSnackBar(
          context, "Enter Valid OTP", Colors.redAccent);
    }
  }

  void resendOTP(ResetPasswordProvider provider)async{
    if(resendOTPLoader){
      return;
    }
    if(email!=null) {
        resendOTPLoader=true;
        setState(() {});
        provider.sendOTP(onSendEmailOtpResponse,email: email);
    }else if(number!=null) {
      resendOTPLoader=true;
      setState(() {});
      provider.sendOTP(onSendNumberOtpResponse,number: number);
    }
  }


  void onSendEmailOtpResponse(ResponseMessage response){
    if(response.error!=null){
      CustomPopUp.showSnackBar(context, response.error.toString(), Colors.red);
      return;
    }
    CustomPopUp.showSnackBar(context, "Resent OTP", Colors.green);
    resendOTPLoader=false;
    setState(() {

    });
  }

  void onSendNumberOtpResponse(ResponseMessage response){
    if(response.error!=null){
      CustomPopUp.showSnackBar(context, response.error.toString(), Colors.red);
      return;
    }
    CustomPopUp.showSnackBar(context, "Resent OTP", Colors.green);
    resendOTPLoader=false;
    setState(() {

    });
  }


  void checkParams(){
    Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
    print(data);
    if(data!=null){
      email=data['email'];
      number=data['number'];
      setState(() {});
    }
  }
}


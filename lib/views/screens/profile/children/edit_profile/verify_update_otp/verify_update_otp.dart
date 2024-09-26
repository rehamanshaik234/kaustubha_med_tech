import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/user/user_provider.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:provider/provider.dart';
import 'package:kaustubha_medtech/views/widgets/custom_back_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/otp_text_field.dart';

import '../../../../../../../models/connectivity/error_model.dart';
import '../../../../../alerts/custom_alerts.dart';
class VerifyUpdateOTP extends StatefulWidget {
  const VerifyUpdateOTP({super.key});

  @override
  State<VerifyUpdateOTP> createState() => _VerifyUpdateOTPState();
}

class _VerifyUpdateOTPState extends State<VerifyUpdateOTP> {
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  FocusScopeNode focusNode=FocusScopeNode();
  String verificationId='';
  bool loader =false;
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  TextEditingController otp6 = TextEditingController();
  String? email;
  String? number;

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
      body: Consumer<UserProvider>(
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
                        OtpTextField(nextFocus: ()=>focusNode.nextFocus(),prevFocus: (){},textEditingController: otp1,onOtpPasted:pasteOtp,),
                        OtpTextField(nextFocus: ()=>focusNode.nextFocus(),prevFocus: ()=>focusNode.previousFocus(),textEditingController: otp2,onOtpPasted:pasteOtp,),
                        OtpTextField(nextFocus: ()=>focusNode.nextFocus(),prevFocus: ()=>focusNode.previousFocus(),textEditingController: otp3,onOtpPasted:pasteOtp,),
                        OtpTextField(nextFocus: ()=>focusNode.nextFocus(),prevFocus: ()=>focusNode.previousFocus(),textEditingController: otp4,onOtpPasted:pasteOtp,),
                        OtpTextField(nextFocus: ()=>focusNode.nextFocus(),prevFocus: ()=>focusNode.previousFocus(),textEditingController: otp5,onOtpPasted:pasteOtp,),
                        OtpTextField(nextFocus: ()=>verifyOTP(provider),prevFocus: ()=>focusNode.previousFocus(),textEditingController: otp6,onOtpPasted:pasteOtp,),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomButton(onPressed: ()=> verifyOTP(provider), title: "verify",loader: provider.loader,),
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
                            child: Text(provider.otpLoader?"Resending..":"Resend",style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 14.sp,),))
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
      verifyOTP(context.read<UserProvider>());
    }

  }

  void verifyNumber(UserProvider provider,String otp)async{
    Map<String,dynamic> data={UserInfo.userPhoneKey:number};
    data['otp']=otp;
    provider.verifyNumberOTP(data, onVerifyResponse);
  }

  void verifyEmail(UserProvider provider,String otp)async{
    Map<String,dynamic> data= {'otp':otp,'email':email};
    provider.verifyEmailOTP(data, onVerifyResponse);
  }


  void onVerifyResponse(ResponseMessage message) {
    if ( message.success!=null) {
      Provider.of<UserProvider>(context,listen: false).getUserInfo((r){});
      CustomPopUp.showSnackBar(context, "${message.success}", Colors.green);
      if(mounted) {
        Navigator.pop(context);
      }
    } else {
      CustomPopUp.showSnackBar(context, "${message.error}", Colors.redAccent);
    }
  }

 void verifyOTP(UserProvider provider)async {
   String otp = otp1.text + otp2.text + otp3.text + otp4.text + otp5.text +
       otp6.text;
   if(otp.length==6) {
     if(number!=null){
       verifyNumber(provider, otp);
     }else{
       verifyEmail(provider, otp);
     }
   }else{
     CustomPopUp.showSnackBar(
         context, "Enter Valid OTP", Colors.redAccent);
   }
 }


  void checkParams(){
    Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
    if(data!=null){
      email=data['email'];
      number=data['number'];
      setState(() {});
    }
  }


  void resendOTP(UserProvider provider)async{
    if(provider.otpLoader){
      return;
    }
    if(number!=null){
      await provider.sendNumberOTP({UserInfo.userPhoneKey: number}, onSendNumberOTPResponse);
    } else {
      await provider.sendEmailOTP({UserInfo.userEmailKey: email}, onSendEmailOTPResponse);
    }
  }


  void onSendEmailOTPResponse(ResponseMessage message)async{
    if(message.success!=null){
      CustomPopUp.showSnackBar(context, 'Resent OTP', Colors.green);
    }else{
      CustomPopUp.showSnackBar(context, message.message ?? '', Colors.redAccent);
    }
  }

  void onSendNumberOTPResponse(ResponseMessage message)async{
    if(message.success!=null){
      CustomPopUp.showSnackBar(context,'Resent OTP', Colors.green);
    }else{
      CustomPopUp.showSnackBar(context, message.message ?? '', Colors.redAccent);
    }
  }
}


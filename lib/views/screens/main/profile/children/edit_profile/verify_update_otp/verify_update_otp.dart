import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/user/user_provider.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:provider/provider.dart';
import 'package:kaustubha_medtech/controller/providers/authentication/sign_up_provider.dart';
import 'package:kaustubha_medtech/views/widgets/custom_back_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/otp_text_field.dart';

import '../../../../../../../models/connectivity/error_model.dart';
import '../../../../../../../utils/routes/route_names.dart';
import '../../../../../../alerts/custom_alerts.dart';
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
  TextEditingController otp1=TextEditingController();
  TextEditingController otp2=TextEditingController();
  TextEditingController otp3=TextEditingController();
  TextEditingController otp4=TextEditingController();
  TextEditingController otp5=TextEditingController();
  TextEditingController otp6=TextEditingController();

  String? email;
  String? number;
  Map<String,dynamic> params={};


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
                        OtpTextField(nextFocus: ()=>focusNode.nextFocus(),prevFocus: (){},textEditingController: otp1,),
                        OtpTextField(nextFocus: ()=>focusNode.nextFocus(),prevFocus: ()=>focusNode.previousFocus(),textEditingController: otp2,),
                        OtpTextField(nextFocus: ()=>focusNode.nextFocus(),prevFocus: ()=>focusNode.previousFocus(),textEditingController: otp3,),
                        OtpTextField(nextFocus: ()=>focusNode.nextFocus(),prevFocus: ()=>focusNode.previousFocus(),textEditingController: otp4,),
                        OtpTextField(nextFocus: ()=>focusNode.nextFocus(),prevFocus: ()=>focusNode.previousFocus(),textEditingController: otp5,),
                        OtpTextField(nextFocus:()=> verifyOTP(provider),prevFocus: ()=>focusNode.previousFocus(),textEditingController: otp6,),
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
                        Text("Haven’t got the link yet?",style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.grey)),
                        SizedBox(width: 8.w,),
                        Text("Resend",style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 14.sp,),)
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

  void verifyNumber(UserProvider provider,String otp)async{
    Map<String,dynamic> data={UserInfo.userPhoneKey:number?.replaceAll('+91', '')};
    data['otp']=otp;
    provider.verifyNumberOTP(data, onVerifyResponse);
  }

  void verifyEmail(UserProvider provider,String otp)async{
    Map<String,dynamic> data= {'otp':otp,'email':email};
    provider.verifyEmailOTP(data, onVerifyResponse);
  }

  void editProfile(UserProvider provider){
    provider.updateProfile(params, onUpdateProfileResponse);
  }

  void onUpdateProfileResponse(ResponseMessage message)async{
    if(message.user!=null){
      Navigator.pop(context);
      CustomPopUp.showSnackBar(context, message.success ?? 'Updated Successfully', Colors.greenAccent);
    }else{
      CustomPopUp.showSnackBar(context, message.message ?? 'Something Went Wrong', Colors.redAccent);
    }
  }

  void onVerifyResponse(ResponseMessage message) {
    if ( message.message!.contains('Verified')) {
      editProfile(Provider.of<UserProvider>(context,listen: false));
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
      params=data['data'] as Map<String,dynamic>;
      setState(() {});
    }
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:kaustubha_medtech/controller/firebase/firebase_auth.dart';
import 'package:kaustubha_medtech/controller/providers/authentication/sign_up_provider.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_back_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/otp_text_field.dart';
class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
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

  String? nextRoute;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      sendOtp();
      checkParams();
    });    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SignUpProvider>(
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
                      Text("Please Check Your Email",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 30.sp)),
                      Text("We’ve sent a code to srehaman234@gmail.com",style: GoogleFonts.inter(fontWeight: FontWeight.normal,fontSize: 16.sp)),
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
                      CustomButton(onPressed: ()=> verifyOTP(provider), title: "verify",loader: loader,),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Send Code Again",style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.grey)),
                          SizedBox(width: 8.w,),
                          Text("00:20",style: GoogleFonts.inter(fontWeight: FontWeight.normal,fontSize: 14.sp),)
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

  void sendOtp()async{
    // final result =await  firebaseAuthentication.signInWithOtp("7780519178",(verificationId,token){
    //   this.verificationId=verificationId;
    //   if(context.mounted) {
    //     setState(() {
    //
    //     });
    //   }
    // });
  }

  void verifyOTP(SignUpProvider provider)async {
    String otp = otp1.text + otp2.text + otp3.text + otp4.text + otp5.text +
        otp6.text;
    if (otp1.text.isNotEmpty && otp2.text.isNotEmpty && otp3.text.isNotEmpty &&
        otp4.text.isNotEmpty && otp5.text.isNotEmpty && otp6.text.isNotEmpty && otp=='122345') {
      CustomPopUp.showSnackBar(
          context, "Successfully Verified", Colors.green);
      if(nextRoute!=null){
        Navigator.pushReplacementNamed(context, nextRoute ?? '',arguments: {'email':"srehaman234@gmail.com"});
      }else{
        Navigator.pop(context);
      }
    }else{
      CustomPopUp.showSnackBar(
          context, "Enter Valid OTP", Colors.redAccent);
    }
  }

  void checkParams(){
    Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
    if(data!=null){
      nextRoute=data['next_route'];
      setState(() {});
    }
  }
}
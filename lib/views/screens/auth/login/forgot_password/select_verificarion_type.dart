import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
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
  bool loader=false;
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
      body: Consumer<SignUpProvider>(
          builder: (context,caProvider,child) {
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
                    Text("Please enter your email to reset the password",style: GoogleFonts.inter(fontWeight: FontWeight.normal,fontSize: 14.sp)),
                    SizedBox(height: 30.h,),
                    Text('Your Number',style: GoogleFonts.inter(fontWeight: FontWeight.normal,fontSize: 16.sp),),
                    SizedBox(height: 10.h,),
                    CustomTextField(hintText: "Enter Number",inputType: TextInputType.number,textEditingController: number,focusNode: numberFocus,outlinedBorder: true,),
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
                    CustomButton(onPressed: validateFields, title: "Send Code",loader: loader,),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }


  void validateFields()async{
    if(email.text.isNotEmpty){
      if(await validateEmail()){
        Navigator.pushNamed(context, RoutesName.verifyEmail,arguments: {"next_route":RoutesName.resetPassword});

        // verifyEmail();
      }
    }else if(number.text.isNotEmpty){
      if(await validateNumber()){
        Navigator.pushNamed(context, RoutesName.verifySignUpOTP,arguments: {"next_route":RoutesName.resetPassword});
        // verifyNumber();
      }
    } else{
      CustomPopUp.showSnackBar(context, "Enter Email or Number", Colors.redAccent);
    }
  }




  Future<bool> validateEmail()async{
    if(email.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Enter Email", Colors.redAccent);
      return false;
    }else if(!Constants.emailRegex.hasMatch(email.text)){
      CustomPopUp.showSnackBar(context, "Enter Valid Email", Colors.redAccent);
      return false;
    }
    return true;
  }

  Future<bool> validateNumber()async{
    if(number.text.isEmpty || number.text.replaceAll(" ", '').length!=10){
      CustomPopUp.showSnackBar(context, "Enter Valid Number", Colors.redAccent);
      return false;
    } else{
      return true;
    }
  }

}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/authentication/reset_password.dart';
import 'package:provider/provider.dart';
import 'package:kaustubha_medtech/controller/providers/authentication/sign_up_provider.dart';
import 'package:kaustubha_medtech/utils/routes/route_names/route_names.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_back_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController email=TextEditingController();
  TextEditingController confirmPassword=TextEditingController();
  TextEditingController password=TextEditingController();
  bool loader=false;
  String? verifiedNumber;
  String? verifiedEmail;
  String? token;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getNumberOrEmail();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomBackButton(onPressed: ()=>Navigator.pop(context),),
                        const Image(image: AssetImage('assets/create_account/star.png'))
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Text("Set a New Password",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20.sp)),
                    Text("Create a new password. Ensure it differs from previous ones for security",style: GoogleFonts.inter(fontWeight: FontWeight.normal,fontSize: 14.sp)),
                    SizedBox(height: 30.h,),
                    Text('New Password',style: GoogleFonts.inter(fontWeight: FontWeight.normal,fontSize: 16.sp),),
                    SizedBox(height: 10.h,),
                    CustomTextField(hintText: "Enter Password",textEditingController: password,isPassword: true,outlinedBorder: true,),
                    SizedBox(height: 20.h,),
                    Text('Confirm Password',style: GoogleFonts.inter(fontWeight: FontWeight.normal,fontSize: 16.sp),),
                    SizedBox(height: 10.h,),
                    CustomTextField(hintText: "Enter Confirm Password", textEditingController: confirmPassword,isPassword: true,outlinedBorder: true,),
                    SizedBox(height: 30.h,),
                    CustomButton(onPressed: ()=>validateFields(provider), title: "Update",loader: provider.loader,),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }


  void validateFields(ResetPasswordProvider provider)async{
    if(validatePasswords()){
      updatePassword(provider);
    }
  }


  bool validatePasswords(){
    if(password.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Enter Password", Colors.redAccent);
      return false;
    }else if(confirmPassword.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Enter Confirm Password", Colors.redAccent);
      return false;
    }else if(confirmPassword.text!=password.text){
      CustomPopUp.showSnackBar(context, "Password Dosen\'t Match", Colors.redAccent);
      return false;
    }else if(confirmPassword.text.length<6){
      CustomPopUp.showSnackBar(context, "Password should be at least 6 characters", Colors.redAccent);
      return false;
    } else{
      return true;
    }
  }


  void gotoNext(SignUpProvider caProvider){
    if(caProvider.isNumberVerified) {
      Navigator.pushNamed(context, RoutesName.login);
    }
  }

  void getNumberOrEmail(){
    Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
    if(data!=null){
      token=data['token'];
      setState(() {});
    }
  }

  void updatePassword(ResetPasswordProvider provider)async{
    provider.resetPassword(password.text, token.toString(), (r){
      if(r.error!=null){
        CustomPopUp.showSnackBar(context, r.error.toString(), Colors.red);
        return;
      }
      if(r.success!=null && r.error==null){
        CustomPopUp.showSnackBar(context, "Updated Password", Colors.green);
        Navigator.of(context).pop();
      }
    });
  }

  void resetFields() {
    // Provider.of<CreateAccountProvider>(context,listen: false).setVerifiedNumber(false);
    // Provider.of<CreateAccountProvider>(context,listen: false).setNumber("");
    // Provider.of<CreateAccountProvider>(context,listen: false).setVerifiedEmail(false);
    // Provider.of<CreateAccountProvider>(context,listen: false).setEmail("");
  }
}
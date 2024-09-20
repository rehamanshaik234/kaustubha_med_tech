import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/user/user_provider.dart';
import 'package:kaustubha_medtech/models/connectivity/error_model.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
import 'package:kaustubha_medtech/views/widgets/profile/profile_option.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/app_colors/app_colors.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;

  @override
  void initState() {
    UserProvider provider= Provider.of<UserProvider>(context,listen: false);
    name=TextEditingController(text: provider.user.name);
    email=TextEditingController(text: provider.user.email);
    phone=TextEditingController(text: provider.user.phone);
    password=TextEditingController(text: provider.user.password);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context,provider,child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBgColor,
            elevation: 0,
            leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back_rounded,
              color: Colors.black,size: 20.sp,)),
            title: Text('Edit Profile',style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),),
          ),
          body: SizedBox(
            width: 1.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    SizedBox(
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(75.sp),
                              child: Image(image: AssetImage(AssetUrls.profile),fit: BoxFit.cover,height: 150.h,width: 150.w,)),
                          Positioned(
                              bottom: 12.h,
                              right: 12.w,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.sp),
                                  color: AppColors.primaryColor,
                                ),
                                padding: EdgeInsets.all(4.sp),
                                child: Icon(Icons.upload,color: Colors.white,
                                      size: 16.sp,)),
                              )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(provider.user.name ?? '',style: GoogleFonts.dmSans(fontSize: 16.sp,fontWeight: FontWeight.w700),),
                    Text(provider.user.phone ?? '',style: GoogleFonts.dmSans(fontSize: 14.sp,fontWeight: FontWeight.w400),),
                    SizedBox(height: 24.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Name',style: GoogleFonts.dmSans(fontSize: 16.sp,fontWeight: FontWeight.w500),),
                      ],
                    ),
                    SizedBox(height: 8.h,),
                    CustomTextField(hintText: "Enter Name", textEditingController:name,
                      includeSpacing: true,
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                      borderSide: BorderSide(color: Colors.black54),
                    ),outlinedBorder: true,),
                    SizedBox(height: 16.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Email Id',style: GoogleFonts.dmSans(fontSize: 16.sp,fontWeight: FontWeight.w500),),
                      ],
                    ),
                    SizedBox(height: 8.h,),
                    CustomTextField(hintText: "Enter Email", textEditingController: email,
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                      borderSide: BorderSide(color: Colors.black54),
                    ),outlinedBorder: true,),
                    SizedBox(height: 16.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Phone Number',style: GoogleFonts.dmSans(fontSize: 16.sp,fontWeight: FontWeight.w500),),
                      ],
                    ),
                    SizedBox(height: 8.h,),
                    CustomTextField(hintText: "Enter Number", textEditingController: phone,
                      inputType: TextInputType.number,
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                      borderSide: BorderSide(color: Colors.black54),
                    ),outlinedBorder: true,),
                    SizedBox(height: 16.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Password',style: GoogleFonts.dmSans(fontSize: 16.sp,fontWeight: FontWeight.w500),),
                      ],
                    ),
                    SizedBox(height: 8.h,),
                    CustomTextField(hintText: "Enter Password", textEditingController: password,
                      isPassword: true,
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                      borderSide: BorderSide(color: Colors.black54),
                    ),outlinedBorder: true,),
                    SizedBox(height: 24.h,),
                    CustomButton(onPressed: ()=>editProfile(provider), title: "Update",loader: provider.loader,),
                    SizedBox(height: 32.h,),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  void editProfile(UserProvider provider){
    Map<String,dynamic> params = { 'userId':provider.user.id,
                                    UserInfo.userNameKey:name.text,
                                    UserInfo.userEmailKey:email.text,
                                    UserInfo.userPhoneKey:phone.text,
                                };
    provider.updateProfile(params, onUpdateResponse);
  }

  void onUpdateResponse(ResponseMessage message)async{
    if(message.success!=null){
      CustomPopUp.showSnackBar(context, "Updated Successfully", Colors.green);
    }else{
      CustomPopUp.showSnackBar(context, message.error ?? '', Colors.redAccent);
    }
  }

}

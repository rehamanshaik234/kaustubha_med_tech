import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaustubha_medtech/controller/providers/user/user_provider.dart';
import 'package:kaustubha_medtech/models/connectivity/error_model.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
import 'package:kaustubha_medtech/views/widgets/profile/profile_option.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/constants/constants.dart';


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
  File? profile;

  @override
  void initState() {
    UserProvider provider= Provider.of<UserProvider>(context,listen: false);
    name=TextEditingController(text: provider.user.name);
    email=TextEditingController(text: provider.user.email);
    phone=TextEditingController(text: provider.user.phone);
    password=TextEditingController(text: '');
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
                              child: Image(image: profile!=null? FileImage(profile?? File('')):provider.user.image!=null?NetworkImage(provider.user.image):AssetImage(AssetUrls.profile),fit: BoxFit.cover,height: 150.h,width: 150.w,)),
                          Positioned(
                              bottom: 12.h,
                              right: 12.w,
                              child: InkWell(
                                onTap: uploadImage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.sp),
                                    color: AppColors.primaryColor,
                                  ),
                                  padding: EdgeInsets.all(4.sp),
                                  child: Icon(Icons.upload,color: Colors.white,
                                        size: 16.sp,)),
                              ),
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
                        Text('Phone Number',style: GoogleFonts.dmSans(fontSize: 16.sp,fontWeight: FontWeight.w500),),
                      ],
                    ),
                    SizedBox(height: 8.h,),
                    CustomTextField(hintText: "Enter Number", textEditingController: phone,
                      onChange: (text){
                        String currentText = phone.text;
                        if(currentText=="+9"){
                          phone.text = '+91';
                          phone.selection = TextSelection.fromPosition(
                            TextPosition(offset: phone.text.length),
                          );
                        }else if (currentText.isNotEmpty && !currentText.startsWith('+91')) {
                          phone.text = '+91$currentText';
                          phone.selection = TextSelection.fromPosition(
                            TextPosition(offset: phone.text.length),
                          );
                        }
                        setState(() {});
                      },
                      inputType: TextInputType.number,
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
                    ),outlinedBorder: true,onChange: (t)=>setState(() {}),),
                    Visibility(
                      visible: provider.user.email==null && provider.user.password==null,
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
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
    if(validateFields()) {
      Map<String, dynamic> params = {
        'userId': provider.user.id,
        UserInfo.userNameKey: name.text,
      };
      if(password.text.isNotEmpty){
        params[UserInfo.userPasswordKey]=password.text;
      }
      if(provider.user.phone!=phone.text){
        params[UserInfo.userPhoneKey]=phone.text;
      }
      if(provider.user.email!=email.text){
        params[UserInfo.userEmailKey]=email.text;
      }
      if(profile!=null){
        provider.updateUserProfilePic(profile, (r){
          if(r.message!=null&&r.message.toString().toLowerCase().contains('success')) {
            provider.updateProfile(params, onUpdateProfileResponse);
          }else{
            CustomPopUp.showSnackBar(context, "Unable to Upload Pic", Colors.redAccent);
          }
        });
      }else{
        provider.updateProfile(params, onUpdateProfileResponse);
      }
    }
  }

  void onUpdateProfileResponse(ResponseMessage message)async{
    if(message.success!=null){
       checkVerification();
    }else{
      CustomPopUp.showSnackBar(context, message.success ?? 'Updated Successfully', Colors.redAccent);
    }
  }

  void checkVerification()async{
    UserProvider provider=Provider.of<UserProvider>(context,listen: false);
      if(provider.user.numberVerified==false){
          email.text=provider.user.email??'';
          setState(() {

          });
        await provider.sendNumberOTP({UserInfo.userPhoneKey: phone.text}, onSendNumberOTPResponse);
      } else if (provider.user.email!=null && provider.user.email!.isNotEmpty && provider.user.emailVerified==null) {
        await provider.sendEmailOTP({UserInfo.userEmailKey: email.text}, onSendEmailOTPResponse);
      }else{
        await provider.getUserInfo((r){});
        CustomPopUp.showSnackBar(context, "Updated SuccessFully", Colors.green);
      }
  }


  void onSendEmailOTPResponse(ResponseMessage message)async{
    if(message.success!=null){
      Navigator.pushNamed(context, RoutesName.verifyUpdateOTP,arguments: {'email':email.text});
    }else{
      CustomPopUp.showSnackBar(context, message.message ?? '', Colors.redAccent);
    }
  }

  void onSendNumberOTPResponse(ResponseMessage message)async{
    if(message.success!=null){
      Navigator.pushNamed(context, RoutesName.verifyUpdateOTP,arguments: {'number':phone.text});
    }else{
      CustomPopUp.showSnackBar(context, message.message ?? '', Colors.redAccent);
    }
  }


  bool validateFields(){
    UserProvider provider= Provider.of<UserProvider>(context,listen: false);
    if(provider.user.email!=null && provider.user.email!.isNotEmpty || email.text.isNotEmpty){
      return validateName()  && validateNumber() && validateEmail() && email.text!=provider.user.email? validatePasswords():true;
    }
    return validateName() && validateNumber();
  }

  bool validatePasswords() {
    if (password.text.isEmpty) {
      CustomPopUp.showSnackBar(context, "Enter Password", Colors.redAccent);
      return false;
    } else if (password.text.length < 6) {
      CustomPopUp.showSnackBar(
          context, "Password Must Contains 6 Characters", Colors.redAccent);
      return false;
    } else {
      return true;
    }
  }


  bool validateEmail() {
    if (email.text.isNotEmpty) {
      if (email.text.isEmpty) {
        CustomPopUp.showSnackBar(context, "Enter Email", Colors.redAccent);
        return false;
      } else if (!Constants.emailRegex.hasMatch(email.text)) {
        CustomPopUp.showSnackBar(
            context, "Enter Valid Email", Colors.redAccent);
        return false;
      }
    }
    return true;
  }

  bool validateNumber() {
    if (phone.text
        .replaceAll(" ", '')
        .replaceAll('+91', '')
        .length != 10) {
      CustomPopUp.showSnackBar(context, "Enter Valid Number", Colors.redAccent);
      return false;
    } else {
      return true;
    }
  }

  bool validateName() {
    if (name.text.isEmpty) {
      CustomPopUp.showSnackBar(context, "Enter Name", Colors.redAccent);
      return false;
    } else {
      return true;
    }
  }

  uploadImage()async{
    PermissionStatus permission = await Permission.photos.request();
    if (permission.isDenied) {
      CustomPopUp.showSnackBar(context, 'Access Denied', Colors.red);
      return;
    }
    final image = await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);
      File? compressedImage= await Constants.compressFile(file);
      if(compressedImage!=null){
        profile=compressedImage;
        setState(() {});
      }else{
        CustomPopUp.showSnackBar(context, 'Unable to Compress Image', Colors.redAccent);
      }
    }
  }

}

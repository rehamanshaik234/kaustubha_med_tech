import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_outline_button.dart';
class LogoutPopup{


  static void showLogout(BuildContext context,VoidCallback onDone){
    showDialog(context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Logout',style: GoogleFonts.inter(color: AppColors.primaryColor,fontSize: 20.sp,fontWeight: FontWeight.w600),),
              ],
            ),
            content: Text('Are you sure you want to Logout?',
              style: GoogleFonts.inter(color: Colors.black54,fontSize: 14.sp,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(onPressed: ()=>Navigator.pop(context), title: "Cancel",borderRadius: BorderRadius.circular(20.sp),height: 30.h,padding: 0,width: 110.w,bgColor: AppColors.buttonSecondaryBgColor,textColor: AppColors.primaryColor,textSize: 14.sp,),
                  CustomButton(onPressed:(){
                         onDone();
                         Navigator.pop(context);
                    } , title: "Yes, Logout",borderRadius: BorderRadius.circular(20.sp),height: 30.h,padding: 0,width: 110.w,textSize: 14.sp,),
                ],
              )
            ],
          );

        });
  }
}
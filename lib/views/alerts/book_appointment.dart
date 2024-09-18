import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_outline_button.dart';
class AppointmentAlert{

  static void showBookedAppointment(BuildContext context){
    showDialog(context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Column(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFA4CFC3),
                  radius: 40.sp,
                  child: Icon(Icons.check_circle,color: Colors.white,size: 35.sp,),
                ),
                SizedBox(height: 8.h,),
                Text('Congratulations!',style: GoogleFonts.inter(color: AppColors.primaryColor,fontSize: 20.sp,fontWeight: FontWeight.w600),),
              ],
            ),
           content: Text('Your appointment with Dr. David Patel is confirmed for June 30, 2023, at 10:00 AM.',
                           style: GoogleFonts.inter(color: Colors.black54,fontSize: 14.sp,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),

            actions: [
              CustomButton(onPressed: ()=>Navigator.pop(context), title: "Done",borderRadius: BorderRadius.circular(25.sp),)
            ],
          );

        });
  }

  static void showCancelAppointment(BuildContext context){
    showDialog(context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Cancel',style: GoogleFonts.inter(color: AppColors.primaryColor,fontSize: 20.sp,fontWeight: FontWeight.w600),),
              ],
            ),
            content: Text('Are you sure you want to Cancel?',
              style: GoogleFonts.inter(color: Colors.black54,fontSize: 14.sp,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(onPressed: ()=>Navigator.pop(context), title: "No",borderRadius: BorderRadius.circular(20.sp),height: 30.h,padding: 0,width: 110.w,bgColor: AppColors.buttonSecondaryBgColor,textColor: AppColors.primaryColor,textSize: 14.sp,),
                  CustomButton(onPressed: ()=>Navigator.pop(context), title: "Yes, Cancel",borderRadius: BorderRadius.circular(20.sp),height: 30.h,padding: 0,width: 110.w,textSize: 14.sp,),
                ],
              )
            ],
          );

        });
  }
}
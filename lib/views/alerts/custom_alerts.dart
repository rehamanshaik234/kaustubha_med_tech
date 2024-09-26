  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPopUp{

  static FToast fToast=FToast();

  static void showSnackBar(BuildContext context,String title,Color bgColor,{Widget? child}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
         backgroundColor: bgColor,
          behavior: SnackBarBehavior.floating,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: GoogleFonts.poppins(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w500),),
              child ?? Container()
            ],
          ))
    );
  }

  static void showFToast(BuildContext context,String title){
    fToast.init(context);
    fToast.showToast(child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          color: Colors.green
      ),
      padding: EdgeInsets.all(8.sp),
      margin: EdgeInsets.only(bottom: 40.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle,color: Colors.white,size: 20.sp,),
          SizedBox(width: 4.w,),
          Text(title,style: GoogleFonts.dmSans(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16.sp),),
        ],
      ),
    ));
  }
}
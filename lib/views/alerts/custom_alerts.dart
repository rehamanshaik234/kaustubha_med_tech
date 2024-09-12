import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPopUp{
  static void showSnackBar(BuildContext context,String title,Color bgColor){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
         backgroundColor: bgColor,
          content: Text(title,style: GoogleFonts.poppins(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w500),))
    );
  }
}
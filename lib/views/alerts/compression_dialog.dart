import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_outline_button.dart';
class CompressionDialog{


  static void show(BuildContext context,Function(BuildContext context) onDone){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context){
         onDone(context);
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Compressing...',style: GoogleFonts.inter(color: AppColors.primaryColor,fontSize: 20.sp,fontWeight: FontWeight.w600),),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40.sp,
                  width: 40.sp,
                  child: CircularProgressIndicator.adaptive(backgroundColor: AppColors.primaryColor,strokeWidth: 2.w,),
                ),
                SizedBox(height: 8.h,),
                Text('Please wait...',
                  style: GoogleFonts.inter(color: Colors.black54,fontSize: 14.sp,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              ],
            ),
          );

        });
  }
}
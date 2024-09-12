import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
class CustomButton extends StatelessWidget {
  CustomButton({super.key,required this.onPressed,required this.title,this.loader=false,this.borderRadius,this.padding});
  VoidCallback onPressed;
  String title;
  bool loader;
  double? padding;
  BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 1.sw,
        child: ElevatedButton(
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(AppColors.primaryColor),
                    padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.all(padding ?? 12.sp)),
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(8.sp)))  ),
            onPressed: onPressed, child:loader?Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.h,
              width: 25.w,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1.sp,
              ),
            )
          ],
        ):
        Text(title,style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize:16.sp,color: Colors.white ),)));
  }
}

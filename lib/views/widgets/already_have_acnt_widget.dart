import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
class AlreadyHaveAccountWidget extends StatelessWidget {
  const AlreadyHaveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text( "Already have an account?",style: GoogleFonts.inter(color: Colors.grey)),
          SizedBox(width: 4.w,),
          Text("Login",style: GoogleFonts.inter(fontWeight: FontWeight.bold,decoration: TextDecoration.underline,color: AppColors.primaryColor),),
        ]
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class DontHaveAccountWidget extends StatelessWidget {
  const DontHaveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text( "Don't have an account?",style: GoogleFonts.inter(color: Colors.grey)),
          SizedBox(width: 4.w,),
          Text("Sign up",style: GoogleFonts.inter(fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),
        ]
    );
  }
}

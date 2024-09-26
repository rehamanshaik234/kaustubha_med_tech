import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_textfield.dart';
class EnrollFormField extends StatelessWidget {
  EnrollFormField({super.key,required this.controller,required this.title,required this.hint});
  late TextEditingController controller;
  late String title;
  late String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title,style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp),),
            ],
          ),
          SizedBox(height: 8.h,),
          CustomTextField(hintText: hint, textEditingController: controller,outlinedBorder: true,border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
            borderRadius: BorderRadius.circular(8.sp)
          ),)
        ],
      ),
    );
  }
}

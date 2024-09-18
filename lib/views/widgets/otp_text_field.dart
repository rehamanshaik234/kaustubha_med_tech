import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpTextField extends StatelessWidget {
  OtpTextField({super.key,required this.nextFocus,required this.prevFocus,required this.textEditingController});
  VoidCallback nextFocus;
  VoidCallback prevFocus;
  TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12.sp)
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: TextFormField(
        controller: textEditingController,
        onChanged: (text){
          nextFocus();
          if(text.isNotEmpty){
            textEditingController.text=text[text.length-1];
          }else{
            prevFocus();
          }
        },
        keyboardType: TextInputType.number,
        style: GoogleFonts.inter(fontWeight: FontWeight.w500,fontSize: 32.sp),
        decoration: InputDecoration(
          hintText: '0',
          border: InputBorder.none,
          hintStyle: GoogleFonts.inter(color: Colors.grey,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}



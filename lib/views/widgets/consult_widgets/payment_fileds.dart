import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_textfield.dart';

class PaymentFields extends StatelessWidget {
  PaymentFields({super.key,required this.title,required this.hint,this.width,required this.textEditingController});
  String title;
  String hint;
  double? width;
  TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title,style:  GoogleFonts.dmSans(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16.sp),),
          ],
        ),
        SizedBox(height: 8.h,),
        SizedBox(
          width: width,
          child: CustomTextField(hintText: hint, textEditingController: TextEditingController(),outlinedBorder: true,border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.sp)
          ),fillColor: Colors.red,),
        ),
      ],
    );
  }
}

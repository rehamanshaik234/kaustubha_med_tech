import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomOutlineButton extends StatelessWidget {
  CustomOutlineButton({super.key,required this.onPressed,required this.title});
  VoidCallback onPressed;
  String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 1.sw,
        child: OutlinedButton(
            style: ButtonStyle(backgroundColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
                side: WidgetStatePropertyAll<BorderSide>(BorderSide(color: Colors.black)),
                padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.all(12.sp)),
                shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp)))  ),
            onPressed: onPressed, child: Text(title,style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize:16.sp,color: Colors.black ),)));
  }
}

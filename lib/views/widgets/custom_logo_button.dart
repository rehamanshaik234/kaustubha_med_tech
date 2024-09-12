import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLogoButton extends StatelessWidget {
  CustomLogoButton({super.key,required this.onPressed,required this.title,required this.logoUrl,this.loading=false,this.child});
  VoidCallback onPressed;
  String title;
  String logoUrl;
  bool loading;
  Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 1.sw,
        child: OutlinedButton(
            style: ButtonStyle(backgroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
                side: WidgetStatePropertyAll<BorderSide>(BorderSide(color: Colors.grey)),
                padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.all(12.sp)),
                shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)))  ),
            onPressed: onPressed, child:!loading? Row(
             mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                child==null?Image(image: AssetImage(logoUrl),fit: BoxFit.contain,): child ?? const Center(),
                SizedBox(width: 16.w,),
                Text(title,style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize:16.sp,color: Colors.black ),),
              ],
              ):Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25.h,
                      width: 25.w,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 1.sp,
                      ),
                    )
                  ],
                )));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButton extends StatelessWidget {
  CustomBackButton({super.key,this.onPressed});
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12.sp)
      ),
      child: InkWell(onTap: onPressed, child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Icon(CupertinoIcons.back,color: Colors.black,size: 20.sp,),
      ),),
    );
  }
}
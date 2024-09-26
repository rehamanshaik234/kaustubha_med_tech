import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
class EnrollStepper extends StatelessWidget {
   EnrollStepper({super.key, required this.currentIndex,required this.onTap,this.ignore=true});
  late int currentIndex;
  late Function(int index) onTap;
  late bool ignore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp,vertical: 8.h),
      child: Row(
        children: [
          IgnorePointer(
            ignoring: ignore,
            child: InkWell(
              onTap: (){
                onTap(0);
              },
              child: CircleAvatar(
                radius: 15.sp,
                  backgroundColor:AppColors.primaryColor,
                  child: Icon(Icons.person,color:Colors.white,size: 20.sp,)),
            ),
          ),
          Expanded(child: Container(height: 5.h,color:currentIndex>0? AppColors.primaryColor:Colors.grey,)),
          IgnorePointer(
            ignoring: ignore,
            child: InkWell(
              onTap: (){
                onTap(1);
              },
              child: CircleAvatar(
                  radius: 15.sp,
                  backgroundColor:currentIndex>=1? AppColors.primaryColor:Colors.grey,
                  child: Icon(Icons.calendar_month,color:Colors.white,size: 20.sp,)),
            ),
          ),
          Expanded(child: Container(height: 5.h,color:currentIndex>1? AppColors.primaryColor:Colors.grey,)),
          IgnorePointer(
            ignoring: ignore,
            child: InkWell(
              onTap: (){
                onTap(2);
              },
              child: CircleAvatar(
                  radius: 15.sp,
                  backgroundColor:currentIndex>=2? AppColors.primaryColor:Colors.grey,
                  child: Icon(Icons.medical_services,color:Colors.white,size: 20.sp,)),
            ),
          ),
        ],
      ),
    );
  }
}

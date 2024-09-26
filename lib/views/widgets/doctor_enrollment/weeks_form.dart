import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
class WeeksForm extends StatelessWidget {
   WeeksForm({super.key,required this.onSelect,required this.selectedWeeks});
  late Function(String val) onSelect;
  List<String> selectedWeeks;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Choose any day of the week to repeat this availability.*',style: GoogleFonts.dmSans(
            fontSize: 16.sp,fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 8.h,),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              for(int i=0;i<Constants.weeks.length;i++)
              InkWell(
                onTap: (){
                 onSelect(Constants.weeks[i]);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 8.sp,bottom: 8.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color:selectedWeeks.contains(Constants.weeks[i])?AppColors.primaryColor: Colors.grey.shade300
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                  child: Text(Constants.weeks[i],style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp,
                      color:selectedWeeks.contains(Constants.weeks[i])?Colors.white:Colors.black),),
              ),
              )
            ],
          ),
          SizedBox(height: 16.h,),
        ],
      ),
    );
  }
}

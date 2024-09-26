import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
class WeeksForm extends StatelessWidget {
   WeeksForm({super.key,required this.onSelect,required this.value});
  late Function(String val) onSelect;
  late String value;

  List<String> weeks=['M','Tu',"W","Th","F","Sa","Su"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Choose any day of the week to repeat this availability.*',style: GoogleFonts.dmSans(
          fontSize: 16.sp,fontWeight: FontWeight.w500
        ),),
        SizedBox(height: 8.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for(int i=0;i<weeks.length;i++)
            InkWell(
              onTap: (){
               onSelect(weeks[i]);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color:value==weeks[i]?AppColors.primaryColor: Colors.grey.shade300
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                child: Text(weeks[i],style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp,
                    color:value==weeks[i]?Colors.white:Colors.black),),
            ),
            )
          ],
        ),
        SizedBox(height: 16.h,),
      ],
    );
  }
}

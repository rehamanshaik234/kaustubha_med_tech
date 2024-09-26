import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
class LanguagesForm extends StatelessWidget {
   LanguagesForm({super.key,required this.onSelect,required this.selectedLanguages});
  late Function(String val) onSelect;
  List<String> selectedLanguages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Languages',style: GoogleFonts.dmSans(
            fontSize: 16.sp,fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 8.h,),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              for(int i=0;i<Constants.languages.length;i++)
              GestureDetector(
                onTap: (){
                 onSelect(Constants.languages[i]);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 8.sp,bottom: 8.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color:selectedLanguages.contains(Constants.languages[i])?AppColors.primaryColor: Colors.grey.shade300
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                  child: Text(Constants.languages[i],style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp,
                      color:selectedLanguages.contains(Constants.languages[i])?Colors.white:Colors.black),),
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

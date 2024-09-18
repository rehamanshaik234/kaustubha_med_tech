import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors/app_colors.dart';
class DoctorFilterOptions extends StatefulWidget {
  const DoctorFilterOptions({super.key});

  @override
  State<DoctorFilterOptions> createState() => _DoctorFilterOptionsState();
}

class _DoctorFilterOptionsState extends State<DoctorFilterOptions> {
  List<String> specialistTypes=["   All   ",'General','Cardiologist','Dentist','Physiologist'];
  String selectedOption="   All   ";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(left: 8.0.w,top: 0.w,bottom: 8.h),
        child: Row(
          children: [
            optionContainer(specialistTypes[0], 0),
            optionContainer(specialistTypes[1], 1),
            optionContainer(specialistTypes[2], 2),
            optionContainer(specialistTypes[3], 3),
            optionContainer(specialistTypes[4], 4),
          ],
        ),
      ),
    );
  }

  Widget optionContainer(String title,int index){
    return GestureDetector(
      onTap: (){
        selectedOption=title;
        setState(() {

        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
            color: selectedOption==title? AppColors.primaryColor:Colors.white,
            borderRadius: BorderRadius.circular(20.sp),
            border: Border.all(color: AppColors.primaryColor)
        ),
        child: Text(title,style: GoogleFonts.dmSans(fontWeight: FontWeight.w600,color:selectedOption==title?Colors.white:AppColors.primaryColor,fontSize: 14.sp),),
      ),
    );
  }
}

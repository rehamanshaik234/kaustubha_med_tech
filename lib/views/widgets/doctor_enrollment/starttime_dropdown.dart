import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';

class StartTimeDropDown extends StatefulWidget {
  Function(int) onChange;
  int? selectedTab;

  StartTimeDropDown({super.key, required this.onChange, required this.selectedTab});

  @override
  State<StartTimeDropDown> createState() => _StartTimeDropDownState();
}

class _StartTimeDropDownState extends State<StartTimeDropDown> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Start Time",style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp),),
        SizedBox(height: 8.h,),
        Container(
          width: 1.sw,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.sp),
              color: Colors.transparent,
              border: Border.all(color: Colors.black54)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:  12.w,vertical: 4.w),
            child: SizedBox(
              height: 40.h,
              child: DropdownButton<int>(
                value: widget.selectedTab,
                hint: SizedBox(
                  width: 0.78.sw,
                    child: Text('Select Time',style:GoogleFonts.inter(color: Colors.black54),)),
                borderRadius: BorderRadius.circular(20.sp),
                items: List.generate(
                  Constants.timings.length,
                      (index) => DropdownMenuItem(
                    value: index,
                    child: Text(
                      Constants.timings[index],
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value != null) {
                    widget.onChange(value);
                  }
                },
                dropdownColor: Colors.white,
                underline: Container(),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h,)
      ],
    );
  }
}

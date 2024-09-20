import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';

class TrackerDropDown extends StatefulWidget {
  Function(int index) onChange;
  int selectedTab;

  TrackerDropDown({super.key, required this.onChange, required this.selectedTab});

  @override
  State<TrackerDropDown> createState() => _TrackerDropDownState();
}

class _TrackerDropDownState extends State<TrackerDropDown> {
  final List<String> options = ["Daily", "Weekly", "Monthly"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            color: Colors.white,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:  12.w,vertical: 8.w),
              child: Row(
                children: [
                  Icon(CupertinoIcons.share,color: AppColors.primaryColor,size: 14.sp,),
                  SizedBox(width: 8.w,),
                  Text('Export',style: GoogleFonts.dmSans(fontSize: 16.sp,),),
                ],
              ),
            ),
          ),
            Card(
              color: Colors.white,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.sp),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:  12.w,vertical: 4.w),
                child: SizedBox(
                  height: 30.h,
                  child: DropdownButton<int>(
                    value: widget.selectedTab,
                    borderRadius: BorderRadius.circular(20.sp),
                    items: List.generate(
                      options.length,
                          (index) => DropdownMenuItem(
                        value: index + 1,
                        child: Text(
                          options[index],
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: widget.selectedTab == index + 1 ? AppColors.primaryColor : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        widget.onChange(value);
                        setState(() {
                          widget.selectedTab = value;
                        });
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
        ],
      ),
    );
  }
}

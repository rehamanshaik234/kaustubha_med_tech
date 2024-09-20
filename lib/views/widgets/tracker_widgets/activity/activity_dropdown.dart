import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';

class ActivityDropDown extends StatefulWidget {
  Function(int index) onChange;
  int selectedTab;

  ActivityDropDown({super.key, required this.onChange, required this.selectedTab});

  @override
  State<ActivityDropDown> createState() => _ActivityDropDownState();
}

class _ActivityDropDownState extends State<ActivityDropDown> {
  final List<String> options = ["Daily", "Weekly", "Monthly"];

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    color: Colors.black,
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
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

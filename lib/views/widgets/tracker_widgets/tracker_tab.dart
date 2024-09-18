import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
class TrackerTab extends StatefulWidget {
  Function(int index) onChange;
  int selectedTab;
  TrackerTab({super.key, required this.onChange,required this.selectedTab});

  @override
  State<TrackerTab> createState() => _TrackerTabState();
}

class _TrackerTabState extends State<TrackerTab> {
  @override
  Widget build(BuildContext context) {
    return CustomSlidingSegmentedControl<int>(
      initialValue: 1,
      children:  {
        1: tab("Daily",1),
        2: tab("Weekly",2),
        3: tab("Monthly",3)
      },
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      thumbDecoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: const Offset(
              0.0,
              2.0,
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      onValueChanged: widget.onChange,
    );
  }

  Widget tab(String title,int index){
    return SizedBox(
      width:1.sw*0.215, child: Center(child: Text(title,style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 14.sp,color: widget.selectedTab==index?Colors.white:Colors.black),)),);
  }
}

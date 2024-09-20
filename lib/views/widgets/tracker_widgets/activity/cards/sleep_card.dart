import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import 'package:provider/provider.dart';

import '../activity_dropdown.dart';
class SleepCard extends StatefulWidget {
  SleepCard({super.key});

  @override
  State<SleepCard> createState() => _SleepCardState();
}

class _SleepCardState extends State<SleepCard> {
  int selectedTab=1;
  num? selectedPercentage=0.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackerProvider>(
      builder: (context,provider,child) {
        num dailyPercentage=provider.tracker.tracks?.sleep?.daily ?? 0.0;
        num weeklyPercentage=provider.tracker.tracks?.sleep?.weekly ?? 0.0;
        num monthlyPercentage=provider.tracker.tracks?.sleep?.monthly ?? 0.0;
        return Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.sp)
          ),
          child: Padding(
            padding: EdgeInsets.all(12.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sleep'.toUpperCase(),style: GoogleFonts.dmSans(color: Colors.black87,fontSize: 16.sp),),
                    ActivityDropDown(onChange: (tab){setState(() {
                      selectedTab=tab;});}, selectedTab: selectedTab),
                  ],
                ),
                SizedBox(height: 12.h,),
                SizedBox(
                  width: 150.w,
                  height: 150.w,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 150.w,
                        height: 150.w,
                        child: CircularProgressIndicator(
                          value: 1,
                          strokeWidth: 10.sp,
                          color:Color(0xFFF2F5FA),
                        ),
                      ),
                      SizedBox(
                        width: 150.w,
                        height: 150.w,
                        child: CircularProgressIndicator(
                          value: selectedTab==1? dailyPercentage/100:selectedTab==2?weeklyPercentage/100:monthlyPercentage/100,
                          strokeCap: StrokeCap.round,
                          strokeWidth: 10.sp,
                          color: getColorByPercentage(selectedTab==1? dailyPercentage:selectedTab==2?weeklyPercentage:monthlyPercentage),
                        ),
                      ),
                      Center(
                        child: Text("${selectedTab==1? dailyPercentage:selectedTab==2?weeklyPercentage:monthlyPercentage}%".padLeft(3,'0'),style: GoogleFonts.dmSans(fontSize: 32.sp),),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8.h,)
              ],
            ),
          ),
        );
      }
    );
  }
  
  Color getColorByPercentage(num percentage){
    if(percentage<=25.0){
      return Colors.redAccent;
    }else if(percentage<=60.0){
      return Colors.orangeAccent;
    }else{
      return Colors.green;
    }
  }




}

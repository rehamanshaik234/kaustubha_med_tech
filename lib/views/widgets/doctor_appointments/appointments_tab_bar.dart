import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors/app_colors.dart';
class DoctorAppointmentsTabBar extends StatelessWidget {
  late TabController tabController;

  DoctorAppointmentsTabBar({super.key,required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller:tabController,
        indicatorColor: AppColors.primaryColor,
        tabs: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.0.h),
            child: Text('Upcoming',style: GoogleFonts.dmSans(color: tabController.index==0? AppColors.primaryColor:Colors.black54,fontSize: 16.sp,fontWeight: FontWeight.w500),),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0.h),
            child: Text('Completed',style: GoogleFonts.dmSans(color: tabController.index==1? AppColors.primaryColor:Colors.black54,fontSize: 16.sp,fontWeight: FontWeight.w500),),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0.h),
            child: Text('Pending',style: GoogleFonts.dmSans(color:  tabController.index==2 ? AppColors.primaryColor:Colors.black54,fontSize: 16.sp,fontWeight: FontWeight.w500),),
          ),
        ]);
  }
}

import 'dart:ui'; // for the blur effect
import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';



class CustomDoctorBottomNavBar extends StatefulWidget {
  late Function(String route) onChange;
  late String currentRoute;

  CustomDoctorBottomNavBar({super.key, required this.onChange,required this.currentRoute});
  @override
  _CustomDoctorBottomNavBarState createState() => _CustomDoctorBottomNavBarState();
}

class _CustomDoctorBottomNavBarState extends State<CustomDoctorBottomNavBar> {

  void _onTabTapped(String route) {
    setState(() {
      widget.onChange(route);
    });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Positioned.fill(
            child: Blur(
              blur: 10,
              colorOpacity: 0.2,
              blurColor: Colors.white,
              child: Container(), // You can use Container here to ensure it's flexible
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCustomTab(RoutesName.doctorHome, "Home",Icons.home),
                  _buildCustomTab(RoutesName.doctorSchedule, "Schedule",Icons.schedule_rounded),
                  _buildCustomTab(RoutesName.doctorAppointments, "Patients",Icons.person_2),
                  _buildCustomTab(RoutesName.doctorCalendar, "Calendar",CupertinoIcons.calendar_today),
                  _buildCustomTab(RoutesName.doctorChat, "Chat",Icons.chat),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCustomTab(String pageRoute, String label,IconData icon) {
    return InkWell(
      onTap: () => _onTabTapped(pageRoute),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: widget.currentRoute == pageRoute ? AppColors.primaryColor : Colors.black54,
          ),
          SizedBox(height: 4.h,),
          Text(
            label,
            style: GoogleFonts.dmSans(
              color: widget.currentRoute == pageRoute ? AppColors.primaryColor : Colors.black87,
              fontSize: 12.sp
            ),
          ),
        ],
      ),
    );
  }

}
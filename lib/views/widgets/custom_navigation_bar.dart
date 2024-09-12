import 'dart:ui'; // for the blur effect
import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';

import '../screens/main/home/home_screen.dart';


class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  // Pages for each tab
  final List<Widget> _pages = [
    HomeScreen(),
    TrackerScreen(),
    ConsultScreen(),
    AppointmentScreen(),
    ChatScreen(),
  ];

  // Titles for each tab (optional)
  final List<String> _titles = [
    "Home",
    "Tracker",
    "Consult",
    "Appointment",
    "Chat"
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Positioned.fill(
            child: Blur(
              blur: 20,
              blurColor: Colors.grey,
              child: Container(), // You can use Container here to ensure it's flexible
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCustomTab(0, "Home",Icons.home),
                  _buildCustomTab(1, "Tracker",Icons.watch_later),
                  _buildCustomTab(2, "Consult",CupertinoIcons.person_crop_rectangle_fill),
                  _buildCustomTab(3, "Appointment",Icons.medical_services),
                  _buildCustomTab(4, "Chat",Icons.chat),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCustomTab(int index, String label,IconData icon) {
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: _selectedIndex == index ? AppColors.primaryColor : Colors.black54,
          ),
          SizedBox(height: 4.h,),
          Text(
            label,
            style: GoogleFonts.dmSans(
              color: _selectedIndex == index ? AppColors.primaryColor : Colors.black87,
              fontSize: 12.sp
            ),
          ),
        ],
      ),
    );
  }

}


class TrackerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tracker Screen'),
    );
  }
}

class ConsultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Consult Screen'),
    );
  }
}

class AppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Appointment Screen'),
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Chat Screen'),
    );
  }
}

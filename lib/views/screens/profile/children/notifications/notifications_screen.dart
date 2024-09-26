import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<String> todayNotifications = [
    'Appointment Success',
    'Appointment Cancelled',
    'Appointment Scheduled'
  ];

  List<String> yesterdayNotifications = [
    'Reminder for Appointment',
    'Offer on Health Checkups',
    'Follow-up Appointment'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBgColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 20.sp,
          ),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w700, fontSize: 20.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: ListView(
          children: [
            SizedBox(height: 8.h),
            // Today Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today',
                  style: GoogleFonts.dmSans(
                      fontSize: 16.sp, color: Colors.black54),
                ),
                Text(
                  'Mark as Read',
                  style: GoogleFonts.dmSans(
                      fontSize: 16.sp, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            ..._buildNotificationList(todayNotifications),

            SizedBox(height: 16.h),

            // Yesterday Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Yesterday',
                  style: GoogleFonts.dmSans(
                      fontSize: 16.sp, color: Colors.black54),
                ),
                Text(
                  'Mark all as Read',
                  style: GoogleFonts.dmSans(
                      fontSize: 16.sp, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            ..._buildNotificationList(yesterdayNotifications),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNotificationList(List<String> notifications) {
    return notifications.map((notification) {
      return Padding(
        padding: EdgeInsets.only(bottom: 16.h, left: 8.w, right: 8.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.green,
              radius: 35.sp,
              child: Icon(
                Icons.calendar_month,
                size: 30.sp,
                color: Colors.black54,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification,
                        style: GoogleFonts.dmSans(
                            fontSize: 16.sp, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '2h',
                        style: GoogleFonts.dmSans(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Text(
                    'You have successfully booked your appointment with Dr. Emily Walker.',
                    style: GoogleFonts.dmSans(
                        fontSize: 14.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

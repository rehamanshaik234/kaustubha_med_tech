import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/reports/health_expected_report.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/reports/overview_report.dart';
class HealthReport extends StatefulWidget {
  const HealthReport({super.key});

  @override
  State<HealthReport> createState() => _HealthReportState();
}

class _HealthReportState extends State<HealthReport> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(left: 8.w,right: 8.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8.h,),
            HealthExpectedReport(),
            SizedBox(height: 12.h,),
            OverviewReportGraph(),
            SizedBox(height: 88.h,),
          ],
        ),
      ),
    );
  }
}

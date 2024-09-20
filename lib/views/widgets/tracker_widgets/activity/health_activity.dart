import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/activity/cards/activity_card.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/activity/cards/sleep_card.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/activity/cards/wellness_card.dart';
import 'package:provider/provider.dart';
class HealthActivity extends StatefulWidget {
  const HealthActivity({super.key});

  @override
  State<HealthActivity> createState() => _HealthActivityState();
}

class _HealthActivityState extends State<HealthActivity> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 30.w,right: 30.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 12.h,),
              ActivityCard(),
              SizedBox(height: 12.h,),
              SleepCard(),
              SizedBox(height: 12.h,),
              const WellnessCard(),
              SizedBox(height: 80.h,)
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_graph/daily/heart_beat.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_graph/daily/temperature_graph.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_graph/daily/track_stress_daily.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_graph/daily/tracker_calories_burn.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_graph/montly/calories_monthly_graph.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_graph/montly/stress_montly_graph.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_graph/montly/temperature_monthly_graph.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_graph/montly/tracker_heart_beat_monthly.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_graph/weekly/calories_weekly_graph.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_graph/weekly/stress_weekly_graph.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_graph/weekly/temperature_weekly_graph.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_graph/weekly/trachker_heart_beat_weekly.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_options.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_dropdown.dart';

class TrackerHealthGraphView extends StatefulWidget {
  TrackerOption trackerOption;
  late int selectedTab;
   TrackerHealthGraphView({super.key,required this.trackerOption,required this.selectedTab});

  @override
  State<TrackerHealthGraphView> createState() => _TrackerHealthGraphViewState();
}

class _TrackerHealthGraphViewState extends State<TrackerHealthGraphView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TrackerDropDown(onChange: (tab){setState(() {widget.selectedTab=tab;});},selectedTab: widget.selectedTab,),
        SizedBox(height: 24.h,),
        getTrackerGraphByOption()

      ],
    );
  }

  Widget getTrackerGraphByOption(){
    if(widget.trackerOption==TrackerOption.pulse){
      return getHBTrackerByTab();
    }else if(widget.trackerOption==TrackerOption.temperature){
      return getTemperatureTrackerByTab();
    }else if(widget.trackerOption==TrackerOption.stress){
       return getStressTrackerByTab();
    }else{
      return getCaloriesBurnTrackerByTab();
    }
  }

  Widget getHBTrackerByTab(){
    if(widget.selectedTab==1){
      return const TrackerHeartBeatDailyGraph();
    } else if(widget.selectedTab==2){
      return const TrackerHeartBeatWeeklyGraph();
    }else{
      return const TrackerHeartBeatMonthlyGraph();
    }
  }

  Widget getTemperatureTrackerByTab(){
    if(widget.selectedTab==1){
      return const TrackerTemperatureDailyGraph();
    } else if(widget.selectedTab==2){
      return const TrackerTemperatureWeeklyGraph();
    }else{
      return const TrackerTemperatureMonthlyGraph();
    }
  }

  Widget getStressTrackerByTab(){
    if(widget.selectedTab==1){
      return const TrackerStressDailyGraph();
    } else if(widget.selectedTab==2){
      return const TrackerStressWeeklyGraph();
    }else{
      return const TrackerStressMonthlyGraph();
    }
  }

  Widget getCaloriesBurnTrackerByTab(){
    if(widget.selectedTab==1){
      return const TrackerCaloriesDailyGraph();
    } else if(widget.selectedTab==2){
      return const TrackerCaloriesBurnWeeklyGraph();
    }else{
      return const TrackerCaloriesBurnMonthlyGraph();
    }
  }
}

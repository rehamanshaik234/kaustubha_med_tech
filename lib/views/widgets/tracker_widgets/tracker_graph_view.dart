import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/tracker_graph/daily/heart_beat.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/tracker_graph/daily/temperature_graph.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/tracker_graph/daily/track_stress_daily.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/tracker_graph/montly/stress_montly_graph.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/tracker_graph/montly/temperature_monthly_graph.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/tracker_graph/montly/tracker_heart_beat_monthly.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/tracker_graph/weekly/stress_weekly_graph.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/tracker_graph/weekly/temperature_weekly_graph.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/tracker_graph/weekly/trachker_heart_beat_weekly.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/tracker_options.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/tracker_tab.dart';
class TrackerGraphView extends StatefulWidget {
  TrackerOption trackerOption;
   TrackerGraphView({super.key,required this.trackerOption});

  @override
  State<TrackerGraphView> createState() => _TrackerGraphViewState();
}

class _TrackerGraphViewState extends State<TrackerGraphView> {
  int selectedTab=1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TrackerTab(onChange: (tab){setState(() {selectedTab=tab;});},selectedTab: selectedTab,),
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
    }else {
       return getStressTrackerByTab();
    }
  }

  Widget getHBTrackerByTab(){
    if(selectedTab==1){
      return const TrackerHeartBeatDailyGraph();
    } else if(selectedTab==2){
      return const TrackerHeartBeatWeeklyGraph();
    }else{
      return const TrackerHeartBeatMonthlyGraph();
    }
  }

  Widget getTemperatureTrackerByTab(){
    if(selectedTab==1){
      return const TrackerTemperatureDailyGraph();
    } else if(selectedTab==2){
      return const TrackerTemperatureWeeklyGraph();
    }else{
      return const TrackerTemperatureMonthlyGraph();
    }
  }

  Widget getStressTrackerByTab(){
    if(selectedTab==1){
      return const TrackerStressDailyGraph();
    } else if(selectedTab==2){
      return const TrackerStressWeeklyGraph();
    }else{
      return const TrackerStressMonthlyGraph();
    }
  }

}

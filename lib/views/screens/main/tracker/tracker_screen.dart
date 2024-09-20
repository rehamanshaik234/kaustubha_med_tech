import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/models/connectivity/error_model.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/activity/health_activity.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_graph_view.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_dropdown.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_options.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/health/tracker_tab_bar.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/reports/health_report.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_appbar.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> with SingleTickerProviderStateMixin {

  TrackerOption selectedOption=TrackerOption.pulse;
  late TabController tabController;
  int selectedTab=1;

@override
  void initState() {
   tabController=TabController(length: 3, vsync: this);
   WidgetsBinding.instance.addPostFrameCallback((_){
     getTrackerInfo();
     tabController.addListener(onChangeTab);
   });
   // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    tabController.removeListener(onChangeTab);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppbar.appBar(
          context,
          bottom: PreferredSize(preferredSize: Size(1.sw, 40.h), child: TrackerTabBar(tabController: tabController,))),
      body: Consumer<TrackerProvider>(
          builder: (context,provider,child){
            if(provider.loader){
              return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
            }
            if(provider.errorMessage.isNotEmpty){
              return Center(child: Text(provider.errorMessage,style: GoogleFonts.dmSans(color: Colors.black54,fontSize: 16.sp),),);
            }
            return TabBarView(controller: tabController,
                children: [
                          health(),
                          HealthActivity(),
                          HealthReport()
                     ]
            );
          }),
    );
  }

  void getTrackerInfo()async{
     TrackerProvider provider=Provider.of<TrackerProvider>(context,listen: false);
     if(provider.tracker.overview==null) {
       await provider.getPatientTracker(onResponse);
     }
  }

  void onResponse(ResponseMessage message) {
       if(message.error!=null){
         Provider.of<TrackerProvider>(context,listen: false).setError(message.error ?? "");
       }
  }

  Widget health(){
    return Column(
      children: [
        SizedBox(height: 16.h,),
        TrackerOptions(selectedOption: selectedOption,onChange: (option){selectedOption=option;setState(() {selectedTab=1;});},),
        SizedBox(height: 24.h,),
        TrackerHealthGraphView(trackerOption: selectedOption,selectedTab:selectedTab,)
      ],
    );
  }

  void onChangeTab(){
     setState(() {});
  }
}

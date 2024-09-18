import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/models/connectivity/error_model.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/tracker_graph_view.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/tracker_tab.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/tracker_options.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_appbar.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {

  TrackerOption selectedOption=TrackerOption.pulse;

@override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((_){
     getTrackerInfo();
   });
   // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppbar.appBar(),
      body: Consumer<TrackerProvider>(
          builder: (context,provider,child){
            if(provider.loader){
              return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
            }
            if(provider.errorMessage.isNotEmpty){
              return Center(child: Text(provider.errorMessage,style: GoogleFonts.dmSans(color: Colors.black54,fontSize: 16.sp),),);
            }
            return Column(
              children: [
                SizedBox(height: 16.h,),
                TrackerOptions(selectedOption: selectedOption,onChange: (option){selectedOption=option;setState(() {});},),
                SizedBox(height: 24.h,),
                TrackerGraphView(trackerOption: selectedOption,)
              ],
            );
          }),
    );
  }

  void getTrackerInfo()async{
    await Provider.of<TrackerProvider>(context,listen: false).getPatientTracker(onResponse);
  }

  void onResponse(ResponseMessage message) {
       if(message.error!=null){
         Provider.of<TrackerProvider>(context,listen: false).setError(message.error ?? "");
       }
  }


}

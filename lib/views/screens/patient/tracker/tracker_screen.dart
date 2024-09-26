import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import 'package:kaustubha_medtech/controller/providers/user/user_provider.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/models/connectivity/error_model.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/views/widgets/file_viewer_modal.dart';
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
  UserInfo patientDet=UserInfo();

@override
  void initState() {
   tabController=TabController(length: 3, vsync: this);
   WidgetsBinding.instance.addPostFrameCallback((_){
     tabController.addListener(onChangeTab);
     getUserInfo();
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
    return  Consumer<UserProvider>(
      builder: (context,provider,_) {
        return Scaffold(
          appBar:patientDet.id!=null?AppBar(
            elevation: 0,
            leading: InkWell(onTap: ()=>Navigator.pop(context), child: Icon(Icons.arrow_back,color: Colors.black,size: 20.sp,)),
            title: Text(
              patientDet.name ?? "",
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                color: AppColors.primaryColor,
              ),
            ),
            bottom: PreferredSize(preferredSize: Size(1.sw, 40.h), child: TrackerTabBar(tabController: tabController,)),
          ):CustomAppbar.patientAppBar(
              context,
              profilePicPath: provider.user.image,
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
          floatingActionButton: Visibility(
              visible: patientDet.documentsModel!=null && (patientDet.documentsModel?.imageUrl1!=null || patientDet.documentsModel?.imageUrl2!=null),
              child: FloatingActionButton(onPressed: (){
                if(patientDet.documentsModel?.imageUrl1!=null && patientDet.documentsModel?.imageUrl2!=null){
                  FileViewerModal.showMultipleNetworkFilePopUp(context, patientDet.documentsModel!.imageUrl1.toString(),patientDet.documentsModel!.imageUrl2.toString());
                }else if(patientDet.documentsModel?.imageUrl1!=null){
                  FileViewerModal.showNetworkFilePopUp(context, patientDet.documentsModel!.imageUrl1.toString());
                }else if(patientDet.documentsModel?.imageUrl2!=null){
                  FileViewerModal.showNetworkFilePopUp(context, patientDet.documentsModel!.imageUrl2.toString());
                }
              },child: Icon(CupertinoIcons.doc,color: Colors.white,size: 20.sp,),)),
        );
      }
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

  void getUserInfo(){
    Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
    if(data!=null){
      patientDet=UserInfo.fromJson(data);
      setState(() {});
    }
  }
}

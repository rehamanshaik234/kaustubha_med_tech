import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/views/widgets/custom_appbar.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/home_widgets/hb_temp_graphs/daily_graph.dart';
import 'package:kaustubha_medtech/views/widgets/home_widgets/hb_temp_graphs/monthly_graph.dart';
import 'package:kaustubha_medtech/views/widgets/home_widgets/hb_temp_graphs/weekly_graph.dart';
import 'package:kaustubha_medtech/views/widgets/home_widgets/pregnancy_fitness_overview.dart';
import 'package:kaustubha_medtech/views/widgets/home_widgets/recommended_communities.dart';
import 'package:kaustubha_medtech/views/widgets/home_widgets/recommended_doctors.dart';

import '../../../../utils/app_colors/app_colors.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  int selectedGraph=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.patientAppBar(context),
      body: Padding(
        padding: EdgeInsets.only(left: 12.0.w,right: 12.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h,),
              const PregnancyFitnessOverview(),
              SizedBox(height: 12.h,),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.sp)
                ),
                child: Padding(
                  padding:  EdgeInsets.all(12.0.sp),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image(image: AssetImage(AssetUrls.heart)),
                          SizedBox(width: 8.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your Health Tracker",style: GoogleFonts.dmSans(fontSize: 19.sp),),
                              Text("Tracking Since 2 months 3days",style: GoogleFonts.dmSans(fontSize: 14.sp),),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      CustomSlidingSegmentedControl<int>(
                        initialValue: 1,
                        children:  {
                          1: SizedBox(width:1.sw*0.215, child: Center(child: Text('Daily',style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 14.sp),)),),
                          2: SizedBox(width:1.sw*0.215, child: Center(child: Text('Weekly',style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 14.sp),)),),
                          3: SizedBox(width:1.sw*0.215, child: Center(child: Text('Monthly',style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 14.sp),)),),
                        },
                        decoration: BoxDecoration(
                          color: CupertinoColors.lightBackgroundGray,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        thumbDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.sp),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                              offset: const Offset(
                                0.0,
                                2.0,
                              ),
                            ),
                          ],
                        ),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInToLinear,
                        onValueChanged: (v) {
                          selectedGraph=v ;
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      graphBySelectedType(),
                      SizedBox(height: 12.h,),
                      CustomButton(onPressed: ()=>Navigator.pushNamed(context,RoutesName.tracker), title: "See More",borderRadius: BorderRadius.circular(20.sp),padding: 0,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h,),
              Row(
                children: [
                  suggestionCard("Pregnancy\nMother Fitness",AssetUrls.pregnantCard),
                  suggestionCard("Suggestions\n",AssetUrls.suggestionCard),
                ],
              ),
              SizedBox(height: 12.h,),
              RecommendedDoctors(),
              SizedBox(height: 12.h,),
              RecommendedCommunities(),
              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget suggestionCard(String title,String imageUrl){
    return Expanded(
      child: Card(
        color: Colors.white,
        child: Padding(
          padding:  EdgeInsets.all(8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.sp,
                child: Image(image: AssetImage(imageUrl),fit: BoxFit.contain,),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(title,style: GoogleFonts.dmSans(fontSize: 16.sp,fontWeight: FontWeight.w500),)
            ],
          ),
        ),
      ),
    );
  }

  Widget graphBySelectedType(){
    if(selectedGraph==1){
      return HeartBeatTemperatureDailyGraph();
    }else if(selectedGraph==2){
      return HeartBeatTemperatureWeeklyGraph();
    }else{
      return HeartBeatTemperatureMonthlyGraph();
    }
  }
}

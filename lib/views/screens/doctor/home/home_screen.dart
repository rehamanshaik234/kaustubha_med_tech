import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/user/user_provider.dart';
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
import 'package:provider/provider.dart';

import '../../../../utils/app_colors/app_colors.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  int selectedGraph=1;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context,provider,_) {
        return Scaffold(
          appBar: CustomAppbar.patientAppBar(context,profilePicPath: provider.user.image),
          body: Center(child: Text("Coming Soon",style: GoogleFonts.dmSans(fontSize: 16.sp),)),
        );
      }
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

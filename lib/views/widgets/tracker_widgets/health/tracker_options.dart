import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
enum TrackerOption{temperature,stress,pulse,caloriesBurn}

class TrackerOptions extends StatelessWidget {
  late TrackerOption selectedOption;
  late Function(TrackerOption option) onChange;
  TrackerOptions({super.key,required this.selectedOption,required this.onChange});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          optionsCard("Heart Beat", TrackerOption.pulse,AssetUrls.heartBeat,EdgeInsets.only(right: 8.w,left: 8.w)),
          optionsCard("Temperature", TrackerOption.temperature,AssetUrls.temperature,EdgeInsets.only(right: 8.w)),
          optionsCard("Stress", TrackerOption.stress,AssetUrls.stress,EdgeInsets.only(right: 8.w)),
          optionsCard("Calories Burn", TrackerOption.caloriesBurn,AssetUrls.calories,EdgeInsets.only(right: 8.w),imageHeight: 30.h),
        ],
      ),
    );
  }

  Widget optionsCard(String title,TrackerOption option,String assetUrl,EdgeInsets margin,{double? imageHeight=null}){
    return InkWell(
      onTap: (){
        onChange(option);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: selectedOption==option? AppColors.primaryColor:Colors.transparent),
          borderRadius: BorderRadius.circular(25.sp),
          color: selectedOption==option?AppColors.secondaryColor:Colors.white
        ),
        padding: EdgeInsets.symmetric(horizontal:  8.sp,vertical: 4.h),
        margin: margin,
        child: Row(
          children: [
            Image(image: AssetImage(assetUrl),height: imageHeight,),
            SizedBox(width: 8.w,),
            Text(title,style: GoogleFonts.dmSans(color: Colors.black87,fontSize: 16.sp,),),
          ],
        ),
      ),
    );
  }
}

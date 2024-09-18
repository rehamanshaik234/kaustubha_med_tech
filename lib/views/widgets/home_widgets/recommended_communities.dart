import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';

class RecommendedCommunities extends StatelessWidget {
  const RecommendedCommunities({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.sp)
                ),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Row(
                    children: [
                      Image(image: AssetImage(AssetUrls.communityIcon)),
                      SizedBox(width: 4.w),
                      Text(
                        "Explore Community",
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'View All',
                style: GoogleFonts.dmSans(
                  color: AppColors.primaryColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  communityCard(),
                  communityCard(),
                  communityCard(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget communityCard() {
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: 150.w, // Set a fixed width for each card
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: AssetImage(AssetUrls.pregnantCard), fit: BoxFit.contain,width: 50.w,),
              SizedBox(height: 8.h),
              Text(
                'Babycentre',
                style: GoogleFonts.dmSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 32.h,),
              CustomButton(onPressed: (){}, title: "Join Community",
                titleStyle: GoogleFonts.inter(fontWeight: FontWeight.w500,fontSize:10.sp,color: Colors.white ),
                padding:0,height: 30.h,),
            ],
          ),
        ),
      ),
    );
  }
}

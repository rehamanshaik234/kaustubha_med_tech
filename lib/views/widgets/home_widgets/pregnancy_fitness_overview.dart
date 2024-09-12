import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/asset_urls.dart';
class PregnancyFitnessOverview extends StatelessWidget {
  const PregnancyFitnessOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return  FittedBox(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Row(
            children: [
              Image(image: AssetImage(AssetUrls.pregnancyWomen,),),
              SizedBox(width: 8.w,),
              Text("Pregnancy fitness overview",style: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w400),)
            ],
          ),
        ),
      ),
    );
  }
}

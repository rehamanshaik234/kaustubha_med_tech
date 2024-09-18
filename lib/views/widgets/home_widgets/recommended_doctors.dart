import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';

class RecommendedDoctors extends StatelessWidget {
  const RecommendedDoctors({super.key});

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
                      Image(image: AssetImage(AssetUrls.doctorsSuggestion)),
                      SizedBox(width: 4.w),
                      Text(
                        "Recommended Doctors",
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
                  doctorInfoCard(),
                  doctorInfoCard(),
                  doctorInfoCard(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget doctorInfoCard() {
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: 150.w, // Set a fixed width for each card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(AssetUrls.doctorsProfile), fit: BoxFit.contain,width: 150.w,),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:  8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center( // Center the text inside its parent container
                    child: Text(
                      'Dr. Deep Sorthiya',
                      style: GoogleFonts.dmSans(
                        color: AppColors.primaryColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h,),
                  Row(
                    children: [
                      Image(image: AssetImage(AssetUrls.stethoscopeIcon)),
                      SizedBox(width: 4.w,),
                      Text(
                        'Obstetricians',
                        style: GoogleFonts.dmSans(fontSize: 12.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h,),
                  Row(
                    children: [
                      Icon(Icons.medical_services_outlined,color: Colors.black,size: 12.sp,),
                      SizedBox(width: 4.w,),
                      Text(
                        '24 years Exp.',
                        style: GoogleFonts.dmSans(fontSize: 12.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h,),
                  CustomButton(onPressed: (){}, title: "Book Appointment",
                    titleStyle: GoogleFonts.inter(fontWeight: FontWeight.w500,fontSize:10.sp,color: Colors.white ),
                    padding:0,height: 30.h,),
                  SizedBox(height: 8.h,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

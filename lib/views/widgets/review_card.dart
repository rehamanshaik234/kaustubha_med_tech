import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/models/reviews/ReviewModel.dart';

import '../../utils/app_colors/app_colors.dart';
import '../../utils/constants/asset_urls.dart';
class ReviewCard extends StatelessWidget {
  ReviewCard({super.key,required this.review});
  ReviewModel review;

  @override
  Widget build(BuildContext context) {
    int rating=int.parse(review.rating ?? "0");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(30.sp),
                child: Image(image: review.patientProfilePic!=null?NetworkImage(review.patientProfilePic.toString()):AssetImage(AssetUrls.doctorsProfile),height: 60.h,width: 60.w,fit: BoxFit.cover,)),
            SizedBox(width: 8.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(review.patientName ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16.sp),),
                SizedBox(height: 8.h,),
                Row(
                  children: [
                    Text(review.rating ??"",style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 12.sp,color: Colors.black54),),
                    Icon(rating>=1? Icons.star:Icons.star_outline_outlined,color: AppColors.ratingColor,size: 16.sp,),
                    Icon(rating>=2? Icons.star:Icons.star_outline_outlined,color: AppColors.ratingColor,size: 16.sp,),
                    Icon(rating>=3? Icons.star:Icons.star_outline_outlined,color: AppColors.ratingColor,size: 16.sp,),
                    Icon(rating>=4? Icons.star:Icons.star_outline_outlined,color: AppColors.ratingColor,size: 16.sp,),
                    Icon(rating>=5? Icons.star:Icons.star_outline_outlined,color: AppColors.ratingColor,size: 16.sp,),
                  ],
                )
              ],
            )
          ],
        ),
        SizedBox(height: 8.h,),
        Text(review.message ?? "",
          style:GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54) ,),
        SizedBox(height: 16.h,)
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class TrackerAverageWidget extends StatelessWidget {
  String title;
  num value;
  TrackerAverageWidget({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.sp)
      ),
      padding: EdgeInsets.symmetric(vertical:  8.sp,horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: GoogleFonts.dmSans(fontSize: 16.sp),),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 12.sp,
                child: Center(child: Icon(Icons.arrow_upward,color: Colors.white,size: 15.sp,)),),
              SizedBox(width: 4.w,),
              Text('${formatToTwoDecimalPlaces(value)}',style: GoogleFonts.inter(fontSize: 20.sp,fontWeight: FontWeight.w700),),
            ],
          )
        ],
      ),
    );
  }

  double formatToTwoDecimalPlaces(num value) {
    return double.parse(value.toStringAsFixed(2));
  }
}

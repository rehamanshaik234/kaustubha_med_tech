import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/models/consult/DoctorInfo.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({super.key});

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {

  List<DoctorInfo> data= [
    DoctorInfo(
      doctorName: 'Dr. David Patel',
      doctorSpecialist: "Obstetricians",
      address: 'Cardiology Center, USA',
      ratings: 5,
      reviewsCount: 1200
    ),
    DoctorInfo(
      doctorName: 'Dr. David Patel',
      doctorSpecialist: "Obstetricians",
      address: 'Cardiology Center, USA',
      ratings: 5,
      reviewsCount: 1200
    ),
    DoctorInfo(
      doctorName: 'Dr. David Patel',
      doctorSpecialist: "Obstetricians",
      address: 'Cardiology Center, USA',
      ratings: 5,
      reviewsCount: 1200
    ),
    DoctorInfo(
      doctorName: 'Dr. David Patel',
      doctorSpecialist: "Obstetricians",
      address: 'Cardiology Center, USA',
      ratings: 5,
      reviewsCount: 1200
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context,index){
          return doctorCard(index);
        });
  }

  Widget doctorCard(int index){
    return Container(
      margin: data.length==(index+1)? EdgeInsets.only(bottom: 50.h):EdgeInsets.zero,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: InkWell(
        onTap: ()=>Navigator.of(context,rootNavigator: true).pushNamed(RoutesName.patientDoctorDetails,arguments: {"doctor_id":data[index].doctorName}),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage(AssetUrls.doctorProfile),height: 100.h,),
                SizedBox(width: 8.w,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data[index].doctorName ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16.sp),),
                          Icon(CupertinoIcons.heart,color: Colors.grey,size: 20.sp,)
                        ],
                      ),
                      SizedBox(height: 8.h,),
                      Divider(color: Colors.grey.shade400,height: 2.h,),
                      SizedBox(height: 4.h,),
                      Text(data[index].doctorSpecialist ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                      SizedBox(height: 4.h,),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,color: Colors.grey,size: 16.sp,),
                          Text(data[index].address ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54),),
                        ],
                      ),
                      SizedBox(height: 4.h,),
                      Row(
                        children: [
                          Icon(Icons.star,color: AppColors.ratingColor,size: 20.sp,),
                          SizedBox(width: 2.w,),
                          Text("${data[index].ratings ?? "0"}" ,style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54),),
                          SizedBox(width: 8.w,),
                          Container(height: 10.h,width: 1.w,color: Colors.grey,),
                          SizedBox(width: 8.w,),
                          Text("${data[index].reviewsCount ?? "0"} Reviews" ,style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54),),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}

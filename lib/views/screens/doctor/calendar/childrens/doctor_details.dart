import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/models/consult/DoctorInfo.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/constants/asset_urls.dart';
class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  String doctorId='';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getDoctorId();
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldBgColor,
        leading: InkWell(onTap: ()=>Navigator.pop(context), child: Icon(Icons.arrow_back,color: Colors.black,size: 20.sp,)),
        title: Text("Doctor Details",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            doctorCard(DoctorInfo(
                doctorName: 'Dr. David Patel',
                doctorSpecialist: "Obstetricians",
                address: 'Cardiology Center, USA',
                ratings: 5,
                reviewsCount: 1200
            ),),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                doctorRecords(CupertinoIcons.person_2_fill, "2,000+", "patients"),
                doctorRecords(Icons.medical_services, "10+", "experience"),
                doctorRecords(Icons.star_rounded, "5", "rating"),
                doctorRecords(Icons.rate_review_rounded, "1,834", "reviews"),
              ],
            ),
            SizedBox(height: 16.h,),
            about(),
            SizedBox(height: 16.h,),
            workingTimes(),
            SizedBox(height: 16.h,),
            reviews(),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(16.sp),
        child: CustomButton(onPressed: (){
          Navigator.pushNamed(context, RoutesName.bookAppointment);
        }, title: "Book Appointment",borderRadius: BorderRadius.circular(25.sp),),
      ),
    );
  }

  Widget doctorCard(DoctorInfo doctorInfo){
    return Card(
      elevation: 5,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(doctorInfo.doctorName ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16.sp),),
                    ],
                  ),
                  SizedBox(height: 8.h,),
                  Divider(color: Colors.grey.shade400,height: 2.h,),
                  SizedBox(height: 4.h,),
                  Text(doctorInfo.doctorSpecialist ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                  SizedBox(height: 4.h,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,color: Colors.grey,size: 16.sp,),
                      Text(doctorInfo.address ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54),),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget doctorRecords(IconData icon,String title,String subTitle){
    return Column(
      children: [
        Icon(icon,color: AppColors.primaryColor,size: 30.sp,),
        SizedBox(height: 8.h,),
        Text(title,style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w600),),
        Text(subTitle,style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Colors.black54),),
      ],
    );
  }


  void getDoctorId() {
    Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
    if(data!=null){
      doctorId=data['doctor_id'];
      setState(() {

      });
    }
  }

  Widget about() {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Text("About me",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 20.sp),),
            ],
          ),
          SizedBox(height: 8.h,),
          RichText(text: TextSpan(
            children: [
              TextSpan(text: "Dr. David Patel, a dedicated cardiologist, brings a wealth of experience to Golden Gate Cardiology Center in Golden Gate, CA. ",
              style:GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54) ),
              TextSpan(text: "view more",
                  style:GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black),),
            ]
          )),
        ],
      ),
    );
  }

  Widget workingTimes() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Working Time",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 20.sp),),
            ],
          ),
          SizedBox(height: 8.h,),
          Text("Monday-Friday, 08.00 AM-18.00 pM",
              style:GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54) ),
        ],
      ),
    );
  }

  Widget reviews() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Reviews",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 20.sp),),
              Text("See All",
                  style:GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54) ),
            ],
          ),
          SizedBox(height: 16.h,),
          Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.sp),
                      child: Image(image: AssetImage(AssetUrls.doctorsProfile),height: 60.h,width: 60.w,fit: BoxFit.cover,)),
                  SizedBox(width: 8.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Emily Anderson",style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16.sp),),
                      SizedBox(height: 8.h,),
                      Row(
                        children: [
                          Text('5.0',style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 12.sp,color: Colors.black54),),
                          Icon(Icons.star,color: AppColors.ratingColor,size: 16.sp,),
                          Icon(Icons.star,color: AppColors.ratingColor,size: 16.sp,),
                          Icon(Icons.star,color: AppColors.ratingColor,size: 16.sp,),
                          Icon(Icons.star,color: AppColors.ratingColor,size: 16.sp,),
                          Icon(Icons.star,color: AppColors.ratingColor,size: 16.sp,),
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 8.h,),
              Text('Dr. Patel is a true professional who genuinely cares about his patients. I highly recommend Dr. Patel to anyone seeking exceptional cardiac care.',
              style:GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54) ,)
            ],
          )
        ],
      ),
    );
  }
}

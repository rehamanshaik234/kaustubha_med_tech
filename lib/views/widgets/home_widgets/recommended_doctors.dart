import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_home.dart';
import 'package:kaustubha_medtech/models/consult/DoctorInfo.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/utils/routes/route_names/route_names.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class RecommendedDoctors extends StatefulWidget {
  const RecommendedDoctors({super.key});

  @override
  State<RecommendedDoctors> createState() => _RecommendedDoctorsState();
}

class _RecommendedDoctorsState extends State<RecommendedDoctors> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getDoctorsList();
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<PatientHomeProvider>(
      builder: (context,provider,child) {
        if(provider.loader){
          return SizedBox(
            height: 100.h,
            child: Center(
              child: CircularProgressIndicator(color: Colors.black,strokeWidth: 2.sp,),
            ),
          );
        }
        if(provider.recommendedDRs.isEmpty){
          return Container();
        }

        return SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  InkWell(
                    onTap: ()=>Navigator.pushNamed(context,RoutesName.consult),
                    child: Text(
                      'View All',
                      style: GoogleFonts.dmSans(
                        color: AppColors.primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              SizedBox(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for(int i=0;i<provider.recommendedDRs.length;i++)
                        doctorInfoCard(provider.recommendedDRs[i])
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }

  Widget doctorInfoCard(DoctorInfo doctorInfo) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: 150.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12.sp),
                child: Image(image: doctorInfo.image!=null? NetworkImage(doctorInfo.image ?? ''):
                AssetImage(AssetUrls.doctorsProfile), fit: BoxFit.contain,
                  width: 150.w,height: 100.h,)),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:  8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center( // Center the text inside its parent container
                    child: Text(
                      'Dr. ${doctorInfo.legalName ?? ""}',
                      style: GoogleFonts.dmSans(
                        color: AppColors.primaryColor,
                        fontSize: 14.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 8.h,),
                  Row(
                    children: [
                      Image(image: AssetImage(AssetUrls.stethoscopeIcon)),
                      SizedBox(width: 4.w,),
                      Expanded(
                        child: Text(doctorInfo.specialization ?? "",
                          style: GoogleFonts.dmSans(fontSize: 12.sp),overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h,),
                  Row(
                    children: [
                      Icon(Icons.medical_services_outlined,color: Colors.black,size: 12.sp,),
                      SizedBox(width: 4.w,),
                      Text(
                        '${doctorInfo.experienceYears ?? ''} years Exp.',
                        style: GoogleFonts.dmSans(fontSize: 12.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h,),
                  CustomButton(onPressed: (){

                  }, title: "Book Appointment",
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

  void getDoctorsList(){
    PatientHomeProvider provider=Provider.of<PatientHomeProvider>(context,listen: false);
    if(provider.recommendedDRs.isEmpty){
      provider.getRecommendedDoctors((re){});
    }
  }
}

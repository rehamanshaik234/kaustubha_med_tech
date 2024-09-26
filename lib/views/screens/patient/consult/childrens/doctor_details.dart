import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_appointments.dart';
import 'package:kaustubha_medtech/controller/providers/review/review_provider.dart';
import 'package:kaustubha_medtech/models/appointments/DoctorDetailsModel.dart';
import 'package:kaustubha_medtech/models/consult/DoctorInfo.dart';
import 'package:kaustubha_medtech/models/reviews/ReviewModel.dart';
import 'package:kaustubha_medtech/utils/routes/route_names/route_names.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/review_card.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/constants/asset_urls.dart';
class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  String doctorId='';
  bool viewMore=false;

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
      body: Consumer2<PatientAppointmentProvider,ReviewProvider>(
        builder: (context,appointmentProvider,reviewProvider,_) {
          if(appointmentProvider.loader || reviewProvider.loader){
            return const Center(child: CircularProgressIndicator(color: Colors.black,),);
          }
          DoctorDetailsModel doctorDetailsModel=appointmentProvider.doctorDetails;
          Profile? doctorProfile= appointmentProvider.doctorDetails.profile;
          Availability? availability=appointmentProvider.doctorDetails.availability;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  doctorCard(appointmentProvider.doctorDetails),
                  SizedBox(height: 16.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      doctorRecords(CupertinoIcons.person_2_fill, "2,000+", "Patients"),
                      doctorRecords(Icons.medical_services, "${doctorProfile?.experienceYears ?? "0 years"} yrs", "Experience"),
                      doctorRecords(Icons.star_rounded, "${doctorDetailsModel.avgRatings ?? '0'}", "Rating"),
                      doctorRecords(Icons.rate_review_rounded, "${doctorDetailsModel.totalReviews ?? '0'}", "Reviews"),
                    ],
                  ),
                  SizedBox(height: 16.h,),
                  about(about: appointmentProvider.doctorDetails.about),
                  SizedBox(height: 16.h,),
                  workingTimes(availability),
                  SizedBox(height: 16.h,),
                  reviews(reviewProvider.reviews),
                  SizedBox(height: 60.h,)
                ],
              ),
            ),
          );
        }
      ),
      bottomSheet: Consumer2<PatientAppointmentProvider,ReviewProvider>(
        builder:(context,appointmentProvider,reviewProvider,_) {
          if(appointmentProvider.loader || reviewProvider.loader){
            return const Center();
          }
          return Padding(
            padding: EdgeInsets.all(16.sp),
            child: CustomButton(onPressed: (){
              Navigator.pushNamed(context, RoutesName.appointmentTimeSlot,arguments: {"doctor_id":doctorId});
            }, title: "Book Appointment",borderRadius: BorderRadius.circular(25.sp),),
          );
        }
      ),
    );
  }

  Widget doctorCard(DoctorDetailsModel doctorInfo){
    return Card(
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.sp),
                child: Image(image:doctorInfo.image!=null?NetworkImage(doctorInfo.image): AssetImage(AssetUrls.doctorProfile),
                  height: 100.h,width: 100.w,fit: BoxFit.cover,)),
            SizedBox(width: 8.w,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(doctorInfo.profile?.legalName ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16.sp),),
                    ],
                  ),
                  SizedBox(height: 8.h,),
                  Divider(color: Colors.grey.shade400,height: 2.h,),
                  SizedBox(height: 4.h,),
                  Text(doctorInfo.profile?.subSpecialist ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                  SizedBox(height: 4.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on_outlined,color: Colors.grey,size: 16.sp,),
                      Expanded(child: Text(doctorInfo.profile?.address ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54),)),
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

  Widget about({String? about}) {
    return about !=null?SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Text("About me",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 20.sp),),
            ],
          ),
          SizedBox(height: 8.h,),
          about.length>100?RichText(
              text: TextSpan(
            children: [
              TextSpan(text: about.length>100?viewMore? about : about.substring(0,100): about ,
              style:GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54) ),
              TextSpan(text: " view ${viewMore ? "less":"more"}",
                  style:GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black),recognizer: TapGestureRecognizer()..onTap=(){
                             viewMore=!viewMore;
                             setState(() {});
              }),
            ],
          )):
          Text(about , style:GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54) ),
        ],
      ),
    ):const SizedBox();
  }

  Widget workingTimes(Availability? availability) {
    String to= availability!=null && availability.availableTimeSlot!=null && availability.availableTimeSlot!.isNotEmpty?
    availability.availableTimeSlot!.last:'';
    List<String> weeks=availability!=null? availability.availableDays ?? []:[];
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
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              Text("${weeks.map<String>((day) => day).join(', ')} (${availability?.availableTimeFrom ?? ""} - $to)",
                  style:GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54) ),
            ],
          ),
        ],
      ),
    );
  }

  Widget reviews(List<ReviewModel> reviews) {
    if(reviews.isEmpty){
      return Container();
    }
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Reviews",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 20.sp),),
              // Text("See All",
              //     style:GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54) ),
            ],
          ),
          SizedBox(height: 16.h,),
          ...reviews.map((review){
            return ReviewCard(review: review);
          }),
        ],
      ),
    );
  }


  void getDoctorId()async{
    Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
    PatientAppointmentProvider provider=Provider.of<PatientAppointmentProvider>(context,listen: false);
    ReviewProvider reviewProvider=Provider.of<ReviewProvider>(context,listen: false);
    if(data!=null){
      doctorId=data['doctor_id'].toString();
      Map<String,dynamic> reviewData={'doctorId':doctorId};
      Future.wait([
        provider.getDoctorDetails(doctorId, (r){}),
        reviewProvider.getDoctorReviews(reviewData, (r){})
      ]);
    }
  }
}

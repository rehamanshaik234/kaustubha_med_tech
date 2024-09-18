import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/models/appointments/appointment_info.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/constants/asset_urls.dart';
class CanceledAppointments extends StatefulWidget {
  const CanceledAppointments({super.key});

  @override
  State<CanceledAppointments> createState() => _CanceledAppointmentsState();
}

class _CanceledAppointmentsState extends State<CanceledAppointments> {
  List<AppointmentInfo> appointments=[
    AppointmentInfo(
        doctorName: 'Dr. David Patel',
        doctorSpecialist: "Obstetricians",
        address: 'Cardiology Center, USA',
        dateTime: 'May 22, 2025 - 10.00 AM',
        reviewsCount: 1200
    ),
    AppointmentInfo(
        doctorName: 'Dr. David Patel',
        doctorSpecialist: "Obstetricians",
        address: 'Cardiology Center, USA',
        dateTime: 'May 22, 2025 - 10.00 AM',
        reviewsCount: 1200
    ),
    AppointmentInfo(
        doctorName: 'Dr. David Patel',
        doctorSpecialist: "Obstetricians",
        address: 'Cardiology Center, USA',
        dateTime: 'May 22, 2025 - 10.00 AM',
        reviewsCount: 1200
    ),
    AppointmentInfo(
        doctorName: 'Dr. David Patel',
        doctorSpecialist: "Obstetricians",
        address: 'Cardiology Center, USA',
        dateTime: 'May 22, 2025 - 10.00 AM',
        reviewsCount: 1200
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context,index){
          return Padding(
            padding: EdgeInsets.only(top: index==0? 8.h:0,bottom:appointments.length==index+1?60.h:8.h,left: 8.w,right: 8.w),
            child: appointmentCard(appointments[index]),
          );
        });
  }

  Widget appointmentCard(AppointmentInfo appointmentInfo){
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.sp,vertical: 12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appointmentInfo.dateTime??"",style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16.sp),),
            SizedBox(height: 8.h,),
            Divider(color: Colors.grey.shade400,height: 2.h,),
            SizedBox(height: 8.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage(AssetUrls.doctorProfile),height: 100.h,),
                SizedBox(width: 8.w,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appointmentInfo.doctorName ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16.sp),),
                      SizedBox(height: 8.h,),
                      Text(appointmentInfo.doctorSpecialist ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                      SizedBox(height: 8.h,),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,color: Colors.grey,size: 16.sp,),
                          Text(appointmentInfo.address ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54),),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 8.h,),
            Divider(color: Colors.grey.shade400,height: 2.h,),
            SizedBox(height: 8.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(onPressed: (){}, title: "Re-Book",bgColor:AppColors.buttonSecondaryBgColor,textColor: AppColors.primaryColor,width: 1.sw*0.4,height: 40.h,padding:0,
                borderRadius: BorderRadius.circular(20.sp),),
                CustomButton(onPressed: (){}, title: "Add-Reviews",width: 1.sw*0.4,height: 40.h,padding:0,borderRadius: BorderRadius.circular(20.sp),),
              ],
            )
          ],
        ),
      ),
    );
  }
}

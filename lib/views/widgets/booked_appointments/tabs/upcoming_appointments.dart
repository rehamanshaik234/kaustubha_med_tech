import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_appointments.dart';
import 'package:kaustubha_medtech/models/appointments/appointment_info.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/views/alerts/book_appointment.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/constants/asset_urls.dart';
class UpcomingAppointments extends StatefulWidget {
  const UpcomingAppointments({super.key});

  @override
  State<UpcomingAppointments> createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getAppointments();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientAppointmentProvider>(
      builder: (context,provider,child) {
        if(provider.loader && !provider.isUpcomingAptFetched){
         return Center(
           child: CircularProgressIndicator(
             color: Colors.black,
             strokeWidth: 2.w,
           ),
         );
        }

        if(provider.upcomingAppointments.isEmpty){
          return Center(
            child: Text("No Appointments Found",style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 16.sp),),
          );
        }
        List<AppointmentInfo> appointments=provider.upcomingAppointments;
        return ListView.builder(
            itemCount: provider.upcomingAppointments.length,
            itemBuilder: (context,index){
              return Padding(
                padding: EdgeInsets.only(top: index==0? 8.h:0,bottom:appointments.length==index+1?60.h:8.h,left: 8.w,right: 8.w,),
                child: appointmentCard(appointments[index]),
              );
            });
      }
    );
  }

  Widget appointmentCard(AppointmentInfo appointmentInfo){
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.sp,vertical: 12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${Constants.dateConverted(appointmentInfo.date ??"")} - ${appointmentInfo.time ?? ""}",style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16.sp),),
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
                      Text(appointmentInfo.purpose ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                      SizedBox(height: 8.h,),
                      Container(
                        decoration: BoxDecoration(
                          color: appointmentInfo.status!.contains('Not')?Colors.orangeAccent: Colors.green,
                          borderRadius: BorderRadius.circular(20.sp)
                        ),
                        padding: EdgeInsets.all(8.sp),
                        child: 
                          Text(appointmentInfo.status ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color:Colors.white),),
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
                CustomButton(onPressed: (){
                  AppointmentAlert.showCancelAppointment(context);
                }, title: "Cancel",bgColor:AppColors.buttonSecondaryBgColor,textColor: AppColors.primaryColor,width: 1.sw*0.4,height: 40.h,padding:0,
                borderRadius: BorderRadius.circular(20.sp),),
                CustomButton(onPressed: (){
                  Navigator.of(context,rootNavigator: true).pushNamed(RoutesName.reScheduleAppointment);
                }, title: "Re-Schedule",width: 1.sw*0.4,height: 40.h,padding:0,borderRadius: BorderRadius.circular(20.sp),),
              ],
            )
          ],
        ),
      ),
    );
  }

  void getAppointments(){
   final provider= Provider.of<PatientAppointmentProvider>(context,listen: false);
   provider.getUpcomingAppointments((r){});
  }


}

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
  int? _rescheduleIndex;
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
        List<AppointmentInfo> appointments=provider.upcomingAppointments;
        List<AppointmentInfo> upcoming=[];
        for (var appointment in appointments) {
          if(appointment.status!='Cancled'){
            upcoming.add(appointment);
          }
        }
        if(upcoming.isEmpty){
          return Center(
            child: Text("No Appointments Found",style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 16.sp),),
          );
        }
        return ListView.builder(
            itemCount: upcoming.length,
            itemBuilder: (context,index){
              return Padding(
                padding: EdgeInsets.only(top: index==0? 8.h:0,bottom:upcoming.length==index+1?60.h:8.h,left: 8.w,right: 8.w,),
                child: appointmentCard(upcoming[index],provider,index),
              );
            });
      }
    );
  }

  Widget appointmentCard(AppointmentInfo appointmentInfo,PatientAppointmentProvider provider,int index){
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.sp),
                  child: Image(image: appointmentInfo.doctor?.image==null? AssetImage(AssetUrls.doctorProfile):NetworkImage(appointmentInfo.doctor?.image ?? ''),
                    height: 100.sp,
                    width: 100.sp,
                    fit: BoxFit.cover, errorBuilder: (error,_,e){
                    return Image.asset(AssetUrls.doctorProfile);
                  },),
                ),
                SizedBox(width: 8.w,height: 100.h),
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
                          color: appointmentInfo.status==Constants.notConfirm?Colors.orangeAccent: Colors.green,
                          borderRadius: BorderRadius.circular(20.sp)
                        ),
                        padding: EdgeInsets.all(8.sp),
                        child:
                          Text(appointmentInfo.status==Constants.notConfirm?'Pending':'Confirmed',style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color:Colors.white),),
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
                  AppointmentAlert.showCancelAppointment(context,appointmentInfo.id.toString());
                }, title: "Cancel",bgColor:AppColors.buttonSecondaryBgColor,textColor: AppColors.primaryColor,width: 1.sw*0.4,height: 40.h,padding:0,
                borderRadius: BorderRadius.circular(20.sp),),
                CustomButton(onPressed: ()async{
                  setState(() {
                    _rescheduleIndex=index;
                  });
                  await provider.getDoctorDetails(appointmentInfo.doctorId.toString(), (r){});
                  setState(() {
                    _rescheduleIndex=null;
                  });
                  Navigator.of(context,rootNavigator: true).pushNamed(RoutesName.reScheduleAppointment,arguments: {'date':appointmentInfo.date,'slot':appointmentInfo.time,'doctor_id':appointmentInfo.doctorId,'id':appointmentInfo.id});
                }, title: "Re-Schedule",width: 1.sw*0.4,height: 40.h,padding:0,borderRadius: BorderRadius.circular(20.sp),loader: provider.loader && _rescheduleIndex==index,),
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

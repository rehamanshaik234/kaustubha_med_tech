import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/models/appointments/appointment_info.dart';
import 'package:kaustubha_medtech/utils/routes/route_names/route_names.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../../../controller/providers/patient/patient_appointments.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/constants/asset_urls.dart';
import '../../../../utils/constants/constants.dart';
import '../../../alerts/custom_alerts.dart';
class CanceledAppointments extends StatefulWidget {
  const CanceledAppointments({super.key});

  @override
  State<CanceledAppointments> createState() => _CanceledAppointmentsState();
}

class _CanceledAppointmentsState extends State<CanceledAppointments> {
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getAppointments();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        return await getAppointments(showPopUp: true);
      },
      child: Consumer<PatientAppointmentProvider>(
          builder: (context,provider,child) {
            if(provider.loader && !provider.isCanceledAptFetched){
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 2.w,
                ),
              );
            }
            List<AppointmentInfo> appointments=provider.canceledAppointments;
            if(appointments.isEmpty){
              return Center(
                child: Text("No Appointments Found",style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 16.sp),),
              );
            }
            return ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: EdgeInsets.only(top: index==0? 8.h:0,bottom:appointments.length==index+1?60.h:8.h,left: 8.w,right: 8.w,),
                    child: appointmentCard(appointments[index],provider,index),
                  );
                });
          }
      ),
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
                ),                SizedBox(width: 8.w,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appointmentInfo.doctorName ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16.sp),),
                      SizedBox(height: 8.h,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20.sp)
                        ),
                        padding: EdgeInsets.all(8.sp),
                        child:
                        Text(appointmentInfo.status ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color:Colors.white),),
                      ),
                      SizedBox(height: 8.h,),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,color: Colors.grey,size: 16.sp,),
                          Text(appointmentInfo.mode ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54),),
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
                CustomButton(onPressed: ()=>Navigator.of(context,rootNavigator: true).pushNamed(RoutesName.patientDoctorDetails,arguments: {"doctor_id":appointmentInfo.doctorId}), title: "Re-Book",bgColor:AppColors.buttonSecondaryBgColor,textColor: AppColors.primaryColor,width: 1.sw*0.4,height: 40.h,padding:0,
                borderRadius: BorderRadius.circular(20.sp),),
                CustomButton(onPressed: (){
                  Navigator.of(context,rootNavigator: true).pushNamed(RoutesName.addReview,arguments: {'id':appointmentInfo.id});
                }, title: "Add-Reviews",width: 1.sw*0.4,height: 40.h,padding:0,borderRadius: BorderRadius.circular(20.sp),),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> getAppointments({bool? showPopUp})async {
    final provider= Provider.of<PatientAppointmentProvider>(context,listen: false);
    await provider.getCanceledAppointments((r){
      if(r.success!=null&& r.data!=null && showPopUp==true) {
        CustomPopUp.showFToast(context, "Appointments Updated");
      }
    });
  }
}

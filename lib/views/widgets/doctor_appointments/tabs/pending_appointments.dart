import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/doctor/doctor_appointments.dart';
import 'package:kaustubha_medtech/models/appointments/appointment_info.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/constants/asset_urls.dart';
import '../../../../utils/constants/constants.dart';
import '../../../alerts/book_appointment.dart';
class DoctorPendingAppointments extends StatefulWidget {
  const DoctorPendingAppointments({super.key});

  @override
  State<DoctorPendingAppointments> createState() => _DoctorPendingAppointmentsState();
}

class _DoctorPendingAppointmentsState extends State<DoctorPendingAppointments> {
  int? _confirmIndex;

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
      child: Consumer<DoctorAppointmentProvider>(
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

  Widget appointmentCard(AppointmentInfo appointmentInfo,DoctorAppointmentProvider provider,int index){
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
                      Row(
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                Icon(Icons.person,color: Colors.grey,size: 16.sp,),
                                SizedBox(width: 4.w,),
                                Text("${appointmentInfo.age ?? ""}",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.w,),
                          SizedBox(
                            child: Row(
                              children: [
                                Icon(Icons.male,color: Colors.grey,size: 16.sp,),
                                SizedBox(width: 4.w,),
                                Text((appointmentInfo.gender ?? "").toUpperCase(),style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54),),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(20.sp)
                        ),
                        padding: EdgeInsets.all(8.sp),
                        child:
                        Text("Pending",style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color:Colors.white),),
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
                  _confirmIndex=index;
                  setState(() {});
                  await provider.confirmAppointment({'userId':appointmentInfo.doctorId,'id':appointmentInfo.id}, (r){
                    if(r.error==null){
                      CustomPopUp.showSnackBar(context, "Successfully Confirmed", Colors.green);
                    }
                  });
                  _confirmIndex=null;
                  setState(() {});
                }, title: "Confirm",width: 1.sw*0.4,height: 40.h,padding:0,borderRadius: BorderRadius.circular(20.sp),loader: provider.confirmLoader && _confirmIndex==index,),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> getAppointments({bool? showPopUp})async{
    final provider= Provider.of<DoctorAppointmentProvider>(context,listen: false);
    await provider.getPendingAppointments((r){
      if(r.success!=null&& r.data!=null && showPopUp==true) {
        CustomPopUp.showFToast(context, "Appointments Updated");
      }
    });
  }
}

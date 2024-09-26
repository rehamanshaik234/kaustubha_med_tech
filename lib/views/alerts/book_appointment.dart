import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/doctor/doctor_appointments.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_appointments.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:provider/provider.dart';
class AppointmentAlert{

  static Future<bool?> showBookedAppointment(BuildContext context,String doctorName, String date,String time)async{
   return await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Column(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFA4CFC3),
                  radius: 40.sp,
                  child: Icon(Icons.check_circle,color: Colors.white,size: 35.sp,),
                ),
                SizedBox(height: 8.h,),
                Text('Congratulations!',style: GoogleFonts.inter(color: AppColors.primaryColor,fontSize: 20.sp,fontWeight: FontWeight.w600),),
              ],
            ),
           content: Text('Your appointment with $doctorName is confirmed for ${Constants.convertDateForEnrollment(date)}, at $time.',
                           style: GoogleFonts.inter(color: Colors.black54,fontSize: 14.sp,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),

            actions: [
              CustomButton(onPressed: ()=>Navigator.pop(context), title: "Go To Home",borderRadius: BorderRadius.circular(25.sp),)
            ],
          );

        });
  }

  static void showCancelAppointment(BuildContext context,String id){
    showDialog(context: context,
        builder: (context){
          return Consumer2<PatientAppointmentProvider,DoctorAppointmentProvider>(
            builder: (context,provider,doctorProvider,_) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(provider.cancelLoader || doctorProvider.cancelLoader ? 'Canceling..':"Cancel",style: GoogleFonts.inter(color: AppColors.primaryColor,fontSize: 20.sp,fontWeight: FontWeight.w600),),
                  ],
                ),
                content:provider.cancelLoader || doctorProvider.cancelLoader?SizedBox(height: 30.h,width: 30.w, child: Center(child: CircularProgressIndicator(color: Colors.black,),)):Text('Are you sure you want to Cancel?',
                  style: GoogleFonts.inter(color: Colors.black54,fontSize: 14.sp,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(onPressed: ()=>Navigator.pop(context), title: "No",borderRadius: BorderRadius.circular(20.sp),height: 30.h,padding: 0,width: 110.w,bgColor: AppColors.buttonSecondaryBgColor,textColor: AppColors.primaryColor,textSize: 14.sp,),
                      CustomButton(onPressed: ()async{
                        Map<String,dynamic> data={'id':int.parse(id)};
                        UserInfo? user=await LocalDB.getUserInfo();
                        if(user?.role==Constants.patientRole) {
                          provider.cancelAppointment(data, (r) {
                            if (r.error == null) {
                              Navigator.pop(context);
                            }
                          });
                        }else{
                          doctorProvider.cancelAppointment(data, (r) {
                            print('doctor');
                            if (r.error == null) {
                              Navigator.pop(context);
                            }
                          });
                        }
                      }, title: "Yes, Cancel",borderRadius: BorderRadius.circular(20.sp),height: 30.h,padding: 0,width: 110.w,textSize: 14.sp,),
                    ],
                  )
                ],
              );
            }
          );

        });
  }
}
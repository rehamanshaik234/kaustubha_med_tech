import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_appointments.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/models/appointments/DoctorDetailsModel.dart';
import 'package:kaustubha_medtech/models/consult/DoctorInfo.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:provider/provider.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({super.key});

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getDoctors();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<PatientAppointmentProvider>(
          builder: (context,provider,_) {
            if(provider.loader){
              return SizedBox(
                 height: 0.7.sh,
                  child: const Center(child: CircularProgressIndicator(color: Colors.black,),));
            }
            if(provider.doctorsList.isEmpty){
              return SizedBox(
                  height: 0.7.sh,
                  child: Center(child: Text("No Doctors Found",style: GoogleFonts.dmSans(fontSize: 16.sp),)));
            }
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.doctorsList.length,
                itemBuilder: (context,index){
                  return doctorCard(provider.doctorsList[index],index);
                });
          }
        ),
        SizedBox(height: 60.h,)
      ],
    );
  }

  Widget doctorCard(DoctorDetailsModel doctorDet, int index){
    return Container(
      margin: index==(index+1)? EdgeInsets.only(bottom: 50.h):EdgeInsets.zero,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: InkWell(
        onTap: ()=>Navigator.of(context,rootNavigator: true).pushNamed(RoutesName.patientDoctorDetails,arguments: {"doctor_id":doctorDet.id}),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                 borderRadius: BorderRadius.circular(8.sp),
              child: Image(image:doctorDet.image!=null?NetworkImage(doctorDet.image): AssetImage(AssetUrls.doctorProfile),
                      height: 100.h,width: 100.w,fit: BoxFit.cover,)),
                SizedBox(width: 8.w,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(doctorDet.profile?.legalName ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16.sp),),
                          Icon(CupertinoIcons.heart,color: Colors.grey,size: 20.sp,)
                        ],
                      ),
                      SizedBox(height: 8.h,),
                      Divider(color: Colors.grey.shade400,height: 2.h,),
                      SizedBox(height: 4.h,),
                      Text(doctorDet.profile?.specialization ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                      SizedBox(height: 4.h,),
                      Text("₹ ${doctorDet.profile?.consultationFees ?? "0"}" ,style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54),),
                      SizedBox(height: 4.h,),
                      Row(
                        children: [
                          Icon(Icons.star,color: AppColors.ratingColor,size: 20.sp,),
                          SizedBox(width: 2.w,),
                          Text(doctorDet.profile?.experienceYears ?? "0" ,style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54),),
                          SizedBox(width: 8.w,),
                          Container(height: 10.h,width: 1.w,color: Colors.grey,),
                          SizedBox(width: 8.w,),
                          Icon(Icons.location_on_outlined,color: Colors.grey,size: 16.sp,),
                          Expanded(child: Text(doctorDet.profile?.address ?? "",style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Colors.black54,),overflow: TextOverflow.ellipsis,)),
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

  void getDoctors(){
    PatientAppointmentProvider provider=Provider.of<PatientAppointmentProvider>(context,listen: false);
    if(provider.doctorsList.isEmpty){
      provider.getDoctorsList((r){});
    }
  }

}

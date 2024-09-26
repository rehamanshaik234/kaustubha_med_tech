import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_appointments.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_colors/app_colors.dart';
class DoctorFilterOptions extends StatefulWidget {
  const DoctorFilterOptions({super.key});

  @override
  State<DoctorFilterOptions> createState() => _DoctorFilterOptionsState();
}

class _DoctorFilterOptionsState extends State<DoctorFilterOptions> {
  List<String> specialistTypes=["   All   ",...Constants.specialisations];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Consumer<PatientAppointmentProvider>(
        builder: (context,provider,child) {
          return Padding(
            padding: EdgeInsets.only(left: 8.0.w,top: 0.w,bottom: 8.h),
            child: Row(
              children: [
                for(int i=0;i<specialistTypes.length;i++)
                  optionContainer(specialistTypes[i], i,provider.filterModel.specialization==null?specialistTypes[0]:
                  provider.filterModel.specialization.toString(),provider)
              ],
            ),
          );
        }
      ),
    );
  }

  Widget optionContainer(String title,int index,String selectedOption,PatientAppointmentProvider provider){
    return GestureDetector(
      onTap: (){
        if(title==specialistTypes[0]){
          provider.setFilter(resetSpecialization: true);
        }else{
          provider.setFilter(specialization: title);
        }
        provider.getDoctorsList(applyFilter: true,(r){});
      },
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
            color: selectedOption==title? AppColors.primaryColor:Colors.white,
            borderRadius: BorderRadius.circular(20.sp),
            border: Border.all(color: AppColors.primaryColor)
        ),
        child: Text(title,style: GoogleFonts.dmSans(fontWeight: FontWeight.w600,color:selectedOption==title?Colors.white:AppColors.primaryColor,fontSize: 14.sp),),
      ),
    );
  }
}

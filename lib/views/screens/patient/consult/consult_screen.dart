import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_appointments.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/models/appointments/DoctorFilterModel.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/views/widgets/consult_widgets/doctor_filter_options.dart';
import 'package:kaustubha_medtech/views/widgets/consult_widgets/doctors_list.dart';
import 'package:kaustubha_medtech/views/widgets/custom_filter_drawer.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
class ConsultScreen extends StatefulWidget {
  const ConsultScreen({super.key});

  @override
  State<ConsultScreen> createState() => _ConsultScreenState();
}

class _ConsultScreenState extends State<ConsultScreen> {
  GlobalKey<ScaffoldState> drawerKey=GlobalKey<ScaffoldState>();
  DoctorFilterModel prevFilter=DoctorFilterModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBgColor,
        leading: InkWell(onTap: ()=>Navigator.pop(context), child: Icon(Icons.arrow_back,color: Colors.black,size: 20.sp,)),
        title: Text("All Doctors",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),),
        centerTitle: true,
        actions: [Container()],
      ),
      endDrawer: CustomFilterDrawer(),
      onEndDrawerChanged: onChangeDrawer,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0.w,right: 12.w,bottom: 8.w,top: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    color: Colors.white,
                    child: Row(
                      children: [
                        SizedBox(width: 8.w),
                        Icon(Icons.search, color: Colors.grey, size: 20.sp),
                        SizedBox(width: 8.w),
                        SizedBox(
                          width: 0.7.sw,
                          child: TextField(
                            onChanged: (val){
                              PatientAppointmentProvider provider=context.read<PatientAppointmentProvider>();
                                provider.setSearchedList(val);
                            },
                            decoration: InputDecoration(
                              hintText: "Search Doctor..",
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.inter(color: Colors.grey, fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer<PatientAppointmentProvider>(
                    builder: (context,provider,child) {
                      DoctorFilterModel filter=provider.filterModel;
                      bool isApplyFilter= filter.city!=null || filter.state!=null || filter.country!=null ||
                          filter.experienceYears!=null || filter.specialization!=null || filter.qualification!=null;
                      return InkWell(
                          onTap: ()=>drawerKey.currentState?.openEndDrawer(),
                          child: Container(
                              decoration: BoxDecoration(
                                color: isApplyFilter?AppColors.primaryColor:Colors.transparent,
                                borderRadius: BorderRadius.circular(20.sp)
                              ),
                              padding: EdgeInsets.all(8.sp),
                              child: Icon(Icons.filter_alt_outlined,color:isApplyFilter?Colors.white:Colors.black54,size: 30.sp,)));
                    }
                  ),
                ],
              ),
            ),
            const DoctorFilterOptions(),
            DoctorsList(),
          ],
        ),
      ),
    );
  }

  void onChangeDrawer(bool? val){
    PatientAppointmentProvider provider=Provider.of<PatientAppointmentProvider>(context,listen: false);
    if(val==true){
      prevFilter=provider.filterModel;
      setState(() {});
    }if(val==false){
      DoctorFilterModel currentFilter=provider.filterModel;
      bool isChangFilter= prevFilter.city!=currentFilter.city || prevFilter.country!=currentFilter.country || prevFilter.state!=currentFilter.state ||
          prevFilter.specialization!=currentFilter.specialization || prevFilter.qualification!=currentFilter.qualification ||
          prevFilter.experienceYears!=currentFilter.experienceYears;
      if(isChangFilter) {
        provider.getDoctorsList(applyFilter: true, (r) {});
      }
    }
  }
}

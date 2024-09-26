import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/forms/doctor_calendar_details.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/forms/doctor_official_details.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/forms/doctor_personal_details.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/enroll_stepper.dart';

class DoctorEnrollmentScreen extends StatefulWidget {
  const DoctorEnrollmentScreen({super.key});

  @override
  State<DoctorEnrollmentScreen> createState() => _DoctorEnrollmentScreenState();
}

class _DoctorEnrollmentScreenState extends State<DoctorEnrollmentScreen> with SingleTickerProviderStateMixin{
  late PageController controller;
  GlobalKey<DoctorOfficialDetailsState> key=GlobalKey<DoctorOfficialDetailsState>();

  int currentPage=0;
  @override
  void initState() {
    controller=PageController(initialPage: 0);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('Doctor Enrollment',style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,
            fontSize: 20.sp),),
        bottom: PreferredSize(preferredSize: Size(1.sw, 40.h), child: EnrollStepper(currentIndex: currentPage,onTap: navToPage,)),
      ),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: PageView(
            onPageChanged: (page){
              currentPage=page;
              setState(() {

              });
            },
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: [
                   DoctorPersonalDetails(),
                   DoctorOfficialDetails(validFields: (val){},key: key,),
                   DoctorTimingSlotsDetails(),
               ]
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(left:16.sp,bottom:24.h,right: 16.w),
        child: CustomButton(onPressed: validateFields, title: 'Next'),
      ),
    );
  }

  void validateFields(){
    if (currentPage == 1) { // If on DoctorOfficialDetails page
      bool isValid = key.currentState?.validateFields() ?? false;
      if (isValid) {
        // Navigate to next page
        changePage(currentPage + 1);
      }
    }
  }

  void changePage(int page){
    if(page<2){
      controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }else{
      controller.animateToPage(0,duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }
  void navToPage(int page){
    controller.animateToPage(page, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/doctor_personal_details.dart';

class DoctorEnrollmentScreen extends StatefulWidget {
  const DoctorEnrollmentScreen({super.key});

  @override
  State<DoctorEnrollmentScreen> createState() => _DoctorEnrollmentScreenState();
}

class _DoctorEnrollmentScreenState extends State<DoctorEnrollmentScreen> with SingleTickerProviderStateMixin{
  late PageController controller;

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
        elevation: 0,
        leading: null,
        title: Text('Doctor Enrollment',style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,
            fontSize: 20.sp),),
      ),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: [
                   DoctorPersonalDetails(),
                   DoctorPersonalDetails(),
                   DoctorPersonalDetails(),
               ]
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(left:16.sp,bottom:24.h,right: 16.w),
        child: CustomButton(onPressed: (){
          if(controller.page!<2){
            controller.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          }else{
            // controller.animateToPage(0,duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          }
        }, title: 'Next'),
      ),
    );
  }
}

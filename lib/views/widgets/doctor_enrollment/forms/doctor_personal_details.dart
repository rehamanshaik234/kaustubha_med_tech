import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/enroll_form_field.dart';
class DoctorPersonalDetails extends StatelessWidget {
  DoctorPersonalDetails({super.key});
  TextEditingController email=TextEditingController();
  TextEditingController countryCode=TextEditingController();
  TextEditingController number=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: Column(
        children: [
          EnrollFormField(controller: email, title: "Enter Your Primary Email", hint: 'Enter Email'),
          EnrollFormField(controller: number, title: "Phone Number", hint: 'Enter Number'),
        ],
      ),
    );
  }

  
}

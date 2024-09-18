import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/views/widgets/consult_widgets/doctor_filter_options.dart';
import 'package:kaustubha_medtech/views/widgets/consult_widgets/doctors_list.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
class ConsultScreen extends StatefulWidget {
  const ConsultScreen({super.key});

  @override
  State<ConsultScreen> createState() => _ConsultScreenState();
}

class _ConsultScreenState extends State<ConsultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBgColor,
        leading: InkWell(onTap: ()=>Navigator.pop(context), child: Icon(Icons.arrow_back,color: Colors.black,size: 20.sp,)),
        title: Text("All Doctors",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0.w,right: 12.w,bottom: 8.w,top: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.white,
                    child: Row(
                      children: [
                        SizedBox(width: 8.w,),
                        Icon(Icons.search,color: Colors.grey,size: 20.sp,),
                        SizedBox(width: 8.w,),
                        SizedBox(
                          width: 1.sw*0.7,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search Doctor..",
                              border: InputBorder.none,
                              hintStyle:GoogleFonts.inter(color: Colors.grey,fontSize: 14.sp)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w,),
                  Icon(Icons.filter_alt_outlined,color: Colors.black54,size: 30.sp,),
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
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_appointments.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_outline_button.dart';
import 'package:kaustubha_medtech/views/widgets/filter_dropdowns/city_dropdown.dart';
import 'package:kaustubha_medtech/views/widgets/filter_dropdowns/country_dropdown.dart';
import 'package:kaustubha_medtech/views/widgets/filter_dropdowns/experience_dropdown.dart';
import 'package:kaustubha_medtech/views/widgets/filter_dropdowns/qualification_dropdown.dart';
import 'package:kaustubha_medtech/views/widgets/filter_dropdowns/specializations_dropdown.dart';
import 'package:provider/provider.dart';

class CustomFilterDrawer extends StatefulWidget {
  CustomFilterDrawer({super.key});

  @override
  State<CustomFilterDrawer> createState() => _CustomFilterDrawerState();
}

class _CustomFilterDrawerState extends State<CustomFilterDrawer> {

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientAppointmentProvider>(
      builder: (context,provider,child) {
        return Drawer(
          child: Padding(
            padding: EdgeInsets.all(12.sp),
            child: SizedBox(
              height: 0.7.sh,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: ()=>Navigator.pop(context),
                            child: Icon(Icons.close,size: 40.sp,))
                      ],
                    ),
                    CitiesDropdown(),
                    SpecialisationsDropdown(),
                    ExperienceDropdown(),
                    QualificationDropdown(),
                    SizedBox(height: 16.h,),
                    CustomButton(onPressed: (){
                      if(provider.filterModel.toJson().isNotEmpty) {
                        provider.getDoctorsList(applyFilter: true, (r) {});
                      }
                      Navigator.pop(context);
                    }, title: "Apply Filter"),
                    SizedBox(height: 16.h,),
                    CustomOutlineButton(onPressed: (){
                      if(provider.filterModel.toJson().isNotEmpty) {
                        provider.setFilter(resetQualification: true,
                            resetCountry: true,
                            resetExp: true,
                            resetSpecialization: true,
                            resetCity: true,resetState: true);
                        provider.getDoctorsList(applyFilter: false, (r) {});
                      }
                      Navigator.pop(context);
                    }, title: "Clear All"),
                    SizedBox(height: 100.h,),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

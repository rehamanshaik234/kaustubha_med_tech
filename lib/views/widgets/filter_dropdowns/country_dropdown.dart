import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_appointments.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:provider/provider.dart';

class CountriesDropdown extends StatefulWidget {
  double? width;

  CountriesDropdown({super.key,this.width});

  @override
  State<CountriesDropdown> createState() => _CountriesDropdownState();
}

class _CountriesDropdownState extends State<CountriesDropdown> {
  final List<String> countries = ["IN", "US","UK","AU","RS","PK"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Country",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 14.sp),),
        SizedBox(height: 8.h,),
        Consumer<PatientAppointmentProvider>(
          builder: (context,provider,_) {
            List<String> options=countries;
            print(provider.filterModel.country);
            return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal:  12.w,vertical: 4.w),
                  child: SizedBox(
                    height: 40.h,
                    width: widget.width,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton<String>(
                          value: provider.filterModel.country,
                          hint: SizedBox(
                              width: widget.width!=null ? 0.8.sw: null,
                              child: Text('Select Country',style:GoogleFonts.inter(color: Colors.black54),)),
                          borderRadius: BorderRadius.circular(20.sp),
                          items: List.generate(
                                options.length,
                                (index) => DropdownMenuItem(
                              value: options[index],
                              child: Text(
                                options[index],
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value != null) {
                              provider.setFilter(country: value,resetCity: true);
                            }
                          },
                          dropdownColor: Colors.white,
                          underline: Container(),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Visibility(
                          visible: provider.filterModel.country!=null,
                          child: InkWell(
                              onTap: (){
                                provider.setFilter(resetCountry: true);
                              },
                              child: Icon(CupertinoIcons.clear_circled,color: Colors.black,size: 20.sp,)),
                        )
                      ],
                    ),
                  ),
                ),
              );
          }
        ),
        SizedBox(height: 16.h,)
      ],
    );
  }

}

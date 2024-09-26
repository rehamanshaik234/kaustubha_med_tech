import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_appointments.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:provider/provider.dart';

class CitiesDropdown extends StatefulWidget {
  double? width;

  CitiesDropdown({super.key,this.width});

  @override
  State<CitiesDropdown> createState() => _CitiesDropdownState();
}

class _CitiesDropdownState extends State<CitiesDropdown> {
  final List<String> indiaCities = ["Hyderabad", "Mumbai","Bangalore","Chennai","Delhi","Rajasthan","Punjab","Bhopal",];
  final List<String> pakistanCities = [
    "Karachi",
    "Lahore",
    "Islamabad",
    "Rawalpindi",
    "Faisalabad",
    "Peshawar",
    "Multan",
    "Quetta",
  ];
  final List<String> usaCities = [
    "New York",
    "Los Angeles",
    "Chicago",
    "Houston",
    "Phoenix",
    "Philadelphia",
    "San Antonio",
    "San Diego",
  ];
  final List<String> russiaCities = [
    "Moscow",
    "Saint Petersburg",
    "Novosibirsk",
    "Yekaterinburg",
    "Kazan",
    "Nizhny Novgorod",
    "Samara",
    "Omsk",
  ];
  final List<String> ukCities = [
    "London",
    "Manchester",
    "Birmingham",
    "Glasgow",
    "Liverpool",
    "Bristol",
    "Edinburgh",
    "Leeds",
  ];
  final List<String> australiaCities = [
    "Sydney",
    "Melbourne",
    "Brisbane",
    "Perth",
    "Adelaide",
    "Canberra",
    "Hobart",
    "Darwin",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("City",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 14.sp),),
        SizedBox(height: 8.h,),
        Consumer<PatientAppointmentProvider>(
          builder: (context,provider,_) {
            List<String> options=getOptions(provider);

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
                          value: provider.filterModel.city,
                          hint: SizedBox(
                              width: widget.width!=null ? 0.8.sw: null,
                              child: Text('Select City',style:GoogleFonts.inter(color: Colors.black54),)),
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
                              provider.setFilter(city: value);
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
                          visible: provider.filterModel.city!=null,
                          child: InkWell(
                              onTap: (){
                                provider.setFilter(resetCity: true);
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

  List<String> getOptions(PatientAppointmentProvider provider) {
    if(provider.filterModel.country=='IN'){
      return indiaCities;
    }else if(provider.filterModel.country=='PK'){
      return pakistanCities;
    }else if(provider.filterModel.country=='US'){
      return usaCities;
    }else if(provider.filterModel.country=="UK"){
      return ukCities;
    }else if(provider.filterModel.country=='RS'){
      return russiaCities;
    }else if(provider.filterModel.country=="AU"){
      return australiaCities;
    }else{
      return indiaCities;
    }
  }
}

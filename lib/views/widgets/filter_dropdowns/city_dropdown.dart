import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_appointments.dart';
import 'package:provider/provider.dart';

import '../doctor_enrollment/countries_dropdown.dart';

class CitiesDropdown extends StatefulWidget {
  double? width;
  CitiesDropdown({super.key,this.width});

  @override
  State<CitiesDropdown> createState() => _CitiesDropdownState();
}

class _CitiesDropdownState extends State<CitiesDropdown> {
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
        Consumer<PatientAppointmentProvider>(
          builder: (context,provider,child) {
            return Row(
              children: [
                Text("Region",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 14.sp),),
                Visibility(
                  visible: provider.filterModel.country!=null,
                  child: Container(
                    margin:EdgeInsets.only(left: 8.w),
                    child: InkWell(
                        onTap: (){
                          provider.setFilter(resetCity: true,resetState: true,resetCountry: true);
                        },
                        child: Icon(CupertinoIcons.clear_circled,color: Colors.black,size: 20.sp,)),
                  ),
                )
              ],
            );
          }
        ),
        SizedBox(height: 8.h,),
        Consumer<PatientAppointmentProvider>(
          builder: (context,provider,_) {
            return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: Colors.transparent,
                ),
              child: CustomCountriesDropDown(
                countryValue: provider.filterModel.country,
                stateValue: provider.filterModel.state,
                cityValue: provider.filterModel.city,
                onCountrySelect: (val) {
                    provider.setFilter(country: val,resetCity: true,resetState: true);
                },
                onStateSelect: (val) {
                    provider.setFilter(state: val,resetCity: true);
                },
                onCitySelect: (val) {
                    provider.setFilter(city: val);
                },
              )
            );
          }
        ),
        SizedBox(height: 16.h,)
      ],
    );
  }
}

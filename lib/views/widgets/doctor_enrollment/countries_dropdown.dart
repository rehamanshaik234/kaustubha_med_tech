import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomCountriesDropDown extends StatelessWidget {
  CustomCountriesDropDown({Key? key,this.countryValue,this.stateValue,this.cityValue,required this.onCitySelect,required this.onCountrySelect,required this.onStateSelect}) : super(key: key);
  String? countryValue;
  String? stateValue;
  String? cityValue;
  Function(String?) onCountrySelect;
  Function(String?) onStateSelect;
  Function(String?) onCitySelect;

  @override
  Widget build(BuildContext context) {
    return CSCPicker(
      layout: Layout.vertical,
      showStates: true,
      showCities: true,
      flagState: CountryFlag.DISABLE,
      dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.sp)),
          color: Colors.transparent,
          border: Border.all(color: Colors.black, width: 1)
      ),
      disabledDropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.transparent,
          border: Border.all(color: Colors.black, width: 1)),
      countrySearchPlaceholder: "Select Country",
      stateSearchPlaceholder: "Select State",
      citySearchPlaceholder: "Select City",
      countryDropdownLabel: "Country",
      stateDropdownLabel: "State",
      cityDropdownLabel: "City",
      selectedItemStyle: TextStyle(
        color:countryValue!=null? Colors.black: Colors.black54,
        fontWeight: FontWeight.normal,
        height: 2.h,
        fontSize: 16.sp,
      ),
      dropdownHeadingStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold),
      dropdownItemStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp),
      dropdownDialogRadius: 10.0,
      searchBarRadius: 10.0,
      currentCountry: countryValue,
      currentCity: cityValue,
      currentState: stateValue,
      onCountryChanged: (value) {
        onCountrySelect(value);
      },
      onStateChanged: (value) {
        onStateSelect(value);
      },
      onCityChanged: (value) {
        onCitySelect(value);
      },
    );
  }
}
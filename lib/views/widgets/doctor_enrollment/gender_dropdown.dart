import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';

class GenderDropDown extends StatefulWidget {
  Function(String index) onChange;
  String? selectedTab;
  double? width;

  GenderDropDown({super.key, required this.onChange, required this.selectedTab,this.width});

  @override
  State<GenderDropDown> createState() => _GenderDropDownState();
}

class _GenderDropDownState extends State<GenderDropDown> {
  final List<String> options = ["Male", "Female","Others"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gender",style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp),),
        SizedBox(height: 8.h,),
        Container(
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
                child: DropdownButton<String>(
                  value: widget.selectedTab,
                  hint: SizedBox(
                      width: widget.width!=null ? 0.8.sw: null,
                      child: Text('Select Gender',style:GoogleFonts.inter(color: Colors.black54),)),
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
                      widget.onChange(value);
                    }
                  },
                  dropdownColor: Colors.white,
                  underline: Container(),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        SizedBox(height: 16.h,)
      ],
    );
  }
}

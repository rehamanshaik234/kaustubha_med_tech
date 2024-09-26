import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';

class TransactionDateDropdown extends StatefulWidget {
  Function(int index) onChange;
  int selectedTab;
  String? selectedValue;

  TransactionDateDropdown({super.key, required this.onChange, required this.selectedTab,this.selectedValue});

  @override
  State<TransactionDateDropdown> createState() => _TransactionDateDropdownState();
}

class _TransactionDateDropdownState extends State<TransactionDateDropdown> {
  final List<String> options = ["All","Today", "Yesterday", "Select Date"];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:  12.w,vertical: 4.w),
        child: SizedBox(
          height: 30.h,
          child: DropdownButton<int>(
            value: widget.selectedTab,
            borderRadius: BorderRadius.circular(20.sp),
            items: List.generate(
              options.length,
                  (index) => DropdownMenuItem(
                value: index + 1,
                child: Row(
                  children: [
                    Text(
                     options[index],
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                    ),
                    Visibility(
                        visible: index==3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Icon(Icons.calendar_month,color: Colors.black54,size: 16.sp,),
                        ))
                  ],
                ),
              ),
            ),
            onChanged: (value) {
              if (value != null) {
                widget.onChange(value);
                setState(() {
                  widget.selectedTab = value;
                });
              }
            },
            dropdownColor: Colors.white,
            underline: Container(),
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

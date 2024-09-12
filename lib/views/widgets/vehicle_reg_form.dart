import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';

class VehicleRegForm extends StatelessWidget {
  VehicleRegForm({super.key,required this.controllersList});
  List<TextEditingController> controllersList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
         width: 1.sw,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Vehicle Details',style: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w500),),
                SizedBox(height: 8.h,),
                TextField(
                  controller: controllersList[0],
                  decoration: InputDecoration(
                      hintText: "Vehicle Number",
                      focusColor: Colors.black,
                      hintStyle: GoogleFonts.inter(color: Colors.black54),
                      hoverColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(40),
                      ),
                  ),
                ),
                SizedBox(height: 8.h,),
                TextField(
                  controller: controllersList[1],
                  decoration: InputDecoration(
                      hintText: "Vehicle Type",
                      focusColor: Colors.black,
                      hintStyle: GoogleFonts.inter(color: Colors.black54),
                      hoverColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(40),
                      ),
                  ),
                ),
                SizedBox(height: 8.h,),
                TextField(
                  controller: controllersList[2],
                  decoration: InputDecoration(
                      hintText: "Vehicle Name",
                      focusColor: Colors.black,
                      hintStyle: GoogleFonts.inter(color: Colors.black54),
                      hoverColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(40),
                      ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

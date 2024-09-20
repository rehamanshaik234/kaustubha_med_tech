import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/views/alerts/book_appointment.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/routes/route_names.dart';
import '../../../../widgets/custom_button.dart';
class RescheduleAppointment extends StatefulWidget {
  const RescheduleAppointment({super.key});

  @override
  State<RescheduleAppointment> createState() => _RescheduleAppointmentState();
}

class _RescheduleAppointmentState extends State<RescheduleAppointment> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldBgColor,
        leading: InkWell(onTap: ()=>Navigator.pop(context), child: Icon(Icons.arrow_back,color: Colors.black,size: 20.sp,)),
        title: Text("Reschedule",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Date",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 20.sp,color: AppColors.primaryColor),),
            SizedBox(height: 8.h,),
            Card(
              color: Colors.white,
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.primaryColor, // This will be the color for the selected date
                    onPrimary: Colors.white, // Text color on selected date
                    onSurface: Colors.black, // Color for unselected dates
                  ),
                ),
                child: CalendarDatePicker(
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  onDateChanged: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16.h,),
            Text("Select Hours",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 20.sp,color: AppColors.primaryColor),),
            SizedBox(height: 8.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 8.h),
                    child: Text("09.00 AM",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 8.h),
                    child: Text("09.00 AM",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 8.h),
                    child: Text("09.00 AM",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 8.h),
                    child: Text("09.00 AM",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 8.h),
                    child: Text("09.00 AM",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 8.h),
                    child: Text("09.00 AM",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 8.h),
                    child: Text("09.00 AM",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 8.h),
                    child: Text("09.00 AM",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 8.h),
                    child: Text("09.00 AM",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.black54),),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h,),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(16.sp),
        child: CustomButton(onPressed: (){
          AppointmentAlert.showBookedAppointment(context);
        }, title: "Confirm",borderRadius: BorderRadius.circular(25.sp),),
      ),
    );
  }
}

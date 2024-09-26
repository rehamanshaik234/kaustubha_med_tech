import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_appointments.dart';
import 'package:kaustubha_medtech/models/appointments/DoctorAvailableTimeSlots.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/routes/route_names.dart';
import '../../../../widgets/custom_button.dart';
class AppointmentTimeSlot extends StatefulWidget {
  const AppointmentTimeSlot({super.key});

  @override
  State<AppointmentTimeSlot> createState() => _AppointmentTimeSlotState();
}

class _AppointmentTimeSlotState extends State<AppointmentTimeSlot> {
  DateTime? _selectedDate;
  String selectedSlot='';
  List<String> availableSlots=[];
  Set<int> allowedWeekdaysSet={};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getDates();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldBgColor,
        leading: InkWell(onTap: ()=>Navigator.pop(context), child: Icon(Icons.arrow_back,color: Colors.black,size: 20.sp,)),
        title: Text("Book Appointment",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),),
        centerTitle: true,
      ),
      body: Consumer<PatientAppointmentProvider>(
        builder: (context,provider,child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 1.sw,
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
                      child: _selectedDate!=null? CalendarDatePicker(
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        selectableDayPredicate:(DateTime date)=> allowedWeekdaysSet.contains(_selectedDate?.weekday)? allowedWeekdaysSet.contains(date.weekday):true,
                        onDateChanged: (newDate) {
                          setState(() {
                            _selectedDate = newDate;
                            getAvailableSlots();
                          });
                        },
                      ):SizedBox(height: 200.h,child: CircularProgressIndicator(color: Colors.black,),),
                    ),
                  ),
                  SizedBox(height: 16.h,),
                  Text("Select Time",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 20.sp,color: AppColors.primaryColor),),
                  SizedBox(height: 8.h,),
                  !provider.loader?
                  SizedBox(
                    width: 1.sw,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 12.w,                  // Space between items horizontally
                      runSpacing: 8.0.h,
                      children: [
                        for(int i=0;i<availableSlots.length ;i++)
                          InkWell(
                            onTap: (){
                              selectedSlot=availableSlots[i];
                              setState(() {

                              });
                            },
                            child: SizedBox(
                              child: Card(
                                color: selectedSlot== availableSlots[i]? AppColors.primaryColor:Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 8.h),
                                  child: Text(availableSlots[i],style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,color:selectedSlot== availableSlots[i]?Colors.white: Colors.black54),),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ):SizedBox(
                    height: 100.h,
                    width: 1.sw,
                    child: Center(child: CircularProgressIndicator(color: Colors.black,),)
                  ),
                  SizedBox(height: 8.h,),
                ],
              ),
            ),
          );
        }
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(16.sp),
        child: CustomButton(onPressed: (){
          if(selectedSlot.isEmpty){
            CustomPopUp.showSnackBar(context, "Select Time", Colors.redAccent);
          }else{
            Navigator.pushNamed(context, RoutesName.bookAppointment,arguments: {'date':_selectedDate.toString(),'slot':selectedSlot});
          }
        }, title: "Confirm",borderRadius: BorderRadius.circular(25.sp),),
      ),
    );
  }

  void getAvailableSlots()async{
    Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
    PatientAppointmentProvider provider=Provider.of<PatientAppointmentProvider>(context,listen: false);
    if(data!=null){
      availableSlots.clear();
      String id =data['doctor_id'];
      await provider.getDoctorAvailableSlots(_selectedDate.toString().substring(0,10), id, (r){
          List<String> totalSlots=provider.doctorDetails.availability?.availableTimeSlot ?? [];
          List<DoctorAvailableTimeSlots> bookedSlots=provider.doctorTimeSlots ??[];
          for (int i = 0; i < totalSlots.length; i++) {
            bool isBooked = false;
            for (int j = 0; j < bookedSlots.length; j++) {
              if (bookedSlots[j].time == totalSlots[i]) {
                isBooked = true;
                break;
              }
            }
            if (!isBooked && !availableSlots.contains(totalSlots[i])) {
              availableSlots.add(totalSlots[i]);
            }
          }
          selectedSlot='';
          setState(() {});
      });
    }
  }

   getDates(){
    PatientAppointmentProvider provider=Provider.of<PatientAppointmentProvider>(context,listen: false);
    List<String> days = provider.doctorDetails.availability?.availableDays ?? [];
    Map<String, int> weekdayMap = {
      'Mon': DateTime.monday,
      'Tue': DateTime.tuesday,
      'Wed': DateTime.wednesday,
      'Thu': DateTime.thursday,
      'Fri': DateTime.friday,
      'Sat': DateTime.saturday,
      'Sun': DateTime.sunday,
    };
     allowedWeekdaysSet = days.map((day) => weekdayMap[day]!).toSet();
     _selectedDate=DateTime.now();
     if(!allowedWeekdaysSet.contains(_selectedDate?.weekday)){
      _selectedDate=_findNextValidDate(_selectedDate!, allowedWeekdaysSet);
     }
     setState(() {});
     getAvailableSlots();
  }


  DateTime _findNextValidDate(DateTime startDate, Set<int> allowedDays) {
    while (!allowedDays.contains(startDate.weekday)) {
      startDate = startDate.add(const Duration(days: 1));
    }
    return startDate;
  }
}

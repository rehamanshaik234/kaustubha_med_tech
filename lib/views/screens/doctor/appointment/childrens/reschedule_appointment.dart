import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/doctor/doctor_appointments.dart';
import 'package:provider/provider.dart';

import '../../../../../controller/providers/patient/patient_appointments.dart';
import '../../../../../models/appointments/DoctorAvailableTimeSlots.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/routes/route_names.dart';
import '../../../../alerts/custom_alerts.dart';
import '../../../../widgets/custom_button.dart';

class DoctorRescheduleAppointment extends StatefulWidget {
  const DoctorRescheduleAppointment({super.key});

  @override
  State<DoctorRescheduleAppointment> createState() => _DoctorRescheduleAppointmentState();
}

class _DoctorRescheduleAppointmentState extends State<DoctorRescheduleAppointment> {
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
        title: Text("Reschedule Appointment",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),),
        centerTitle: true,
      ),
      body: Consumer<DoctorAppointmentProvider>(
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
                    Text("Select Hours",style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 20.sp,color: AppColors.primaryColor),),
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
                        child: const Center(child: CircularProgressIndicator(color: Colors.black,),)
                    ),
                    SizedBox(height: 8.h,),
                  ],
                ),
              ),
            );
          }
      ),
      bottomSheet: Consumer<DoctorAppointmentProvider>(
        builder: (context,provider,_) {
          return Padding(
            padding: EdgeInsets.all(16.sp),
            child: CustomButton(onPressed: (){
              Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
              if(selectedSlot.isEmpty){
                CustomPopUp.showSnackBar(context, "Select Hours", Colors.redAccent);
              }else{
                if(data!=null){
                  int id=data['id'];
                  String? convertedDate=_selectedDate?.toIso8601String();
                  Map<String,dynamic> params={'id':id,'date':convertedDate?.contains('Z')==true?'$convertedDate':'${convertedDate}Z',"time":selectedSlot};
                  print(params);
                  provider.rescheduleAppointment(params, (r){
                    if(r.error==null){
                      CustomPopUp.showSnackBar(context, "Successfully Re-Scheduled", Colors.green);
                      Navigator.of(context).pop();
                    }
                  });
                }
              }
            }, title: "Confirm",borderRadius: BorderRadius.circular(25.sp),loader: provider.rescheduleLoader,),
          );
        }
      ),
    );
  }

  void getAvailableSlots()async{
    Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
    DoctorAppointmentProvider provider=Provider.of<DoctorAppointmentProvider>(context,listen: false);
    if(data!=null){
      print(data.toString());
      availableSlots.clear();
      String id =data['doctor_id'].toString();
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

  void getDates(){
    DoctorAppointmentProvider provider=Provider.of<DoctorAppointmentProvider>(context,listen: false);
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
    Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
    if(data!=null){
      _selectedDate=DateTime.parse(data['date']);
      selectedSlot=data['slot'];
    }
    if(_selectedDate!.isBefore(DateTime.now())){
      _selectedDate=DateTime.now();
    }
    setState(() {});
    getAvailableSlots();
  }
}

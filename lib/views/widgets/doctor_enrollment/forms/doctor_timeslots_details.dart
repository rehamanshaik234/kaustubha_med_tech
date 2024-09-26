import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/doctor_enrollment/doctor_enrollment.dart';
import 'package:kaustubha_medtech/models/appointments/DoctorDetailsModel.dart';
import 'package:kaustubha_medtech/models/doctor_enrollment/DoctorTImeSlotsModel.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/enroll_form_field.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/available_times.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/languages_form.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/starttime_dropdown.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/weeks_form.dart';
import 'package:provider/provider.dart';
class DoctorTimingSlotsDetails extends StatefulWidget {
  DoctorTimingSlotsDetails({super.key,this.doctorDetails});
  DoctorDetailsModel? doctorDetails;

  @override
  State<DoctorTimingSlotsDetails> createState() => DoctorTimingSlotsDetailsState();
}

class DoctorTimingSlotsDetailsState extends State<DoctorTimingSlotsDetails> with AutomaticKeepAliveClientMixin {

  TextEditingController sessionLength=TextEditingController();

  TextEditingController sessionAmount=TextEditingController();

  int? selectedStartIndex;

  List<String> selectedSessions=[];

  List<String> selectedWeeks=[];
  List<String> selectedLanguages=[];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      checkIsUpdate();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: SingleChildScrollView(
        child: Column(
          children: [
            StartTimeDropDown(onChange: (i){
              selectedStartIndex=i;
              setState(() {});
             }, selectedTab: selectedStartIndex),
            Visibility(
              visible: selectedStartIndex!=null,
              child: AvailableTimes(index: selectedStartIndex ?? 0,sessions: selectedSessions,onAdd: (val){
                if(!selectedSessions.contains(Constants.timings[val])){
                  selectedSessions.add(Constants.timings[val]);
                  setState(() {});
                }
              },remove: (val){
                if(selectedSessions.contains(Constants.timings[val])){
                  selectedSessions.remove(Constants.timings[val]);
                  setState(() {});
                }
              },),
            ),
            WeeksForm(onSelect: (week){
              if(!selectedWeeks.contains(week)){
                selectedWeeks.add(week);
              }else{
                selectedWeeks.remove(week);
              }
              setState(() {});
            },selectedWeeks: selectedWeeks,),
            LanguagesForm(onSelect: (lang){
              if(!selectedLanguages.contains(lang)){
                selectedLanguages.add(lang);
              }else{
                selectedLanguages.remove(lang);
              }
              setState(() {});
            },selectedLanguages: selectedLanguages,),
            EnrollFormField(controller: sessionAmount, title: "Amount Per Session", hint: 'Enter Amount',inputType: TextInputType.number,),
            EnrollFormField(controller: sessionLength, title: "Session Length", hint: 'Enter in Minutes',inputType: TextInputType.number,),
            SizedBox(height: 60.h,)
          ],
        ),
      ),
    );
  }

  bool validateFields(){
    if(selectedStartIndex==null){
      CustomPopUp.showSnackBar(context, "Select Start Time", Colors.redAccent);
      return false;
    }
    if(selectedSessions.isEmpty){
      CustomPopUp.showSnackBar(context, "Select Available Timings", Colors.redAccent);
      return false;
    }
    if(selectedWeeks.isEmpty){
      CustomPopUp.showSnackBar(context, "Select Week Days", Colors.redAccent);
      return false;
    }
    if(selectedLanguages.isEmpty){
      CustomPopUp.showSnackBar(context, "Select Language", Colors.redAccent);
      return false;
    }
    if(sessionAmount.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Enter Session Fee", Colors.redAccent);
      return false;
    }
    if(sessionLength.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Enter Session Length", Colors.redAccent);
      return false;
    }
    DoctorEnrollmentProvider provider=Provider.of<DoctorEnrollmentProvider>(context,listen: false);
    provider.setTimeSlotsDet(DoctorTImeSlotsModel(availableTimeFrom: Constants.timings[selectedStartIndex ?? 0],availableTimeSlot: removeUnSelectedTimings(),availableDays: selectedWeeks,
    sessionFees: sessionAmount.text,sessionLength: sessionLength.text,languages: selectedLanguages));
    return true;
  }


  List<String> removeUnSelectedTimings(){
    List<String> selectedData=[...selectedSessions];
    int limitIndex=selectedStartIndex ?? 0;
    for(int i=0;i<limitIndex;i++){
      if(selectedData.contains(Constants.timings[i])){
        selectedData.remove(Constants.timings[i]);
      }
    }
    return selectedData;
  }

  void checkIsUpdate(){
    if(widget.doctorDetails!=null){
       Availability availability= widget.doctorDetails?.availability ?? Availability();
       selectedStartIndex=Constants.timings.contains(availability.availableTimeFrom)?Constants.timings.indexOf(availability.availableTimeFrom.toString()):null;
       selectedSessions.addAll(availability.availableTimeSlot?? []);
       selectedWeeks.addAll(availability.availableDays?? []);
       selectedLanguages.addAll(availability.languages?? []);
       sessionAmount.text=availability.sessionFees ?? "";
       sessionLength.text=availability.sessionLength ?? "";
       setState(() {});
    }
  }
}

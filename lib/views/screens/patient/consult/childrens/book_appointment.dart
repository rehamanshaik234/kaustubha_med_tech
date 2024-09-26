import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_appointments.dart';
import 'package:kaustubha_medtech/models/appointments/DoctorDetailsModel.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/views/alerts/book_appointment.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_enrollment/gender_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/routes/route_names.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/doctor_enrollment/enroll_form_field.dart';
class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  int score=0;
  String selectedDate ='';
  String selectedSlot='';
  TextEditingController purpose=TextEditingController();
  TextEditingController patientName=TextEditingController();
  TextEditingController patientAge=TextEditingController();
  String? gender;
  Razorpay razorpay= Razorpay();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getSelectedSlot();
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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
        title: Text("Appointment Purpose",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),),
        centerTitle: true,
      ),
      body: Consumer<PatientAppointmentProvider>(
        builder: (context,provider,child) {
          Profile? doctorProfile = provider.doctorDetails.profile;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: AppColors.primaryColor,
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(doctorProfile?.legalName ?? "",style: GoogleFonts.dmSans(fontWeight: FontWeight.w600,fontSize: 16.sp,color: Colors.white),),
                            SizedBox(child: Row(
                              children: [
                                Text("₹ ${doctorProfile?.consultationFees ?? ''}",style: GoogleFonts.openSans(fontWeight: FontWeight.w600,fontSize: 20.sp,color: Colors.white),),
                                Text(" Fees",style: GoogleFonts.openSans(fontWeight: FontWeight.w600,fontSize: 14.sp,color: Colors.white),),
                              ],
                            ))
                          ],
                        ),
                        Text("${doctorProfile?.specialization ?? ''} • ${doctorProfile?.experienceYears ??""} years Exp.",style: GoogleFonts.dmSans(fontWeight: FontWeight.normal,fontSize: 14.sp,color: Colors.white70),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(selectedDate,style: GoogleFonts.dmSans(fontWeight: FontWeight.normal,fontSize: 14.sp,color: Colors.white70),),
                            Text(selectedSlot,style: GoogleFonts.dmSans(fontWeight: FontWeight.normal,fontSize: 14.sp,color: Colors.white70),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h,),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h,),
                        EnrollFormField(
                          controller: purpose,
                          titleFontWight: FontWeight.w600,
                          includeSpacing: true,
                          title: "Describe the Purpose of the consultation in details",
                          hint: 'Hello Doctor, I want to consult with you because..',
                          maxLines: 3,
                        ),
                      SizedBox(height: 16.h,),
                      Text("Patient Details*",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp)),
                        SizedBox(height: 8.h,),
                      EnrollFormField(
                          controller: patientName,
                          titleFontWight: FontWeight.w600,
                          title: "Name",
                          includeSpacing: true,
                          hint: 'Enter Name',
                        ),
                        EnrollFormField(
                          controller: patientAge,
                          titleFontWight: FontWeight.w600,
                          title: "Age",
                          inputType: TextInputType.number,
                          hint: 'Enter Age',
                        ),
                        GenderDropDown(onChange: (a){
                          setState(() {
                            gender=a;
                          });
                        }, selectedTab: gender,width: 1 .sw,),
                        SizedBox(
                          height: 60.h,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
      bottomSheet: Consumer<PatientAppointmentProvider>(
        builder: (context,provider,child) {
          return Padding(
            padding: EdgeInsets.only(left: 16.sp,right: 16.sp,bottom: 24.sp),
            child: CustomButton(onPressed: ()=>payNow(provider), title: "Proceed",borderRadius: BorderRadius.circular(25.sp),
            loader: provider.loader,),
          );
        }
      ),
    );
  }

  bool validateFields(){
    if(purpose.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Enter Purpose", Colors.redAccent);
      return false;
    }
    if(patientName.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Enter Patient Name", Colors.redAccent);
      return false;
    }
    if(patientAge.text.isEmpty){
      CustomPopUp.showSnackBar(context, "Enter Patient Age", Colors.redAccent);
      return false;
    }
    if(gender==null){
      CustomPopUp.showSnackBar(context, "Select Patient Gender", Colors.redAccent);
      return false;
    }
    return true;
  }

  void bookAppointment(PatientAppointmentProvider provider,{String? orderId})async{
    UserInfo? userInfo=await LocalDB.getUserInfo();
    if(validateFields()){
      String convertedDate=DateTime.parse(selectedDate).toIso8601String();
      Map<String,dynamic> data={
        'userId':userInfo?.id,
        'time':selectedSlot,
        'purpose':purpose.text,
        'name':patientName.text,
        'date':"${convertedDate}Z",
        'age':int.parse(patientAge.text),
        'gender':gender?.toLowerCase(),
        'doctor_id':provider.doctorDetails.id,
        'orderId':orderId,
        'amount':int.parse(provider.doctorDetails.profile?.consultationFees ?? '0')
      };
      print(data);
      await provider.bookAppointment(data, (resp)async{
        if(resp.error==null){
          provider.getUpcomingAppointments((r){});
          await AppointmentAlert.showBookedAppointment(context,provider.doctorDetails.profile?.legalName ?? "",selectedDate,selectedSlot);
          Navigator.of(context,rootNavigator: true).pushNamedAndRemoveUntil(RoutesName.patientMain,(r)=>false, arguments: {'route':RoutesName.patientAppointments});
        }else{
          CustomPopUp.showSnackBar(context, resp.error ?? "", Colors.redAccent);
        }
      });
    }
  }

  void getSelectedSlot()async{
    Map? data=ModalRoute.of(context)?.settings.arguments as Map?;
    if(data!=null){
      selectedDate=data['date'].toString().substring(0,10);
      selectedSlot=data['slot'];
      setState(() {});
    }
  }


  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if(response.paymentId!=null){
      print(response.paymentId);
      print(response.orderId);
      bookAppointment(context.read<PatientAppointmentProvider>(),orderId: response.paymentId);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if(response.message!=null){
      CustomPopUp.showSnackBar(context,"Payment Failed", Colors.redAccent);
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if(response.walletName!=null){
      print(response.walletName);
    }
  }

  void payNow(PatientAppointmentProvider provider)async{
    Profile? doctorProfile = provider.doctorDetails.profile;
    UserInfo? userInfo=await LocalDB.getUserInfo();
    if(validateFields()){
      var options = {
        'key': 'rzp_test_6JMClhhOPfO7W1',
        'amount': calculateFee(doctorProfile?.consultationFees),
        'name': patientName.text,
        "currency": "INR",
        'description': doctorProfile?.legalName,
        'prefill': {
          'contact': userInfo?.phone,
          'email': userInfo?.email
        }
      };
      razorpay.open(options);
    }
  }

  double? calculateFee(String? fee){
    if(fee!=null){
      double totalFee=double.parse(fee);
      return totalFee*100;
    }
    return null;
  }
}

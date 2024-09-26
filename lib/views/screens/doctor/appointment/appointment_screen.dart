import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_appointments/appointments_tab_bar.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_appointments/tabs/pending_appointments.dart';
import 'package:kaustubha_medtech/views/widgets/doctor_appointments/tabs/completed_appointments.dart';
import 'package:kaustubha_medtech/views/widgets/patient_appointments/appointments_tab_bar.dart';
import 'package:kaustubha_medtech/views/widgets/patient_appointments/tabs/canceled_appointments.dart';
import 'package:kaustubha_medtech/views/widgets/patient_appointments/tabs/completed_appointments.dart';
import 'package:kaustubha_medtech/views/widgets/patient_appointments/tabs/upcoming_appointments.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../widgets/doctor_appointments/tabs/upcoming_appointments.dart';
class DoctorAppointmentsScreen extends StatefulWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  State<DoctorAppointmentsScreen> createState() => _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends State<DoctorAppointmentsScreen> with SingleTickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    tabController=TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_){
      tabController.addListener(onChangeTab);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    tabController.removeListener(onChangeTab);
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBgColor,
        leading: InkWell(onTap: ()=>Navigator.pop(context), child: Icon(Icons.arrow_back,color: Colors.black,size: 20.sp,)),
        title: Text("My Bookings",style: GoogleFonts.dmSans(fontWeight: FontWeight.w700,fontSize: 20.sp),),
        centerTitle: true,
        bottom: PreferredSize(preferredSize: Size(1.sw, 40.h), child: DoctorAppointmentsTabBar(tabController: tabController,)),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
        DoctorUpcomingAppointments(),
        DoctorCompletedAppointments(),
        DoctorPendingAppointments(),
      ],),
    );
  }

  void onChangeTab(){
    setState(() {

    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/views/widgets/patient_appointments/appointments_tab_bar.dart';
import 'package:kaustubha_medtech/views/widgets/patient_appointments/tabs/canceled_appointments.dart';
import 'package:kaustubha_medtech/views/widgets/patient_appointments/tabs/completed_appointments.dart';
import 'package:kaustubha_medtech/views/widgets/patient_appointments/tabs/upcoming_appointments.dart';

import '../../../../utils/app_colors/app_colors.dart';
class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> with SingleTickerProviderStateMixin{

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
        bottom: PreferredSize(preferredSize: Size(1.sw, 40.h), child: PatientAppointmentsTabBar(tabController: tabController,)),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
        UpcomingAppointments(),
        CompletedAppointments(),
        CanceledAppointments(),
      ],),
    );
  }


  void onChangeTab(){
    setState(() {

    });
  }
}

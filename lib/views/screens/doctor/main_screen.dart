import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import 'package:kaustubha_medtech/controller/providers/user/user_provider.dart';
import 'package:kaustubha_medtech/models/user/EnrollmentStatusModel.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/routes/doctor_routes.dart';
import 'package:kaustubha_medtech/utils/routes/route_names/route_observer.dart';
import 'package:kaustubha_medtech/views/widgets/doctor/doctor_custom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:kaustubha_medtech/utils/routes/route_names/route_names.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../controller/providers/common_provider.dart';
import '../../../utils/constants/constants.dart';
import '../../alerts/custom_alerts.dart';
import '../video_calling/video_call.dart';

class DoctorMainScreen extends StatefulWidget {
  const DoctorMainScreen({super.key});

  @override
  State<DoctorMainScreen> createState() => _DoctorMainScreenState();
}

class _DoctorMainScreenState extends State<DoctorMainScreen> {
  bool loader=true;
  String currentRoute=RoutesName.patientHome;
  GlobalKey<NavigatorState> navKey=GlobalKey<NavigatorState>();
  IO.Socket? socket;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getUserInfo();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    socket?.disconnect();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: navKey.currentState?.canPop()==false,
      onPopInvokedWithResult: (pop,data){
        if(navKey.currentState?.canPop()==true) {
          navKey.currentState?.pop();
        }
      },
      child: Scaffold(
        body:loader?
        const Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.black,),) :
        Navigator(
          key: navKey,
          observers: [routeObserver],
          initialRoute: RoutesName.doctorHome,
          onGenerateRoute: (settings){
            return DoctorRoutes.generateRoute(settings, onChangeRoute);
          },
        ),
        bottomSheet: CustomDoctorBottomNavBar(onChange: onNavBarChange,currentRoute: currentRoute,),
      ),
    );
  }

  void onChangeRoute(String? route){
    if(route!=null){
      currentRoute=route;
      context.read<CommonProvider>().setCurrentRoute(currentRoute);
      setState(() {});
    }
  }

  void getUserInfo()async{
    await Provider.of<UserProvider>(context,listen: false).getUserInfo((response){});
    await Provider.of<UserProvider>(context,listen: false).getDoctorEnrollmentStatus((r){
      if(r.success!=null&& r.data!=null){
        EnrollmentStatusModel statusModel=EnrollmentStatusModel.fromJson(r.data);
        if(statusModel.profile!=true || statusModel.availability!=true || statusModel.liscense!=true){
          Navigator.of(context,rootNavigator: true).pushNamedAndRemoveUntil(RoutesName.doctorEnrollment, (r)=>false);
          return;
        }
        loader=false;
        setState(() {

        });
      }else{
        if(r.error!=null){
          CustomPopUp.showSnackBar(context, r.error.toString(), Colors.redAccent);
        }
        loader=false;
        setState(() {

        });
      }
    });
    connectToToSocket();
  }

  void connectToToSocket()async{
    UserInfo? user=await LocalDB.getUserInfo();
    socket = IO.io('https://chatapi.kaustubhamedtech.com', IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect()  // Optional, disable auto-connect
        .build());
    socket!.connect();
    socket?.on('connect', (_){
      socket?.emit('getsetId', {'userId':user?.id});
      socket?.on('callUser', (signal)async{
        String? currentRoute=context.read<CommonProvider>().currentRoute;
        bool showingPopUp=context.read<CommonProvider>().showingCallPopup;
        print(currentRoute);
        print(showingPopUp);
        if (signal['signal'].toString() == 'call' && mounted && currentRoute!=RoutesName.videoCall && !showingPopUp) {
          CustomPopUp.showTopSnackBar(
            context,
            "Call from ${signal['name']}",
            textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp,color: Colors.black),
              Colors.white,
              onAcceptCall: (){
                Navigator.of(context).pushNamed(RoutesName.videoCall,arguments: {'clientId':signal['from'] ?? "",'answer':true});
              },
              socket: socket,
              onDeclineCall: ()async{
                UserInfo? user=await LocalDB.getUserInfo();
                socket?.on('socketIds', (socketIds) {
                  socket?.emit('answerCall', {'signal':'Declined_Call', 'to': socketIds[signal['from']],});
                  socket?.off('socketIds');
                });
                socket?.emit('getSocketIds', [[user?.id,signal['from']]]);
            }
          );
          return;
        }
      });
    });

  }

  void onNavBarChange(route){
    if(currentRoute!=route && route==RoutesName.doctorHome && navKey.currentState?.canPop()==true){
      navKey.currentState?.pop();
    }else{
      print('navigate');
      navToPage(route);
    }
  }

  void navToPage(String routeName){
    if(currentRoute==RoutesName.doctorHome) {
      navKey.currentState?.pushNamed(routeName);
    }else{
      navKey.currentState?.pushReplacementNamed(routeName);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_home.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import 'package:kaustubha_medtech/controller/providers/user/user_provider.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/routes/patient_routes.dart';
import 'package:kaustubha_medtech/utils/routes/route_names/route_observer.dart';
import 'package:kaustubha_medtech/views/widgets/patient_custom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:kaustubha_medtech/utils/routes/route_names/route_names.dart';
import '../../../controller/providers/authentication/sign_up_provider.dart';
import '../../../controller/providers/common_provider.dart';
import '../../../utils/routes/routes.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../alerts/custom_alerts.dart';

class PatientMainScreen extends StatefulWidget {
  const PatientMainScreen({super.key});

  @override
  State<PatientMainScreen> createState() => _PatientMainScreenState();
}

class _PatientMainScreenState extends State<PatientMainScreen> {
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
          initialRoute: RoutesName.patientHome,
          onGenerateRoute: (settings){
            return PatientRoutes.generateRoute(settings, onChangeRoute);
          },
        ),
        bottomSheet: CustomPatientBottomNavBar(onChange: onNavBarChange,currentRoute: currentRoute,),
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

  void getUserInfo() async {
    Map? data = ModalRoute.of(context)?.settings.arguments as Map?;
    if(data==null) {
      await Future.wait([
        Provider.of<TrackerProvider>(context, listen: false).getPatientTracker((
            response) {
          // if(response.error!=null){
          //   CustomPopUp.showSnackBar(context, response.error.toString(), Colors.redAccent);
          // }
        }),
        Provider.of<PatientHomeProvider>(context, listen: false)
            .getPatientDocuments((response) {}),
        Provider.of<UserProvider>(context, listen: false).getUserInfo((response) {}),
      ]);
    }else{
      await Future.delayed(const Duration(milliseconds: 500));
    }
    loader = false;
    setState(() {});
    if (data != null && data['route'] != null) {
      String route = data['route'];
      await Future.delayed(const Duration(milliseconds: 40));
      navToPage(route);
    }
    connectToToSocket();
  }


  void onNavBarChange(route){
    if(currentRoute!=route && route==RoutesName.patientHome && navKey.currentState?.canPop()==true){
      navKey.currentState?.pop();
    }else{
      navToPage(route);
    }
  }

  void navToPage(String routeName){
    if(currentRoute==routeName){
      return;
    }
    if(currentRoute==RoutesName.patientHome) {
      navKey.currentState?.pushNamed(routeName);
    }else{
      navKey.currentState?.pushReplacementNamed(routeName);
    }
  }

  void connectToToSocket()async{
    UserInfo? user=await LocalDB.getUserInfo();
    socket = IO.io('https://chatapi.kaustubhamedtech.com', IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect()  // Optional, disable auto-connect
        .build());
    socket?.connect();
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
}

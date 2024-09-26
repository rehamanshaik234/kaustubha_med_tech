import 'package:flutter/material.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import 'package:kaustubha_medtech/controller/providers/user/user_provider.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/routes/patient_routes.dart';
import 'package:kaustubha_medtech/utils/routes/route_observer.dart';
import 'package:kaustubha_medtech/views/widgets/patient_custom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import '../../../controller/providers/authentication/sign_up_provider.dart';
import '../../../utils/routes/routes.dart';

class PatientMainScreen extends StatefulWidget {
  const PatientMainScreen({super.key});

  @override
  State<PatientMainScreen> createState() => _PatientMainScreenState();
}

class _PatientMainScreenState extends State<PatientMainScreen> {
  bool loader=true;
  String currentRoute=RoutesName.patientHome;
  GlobalKey<NavigatorState> navKey=GlobalKey<NavigatorState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getUserInfo();
    });
    // TODO: implement initState
    super.initState();
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
      child: Consumer<SignUpProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body:loader?
            const Center(child: CircularProgressIndicator(color: Colors.black,),) :
            Navigator(
              key: navKey,
              observers: [routeObserver],
              initialRoute: RoutesName.patientHome,
              onGenerateRoute: (settings){
                return PatientRoutes.generateRoute(settings, onChangeRoute);
              },
            ),
            bottomSheet: CustomPatientBottomNavBar(onChange: onNavBarChange,currentRoute: currentRoute,),
          );
        },
      ),
    );
  }

  void onChangeRoute(String? route){
    if(route!=null){
      currentRoute=route;
      setState(() {});
    }
  }

  void getUserInfo()async{
    UserInfo? userInfo=await LocalDB.getUserInfo();
    await Future.wait([
                     Provider.of<TrackerProvider>(context,listen: false).getPatientTracker((response){}),
                     Provider.of<UserProvider>(context,listen: false).getUserInfo((response){})]);
    loader=false;
    setState(() {

    });
  }

  void onNavBarChange(route){
    if(currentRoute!=route && route==RoutesName.patientHome && navKey.currentState?.canPop()==true){
      navKey.currentState?.pop();
    }else{
      navToPage(route);
    }
  }

  void navToPage(String routeName){
    if(currentRoute==RoutesName.patientHome) {
      navKey.currentState?.pushNamed(routeName);
    }else{
      navKey.currentState?.pushReplacementNamed(routeName);
    }
  }
}

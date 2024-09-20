import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/localdb/local_db.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import 'package:kaustubha_medtech/models/user/user_info.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/constants/asset_urls.dart';
import 'package:kaustubha_medtech/utils/routes/route_observer.dart';
import 'package:kaustubha_medtech/views/widgets/custom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import '../../../controller/providers/authentication/sign_up_provider.dart';
import '../../../utils/routes/routes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool loader=true;
  String currentRoute=RoutesName.home;
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
              initialRoute: RoutesName.home,
              onGenerateRoute: (settings){
                return Routes.generateRoute(settings, onChangeRoute);
              },
            ),
            bottomSheet: CustomBottomNavBar(onChange: onNavBarChange,currentRoute: currentRoute,),
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
    await Provider.of<TrackerProvider>(context,listen: false).getPatientTracker((response){});
    print(userInfo?.id);
    loader=false;
    setState(() {

    });
  }

  void onNavBarChange(route){
    if(currentRoute!=route){
      navToPage(route);
    }
  }

  void navToPage(String routeName){
    if(currentRoute==RoutesName.home) {
      navKey.currentState?.pushNamed(routeName);
    }else{
      navKey.currentState?.pushReplacementNamed(routeName);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaustubha_medtech/controller/providers/authentication/login_provider.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_appointments.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_home.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import 'package:kaustubha_medtech/controller/providers/user/user_provider.dart';
import 'package:kaustubha_medtech/utils/routes/route_observer.dart';
import 'package:provider/provider.dart';
import 'package:kaustubha_medtech/controller/providers/authentication/sign_up_provider.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/utils/routes/routes.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
    ChangeNotifierProvider(create: (context)=>SignUpProvider()),
    ChangeNotifierProvider(create: (context)=>LoginProvider()),
    ChangeNotifierProvider(create: (context)=>TrackerProvider()),
    ChangeNotifierProvider(create: (context)=>UserProvider()),
    ChangeNotifierProvider(create: (context)=>PatientHomeProvider()),
    ChangeNotifierProvider(create: (context)=>PatientAppointmentProvider()),
    ],
    child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const Size(375, 812),
      builder: (context,child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.white,
            ),
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            cardTheme: CardTheme(color: Colors.white),
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.scaffoldBgColor
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              elevation: 0,
              backgroundColor: Colors.transparent
            ),
            bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
            scaffoldBackgroundColor: AppColors.scaffoldBgColor,
            useMaterial3: true,
          ),

          initialRoute: RoutesName.doctorEnrollment,
          onGenerateRoute: (settings){
            return Routes.generateRoute(settings, (currentRoute){});
          },
        );
      }
    );
  }
}


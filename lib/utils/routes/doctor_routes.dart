
import 'package:flutter/material.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/utils/routes/route_observer.dart';
import 'package:kaustubha_medtech/views/screens/auth/login/verify_otp/verify_login_otp.dart';
import 'package:kaustubha_medtech/views/screens/doctor/appointment/appointment_screen.dart';
import 'package:kaustubha_medtech/views/screens/doctor/calendar/calendar.dart';
import 'package:kaustubha_medtech/views/screens/doctor/chat/chat_screen.dart';
import 'package:kaustubha_medtech/views/screens/doctor/home/home_screen.dart';
import 'package:kaustubha_medtech/views/screens/doctor/main_screen.dart';
import 'package:kaustubha_medtech/views/screens/doctor/schedule/scheduler_screen.dart';
import 'package:kaustubha_medtech/views/screens/patient/appointment/childrens/add_review.dart';
import 'package:kaustubha_medtech/views/screens/patient/appointment/childrens/reschedule_appointment.dart';
import 'package:kaustubha_medtech/views/screens/patient/consult/childrens/book_appointment.dart';
import 'package:kaustubha_medtech/views/screens/patient/consult/childrens/doctor_details.dart';
import 'package:kaustubha_medtech/views/screens/patient/consult/childrens/payment_screen.dart';
import 'package:kaustubha_medtech/views/screens/patient/home/home_screen.dart';
import 'package:kaustubha_medtech/views/screens/patient/main_screen.dart';
import 'package:kaustubha_medtech/views/screens/patient/profile/children/edit_profile/verify_update_otp/verify_update_otp.dart';
import 'package:kaustubha_medtech/views/screens/patient/profile/children/notifications/notifications_screen.dart';
import 'package:kaustubha_medtech/views/screens/patient/profile/profile_screen.dart';
import 'package:kaustubha_medtech/views/widgets/patient_custom_navigation_bar.dart';

import '../../views/screens/auth/login/forgot_password/reset_password.dart';
import '../../views/screens/auth/login/forgot_password/select_verificarion_type.dart';
import '../../views/screens/auth/login/forgot_password/verify_email.dart';
import '../../views/screens/auth/login/login_screen.dart';
import '../../views/screens/auth/sign_up/sign_up.dart';
import '../../views/screens/auth/sign_up/verify_signup_otp.dart';
import '../../views/screens/patient/appointment/appointment_screen.dart';
import '../../views/screens/patient/chat/chat_screen.dart';
import '../../views/screens/patient/consult/consult_screen.dart';
import '../../views/screens/patient/profile/children/edit_profile/edit_profile.dart';
import '../../views/screens/patient/tracker/tracker_screen.dart';



class DoctorRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings,Function(String?) onPopRoute) {
    switch (settings.name) {
      case RoutesName.doctorMain:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.doctorMain,
              onPop: onPopRoute,
              child: const DoctorMainScreen(),
            )
        );
      case RoutesName.doctorHome:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.doctorHome,
              onPop: onPopRoute,
              child: const DoctorHomeScreen(),
            )
        );
      case RoutesName.doctorAppointments:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.doctorAppointments,
              onPop: onPopRoute,
              child:  DoctorAppointmentsScreen(),
            )
        );
        case RoutesName.doctorSchedule:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.doctorSchedule,
              onPop: onPopRoute,
              child:  DoctorSchedulerScreen(),
            )
        );
        case RoutesName.doctorCalendar:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.doctorCalendar,
              onPop: onPopRoute,
              child:  DoctorCalendarScreen(),
            )
        );
        case RoutesName.doctorChat:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.doctorChat,
              onPop: onPopRoute,
              child:  DoctorChatScreen(),
            )
        );

      case RoutesName.profile:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.profile,
              onPop: onPopRoute,
              child: const ProfileScreen(),
            )
        );
      case RoutesName.editProfile:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.editProfile,
              onPop: onPopRoute,
              child: const EditProfileScreen(),
            )
        );
      case RoutesName.verifyUpdateOTP:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.verifyUpdateOTP,
              onPop: onPopRoute,
              child: const VerifyUpdateOTP(),
            )
        );
      case RoutesName.notifications:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.notifications,
              onPop: onPopRoute,
              child: const NotificationsScreen(),
            )
        );

      default:
        return MaterialPageRoute(
          settings:settings,
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No Routes Found"),
            ),
          ),
        );
    }
  }
}



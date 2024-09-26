import 'package:flutter/material.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/utils/routes/route_observer.dart';
import 'package:kaustubha_medtech/views/screens/doctor/appointment/appointment_screen.dart';
import 'package:kaustubha_medtech/views/screens/doctor/appointment/childrens/reschedule_appointment.dart';
import 'package:kaustubha_medtech/views/screens/doctor/calendar/calendar.dart';
import 'package:kaustubha_medtech/views/screens/doctor/chat/chat_screen.dart';
import 'package:kaustubha_medtech/views/screens/doctor/chat/community/create_community.dart';
import 'package:kaustubha_medtech/views/screens/doctor/chat/doctor_contact_screen.dart';
import 'package:kaustubha_medtech/views/screens/doctor/home/home_screen.dart';
import 'package:kaustubha_medtech/views/screens/doctor/main_screen.dart';
import '../../views/screens/doctor/patients/patients_screen.dart';
import '../../views/screens/profile/children/edit_profile/edit_profile.dart';
import '../../views/screens/profile/children/edit_profile/verify_update_otp/verify_update_otp.dart';
import '../../views/screens/profile/children/notifications/notifications_screen.dart';
import '../../views/screens/profile/profile_screen.dart';
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
        case RoutesName.doctorAppointmentReschedule:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.doctorAppointmentReschedule,
              onPop: onPopRoute,
              child:  DoctorRescheduleAppointment(),
            )
        );
        case RoutesName.doctorPatients:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.doctorPatients,
              onPop: onPopRoute,
              child:  DoctorPatientsScreen(),
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
        case RoutesName.doctorContactList:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.doctorContactList,
              onPop: onPopRoute,
              child:  DoctorContactList(),
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
        case RoutesName.createCommunity:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.notifications,
              onPop: onPopRoute,
              child: const CreateCommunity(),
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



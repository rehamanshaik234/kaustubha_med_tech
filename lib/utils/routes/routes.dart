
import 'package:flutter/material.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/utils/routes/route_observer.dart';
import 'package:kaustubha_medtech/views/screens/auth/login/verify_otp/verify_login_otp.dart';
import 'package:kaustubha_medtech/views/screens/doctor/main_screen.dart';
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
import '../../views/screens/onboarding/onboarding_screen.dart';
import '../../views/screens/onboarding/welcome.dart';



class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings,Function(String?) onPopRoute) {
    switch (settings.name) {
      case RoutesName.onboarding:
        return MaterialPageRoute(
          settings: settings,
          builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.onboarding,
               onPop: onPopRoute,
              child: const OnboardingScreen(),
          )
          );
      case RoutesName.welcome:
        return MaterialPageRoute(
          settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.welcome,
              onPop: onPopRoute,
              child: const WelcomeScreen(),
            )
        );
      case RoutesName.signUp:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.signUp,
              onPop: onPopRoute,
              child: const CreateAccount(),
            )
        );
      case RoutesName.verifySignUpOTP:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.verifySignUpOTP,
              onPop: onPopRoute,
              child: const VerifySignUpOTP(),
            )
        );
        case RoutesName.verifyLoginOTP:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.verifySignUpOTP,
              onPop: onPopRoute,
              child: const VerifyLoginOTP(),
            )
        );
      case RoutesName.login:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.login,
              onPop: onPopRoute,
              child: const LoginScreen(),
            )
        );

      case RoutesName.verifyEmail:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.verifyEmail,
              onPop: onPopRoute,
              child: const VerifyEmail(),
            )
        );
      case RoutesName.resetPassword:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.resetPassword,
              onPop: onPopRoute,
              child: const ResetPassword(),
            )
        );

      case RoutesName.patientMain:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.patientMain,
              onPop: onPopRoute,
              child: const PatientMainScreen(),
            )
        );

        case RoutesName.doctorMain:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.doctorMain,
              onPop: onPopRoute,
              child: const DoctorMainScreen(),
            )
        );

        case RoutesName.patientHome:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.patientHome,
              onPop: onPopRoute,
              child: const PatientHomeScreen(),
            )
        );
        case RoutesName.patientAppointments:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.patientAppointments,
              onPop: onPopRoute,
              child:  MyAppointmentsScreen(),
            )
        );
        case RoutesName.reScheduleAppointment:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.reScheduleAppointment,
              onPop: onPopRoute,
              child:  RescheduleAppointment(),
            )
        );
        case RoutesName.addReview:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.addReview,
              onPop: onPopRoute,
              child:  AddReview(),
            )
        );
        case RoutesName.consult:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.consult,
              onPop: onPopRoute,
              child:  ConsultScreen(),
            )
        );
        case RoutesName.patientDoctorDetails:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.patientDoctorDetails,
              onPop: onPopRoute,
              child:  DoctorDetails(),
            )
        );
        case RoutesName.bookAppointment:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.bookAppointment,
              onPop: onPopRoute,
              child:  BookAppointment(),
            )
        );
        case RoutesName.payment:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.bookAppointment,
              onPop: onPopRoute,
              child:  PaymentScreen(),
            )
        );
        case RoutesName.chat:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.chat,
              onPop: onPopRoute,
              child:  ChatScreen(),
            )
        );
        case RoutesName.tracker:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.tracker,
              onPop: onPopRoute,
              child: TrackerScreen(),
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



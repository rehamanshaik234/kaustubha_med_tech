
import 'package:flutter/material.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/utils/routes/route_observer.dart';
import 'package:kaustubha_medtech/views/screens/auth/login/verify_otp/verify_login_otp.dart';
import 'package:kaustubha_medtech/views/screens/main/appointment/childrens/add_review.dart';
import 'package:kaustubha_medtech/views/screens/main/appointment/childrens/reschedule_appointment.dart';
import 'package:kaustubha_medtech/views/screens/main/consult/childrens/book_appointment.dart';
import 'package:kaustubha_medtech/views/screens/main/consult/childrens/doctor_details.dart';
import 'package:kaustubha_medtech/views/screens/main/home/home_screen.dart';
import 'package:kaustubha_medtech/views/screens/main/main_screen.dart';
import 'package:kaustubha_medtech/views/screens/main/profile/children/notifications/notifications_screen.dart';
import 'package:kaustubha_medtech/views/screens/main/profile/profile_screen.dart';
import 'package:kaustubha_medtech/views/widgets/custom_navigation_bar.dart';

import '../../views/screens/auth/login/forgot_password/reset_password.dart';
import '../../views/screens/auth/login/forgot_password/select_verificarion_type.dart';
import '../../views/screens/auth/login/forgot_password/verify_email.dart';
import '../../views/screens/auth/login/login_screen.dart';
import '../../views/screens/auth/sign_up/sign_up.dart';
import '../../views/screens/auth/sign_up/verify_signup_otp.dart';
import '../../views/screens/main/appointment/appointment_screen.dart';
import '../../views/screens/main/chat/chat_screen.dart';
import '../../views/screens/main/consult/consult_screen.dart';
import '../../views/screens/main/profile/children/edit_profile/edit_profile.dart';
import '../../views/screens/main/tracker/tracker_screen.dart';
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
              child: const VerifySignOTP(),
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

      case RoutesName.main:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.main,
              onPop: onPopRoute,
              child: const MainScreen(),
            )
        );

        case RoutesName.home:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.home,
              onPop: onPopRoute,
              child: const HomeScreen(),
            )
        );
        case RoutesName.appointments:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.appointments,
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
        case RoutesName.doctorDetails:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.doctorDetails,
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



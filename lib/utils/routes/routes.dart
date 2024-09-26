
import 'package:flutter/material.dart';
import 'package:kaustubha_medtech/utils/routes/doctor_routes.dart';
import 'package:kaustubha_medtech/utils/routes/patient_routes.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/utils/routes/route_observer.dart';
import 'package:kaustubha_medtech/views/screens/auth/doctor_enrollment/doctor_enrollment_screen.dart';
import 'package:kaustubha_medtech/views/screens/auth/login/verify_otp/verify_login_otp.dart';
import 'package:kaustubha_medtech/views/screens/doctor/chat/community/community_chat.dart';
import 'package:kaustubha_medtech/views/screens/doctor/main_screen.dart';
import 'package:kaustubha_medtech/views/screens/patient/appointment/childrens/add_review.dart';
import 'package:kaustubha_medtech/views/screens/patient/appointment/childrens/reschedule_appointment.dart';
import 'package:kaustubha_medtech/views/screens/patient/consult/childrens/appointment_timeslot.dart';
import 'package:kaustubha_medtech/views/screens/patient/consult/childrens/doctor_details.dart';
import 'package:kaustubha_medtech/views/screens/patient/consult/childrens/payment_screen.dart';
import 'package:kaustubha_medtech/views/screens/patient/home/home_screen.dart';
import 'package:kaustubha_medtech/views/screens/patient/main_screen.dart';
import 'package:kaustubha_medtech/views/screens/profile/children/reviews/reviews_screen.dart';
import 'package:kaustubha_medtech/views/screens/profile/children/transactions/doctor_transactions.dart';
import 'package:kaustubha_medtech/views/screens/profile/children/transactions/patient_transactions.dart';
import 'package:kaustubha_medtech/views/widgets/patient_custom_navigation_bar.dart';

import '../../views/screens/auth/login/forgot_password/reset_password.dart';
import '../../views/screens/auth/login/forgot_password/select_verificarion_type.dart';
import '../../views/screens/auth/login/forgot_password/verify_email.dart';
import '../../views/screens/auth/login/login_screen.dart';
import '../../views/screens/auth/sign_up/sign_up.dart';
import '../../views/screens/auth/sign_up/verify_signup_otp.dart';
import '../../views/screens/patient/appointment/appointment_screen.dart';
import '../../views/screens/patient/chat/patient_contact_screen.dart';
import '../../views/screens/patient/consult/consult_screen.dart';
import '../../views/screens/patient/tracker/tracker_screen.dart';
import '../../views/screens/onboarding/onboarding_screen.dart';
import '../../views/screens/onboarding/welcome.dart';
import '../../views/screens/profile/children/edit_profile/edit_profile.dart';
import '../../views/screens/profile/children/edit_profile/verify_update_otp/verify_update_otp.dart';
import '../../views/screens/profile/children/notifications/notifications_screen.dart';
import '../../views/screens/profile/profile_screen.dart';
import '../../views/screens/profile/children/patient_documents/patient_upload_document.dart';

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
        case RoutesName.reviews:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.reviews,
              onPop: onPopRoute,
              child: const DoctorReviewsScreen(),
            )
        );
        case RoutesName.doctorEnrollment:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.doctorEnrollment,
              onPop: onPopRoute,
              child: const DoctorEnrollmentScreen(),
            )
        );
        case RoutesName.doctorEnrollment:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.doctorEnrollment,
              onPop: onPopRoute,
              child: const DoctorEnrollmentScreen(),
            )
        );
      case RoutesName.patientDocuments:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.notifications,
              onPop: onPopRoute,
              child:  PatientUploadDocuments(),
            )
        );
        case RoutesName.patientTransactions:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.patientTransactions,
              onPop: onPopRoute,
              child:  const PatientTransactionsScreen(),
            )
        );
        case RoutesName.doctorTransactions:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.patientTransactions,
              onPop: onPopRoute,
              child:  const DoctorTransactionsScreen(),
            )
        );
        case RoutesName.communityChat:
        return MaterialPageRoute(
            settings:settings,
            builder: (context)=>RouteAwareWidget(
              routeName: RoutesName.patientTransactions,
              onPop: onPopRoute,
              child: CommunityChatScreen(),
            )
        );
      default:
        return PatientRoutes.generateRoute(settings, onPopRoute);
    }
  }
}



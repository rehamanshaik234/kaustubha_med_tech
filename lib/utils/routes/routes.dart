
import 'package:flutter/material.dart';
import 'package:kaustubha_medtech/utils/routes/route_names.dart';
import 'package:kaustubha_medtech/utils/routes/route_observer.dart';
import 'package:kaustubha_medtech/views/screens/auth/login/verify_otp/verify_login_otp.dart';
import 'package:kaustubha_medtech/views/screens/main/home/home_screen.dart';
import 'package:kaustubha_medtech/views/screens/main/main_screen.dart';

import '../../views/screens/auth/login/forgot_password/reset_password.dart';
import '../../views/screens/auth/login/forgot_password/select_verificarion_type.dart';
import '../../views/screens/auth/login/forgot_password/verify_email.dart';
import '../../views/screens/auth/login/login_screen.dart';
import '../../views/screens/auth/sign_up/sign_up.dart';
import '../../views/screens/auth/sign_up/verify_signup_otp.dart';
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
              routeName: RoutesName.main,
              onPop: onPopRoute,
              child: const HomeScreen(),
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



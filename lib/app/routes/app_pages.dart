/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

import 'package:disstrikt/app/export.dart';
import 'package:disstrikt/app/modules/auth/bindings/forget_password_binding.dart';
import 'package:disstrikt/app/modules/auth/bindings/loginbinding.dart';
import 'package:disstrikt/app/modules/auth/bindings/otp_binding.dart';
import 'package:disstrikt/app/modules/auth/controllers/signupcontroller.dart';
import 'package:disstrikt/app/modules/auth/view/forget_password.dart';
import 'package:disstrikt/app/modules/auth/view/loginScreen.dart';
import 'package:disstrikt/app/modules/auth/view/otp_screen.dart';
import 'package:disstrikt/app/modules/auth/view/signupScreen.dart';
import 'package:disstrikt/app/modules/home/binding/plans_bunding.dart';
import 'package:disstrikt/app/modules/home/binding/start_jouney_binding.dart';
import 'package:disstrikt/app/modules/home/binding/user_info_binding.dart';
import 'package:disstrikt/app/modules/home/view/start_journey.dart';
import 'package:disstrikt/app/modules/home/view/user_info.dart';
import 'package:disstrikt/app/modules/splash/bindings/choose_laguage_binding.dart';
import 'package:disstrikt/app/modules/splash/views/choose_language_screen.dart';

import '../modules/auth/bindings/forget_email_binding.dart';
import '../modules/auth/bindings/signupbinding.dart';
import '../modules/auth/view/forget_email_screen.dart';
import '../modules/bottom_tab/bindings/bottom_tab_binding.dart';
import '../modules/bottom_tab/views/bottom_tab.dart';
import '../modules/home/view/plans.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_screen.dart';

class AppPages {
  static const INITIAL = AppRoutes.splashRoute;

  static final routes = [
    GetPage(
      name: AppRoutes.splashRoute,
      page: () => const SplashView(),
      bindings: [SplashBinding()],
    ),
    GetPage(
      name: AppRoutes.chooseLanguage,
      page: () => const ChooseLanguageScreen(),
      bindings: [ChooseLaguageBinding()],
    ),
    GetPage(
      name: AppRoutes.signupRoute,
      page: () => const Signupscreen(),
      bindings: [Signupbinding()],
    ),
    GetPage(
      name: AppRoutes.loginRoute,
      page: () => const Loginscreen(),
      bindings: [Loginbinding()],
    ),
    GetPage(
      name: AppRoutes.forgetEmail,
      page: () => const ForgetEmailScreen(),
      bindings: [ForgetEmailBinding()],
    ),
    GetPage(
      name: AppRoutes.OtpScreen,
      page: () => const OtpScreen(),
      bindings: [OtpBinding()],
    ),
    GetPage(
      name: AppRoutes.ForgetPassword,
      page: () => const ForgetPassword(),
      bindings: [ForgetPasswordBinding()],
    ),
    GetPage(
      name: AppRoutes.UserInfo,
      page: () => const UserInfo(),
      bindings: [UserInfoBinding()],
    ),
    GetPage(
      name: AppRoutes.ChoosePlan,
      page: () => const ChoosePlanScreen(),
      bindings: [ChoosePlanBinding()],
    ),
    GetPage(
      name: AppRoutes.StartJourney,
      page: () => BottomTab(),
      bindings: [BottomTabBinding()],
    ),
  ];
}

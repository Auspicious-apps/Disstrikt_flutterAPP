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
import 'package:disstrikt/app/modules/home/controller/plans_controller.dart';
import 'package:disstrikt/app/modules/home/controller/start_journey_controller.dart';
import 'package:disstrikt/app/modules/splash/controllers/choose_language_controller.dart';

class StartJouneyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartJourneyController>(
      () => StartJourneyController(),
    );
  }
}

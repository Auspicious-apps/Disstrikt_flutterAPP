import 'package:disstrikt/app/modules/home/controller/Setting_Screen_Controller.dart';

import '../../../export.dart';
import '../../home/controller/start_journey_controller.dart';

class BottomTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StartJourneyController());
    Get.lazyPut(() => SettingScreenController());
  }
}

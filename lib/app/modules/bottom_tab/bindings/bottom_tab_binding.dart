import 'package:disstrikt/app/modules/home/controller/Setting_Screen_Controller.dart';

import '../../../export.dart';
import '../../Portfolio/controller/portfolio_controller.dart';
import '../../home/controller/start_journey_controller.dart';
import '../../jobs/controllers/jobscreen_controller.dart';
import '../../jobs/controllers/search_controller.dart';
import '../controllers/bottom_tab_controller.dart';

class BottomTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StartJourneyController());
    Get.lazyPut(() => BottomTabController());
    Get.lazyPut(() => JobscreenController());

    Get.lazyPut(() => ModelSearchController());

    Get.lazyPut(() => PortfolioController());

    Get.lazyPut(() => SettingScreenController());
  }
}

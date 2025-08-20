import 'package:disstrikt/app/modules/home/controller/Setting_Screen_Controller.dart';
import 'package:disstrikt/app/modules/jobs/controllers/jobscreen_controller.dart';

import '../../../export.dart';
import '../../home/controller/start_journey_controller.dart';
import '../controllers/JobDetail_controller.dart';

class JobscreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JobscreenController());
  }
}

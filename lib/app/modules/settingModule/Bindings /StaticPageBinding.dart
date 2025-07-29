import 'package:disstrikt/app/export.dart';
import 'package:disstrikt/app/modules/home/controller/plans_controller.dart';
import 'package:disstrikt/app/modules/home/controller/start_journey_controller.dart';
import 'package:disstrikt/app/modules/splash/controllers/choose_language_controller.dart';

import '../Controller/StaticController.dart';

class Staticpagebinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Staticcontroller>(
      () => Staticcontroller(),
    );
  }
}

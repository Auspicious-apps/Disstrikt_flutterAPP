import 'package:disstrikt/app/export.dart';

import '../Controller/changeLanguageController.dart';
import '../Controller/changePasswordController.dart';

class ChnagelanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Changelanguagecontroller>(
      () => Changelanguagecontroller(),
    );
  }
}

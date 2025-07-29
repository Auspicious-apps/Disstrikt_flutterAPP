import 'package:disstrikt/app/export.dart';

import '../Controller/changeCountryController.dart';
import '../Controller/changeLanguageController.dart';
import '../Controller/changePasswordController.dart';

class Changecountrybinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Changecountrycontroller>(
      () => Changecountrycontroller(),
    );
  }
}

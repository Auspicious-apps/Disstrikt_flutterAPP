import 'package:disstrikt/app/export.dart';

import '../Controller/changePasswordController.dart';

class Changepasswordbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Changepasswordcontroller>(
      () => Changepasswordcontroller(),
    );
  }
}

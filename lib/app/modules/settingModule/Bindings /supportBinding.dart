import 'package:disstrikt/app/export.dart';

import '../Controller/supportController.dart';

class Supportbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Supportcontroller>(
      () => Supportcontroller(),
    );
  }
}

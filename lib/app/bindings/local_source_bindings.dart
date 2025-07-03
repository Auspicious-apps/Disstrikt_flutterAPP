

import '../data/local/preferences/preference.dart';
import '../export.dart';

class LocalSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalStorage>(
      () => LocalStorage(),
      fenix: true,
    );
  }
}

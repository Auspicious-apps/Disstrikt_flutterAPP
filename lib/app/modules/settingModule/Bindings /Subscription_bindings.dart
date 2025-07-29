import 'package:disstrikt/app/export.dart';

import '../Controller/Subscription_controller.dart';
import '../Controller/supportController.dart';

class SubscriptionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionController>(
      () => SubscriptionController(),
    );
  }
}

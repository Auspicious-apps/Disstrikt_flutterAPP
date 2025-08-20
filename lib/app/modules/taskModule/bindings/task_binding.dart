import 'package:disstrikt/app/export.dart';
import 'package:disstrikt/app/modules/taskModule/controllers/taskdetail_controller.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskdetailController>(
      () => TaskdetailController(),
    );
  }
}

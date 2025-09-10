import '../../../export.dart';
import '../../home/controller/Setting_Screen_Controller.dart';
import '../../home/controller/start_journey_controller.dart';

double? currentLatitude;
double? currentLongitude;

class BottomTabController extends GetxController {
  var from;

  var selectedIndex = 0.obs;

  final homeController = Get.put(StartJourneyController());
  final settingController = Get.put(SettingScreenController());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}
  @override
  void dispose() {
    super.dispose();
  }

  void changeIndex(var index) {
    selectedIndex.value = index;
    if (index == 4) {
      settingController.GetUserProfile();
    }
    if (index == 0) {
      homeController.GetHomeDetail();
    }
  }
}

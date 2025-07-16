import 'package:disstrikt/app/modules/home/view/start_journey.dart';

import '../../../export.dart';
import '../../home/view/setting_screen.dart';
import '../controllers/bottom_tab_controller.dart';

class BottomTab extends StatelessWidget {
  List<Widget> screens = <Widget>[
    StartJourney(),
    SettingScreen(),
  ];
  var controller = Get.put(BottomTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _bodyWidget(),
        bottomNavigationBar: Obx(() => _bottomNavigator()));
  }

  Widget _bodyWidget() => GetBuilder<BottomTabController>(
      init: BottomTabController(),
      builder: (context) {
        return Obx(() => screens.elementAt(controller.selectedIndex.value));
      });

  Widget _bottomNavigator() {
    return BottomNavigationBar(
      currentIndex: controller.selectedIndex.value,
      onTap: (i) => controller.changeIndex(i),
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false, // This hides labels when unselected
      selectedItemColor: AppColors.blackColor,
      unselectedItemColor: AppColors.greyColor,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_filled,
            size: 30,
          ),
          activeIcon: Container(
            decoration: BoxDecoration(
                color: AppColors.clickTextColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: TextView(
              text: "strHome".tr,
              textStyle: TextStyle(color: AppColors.clickTextColor),
            ).marginSymmetric(horizontal: 10, vertical: 5),
          ),
          label: '', // hide label by default
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            size: 30,
          ),
          activeIcon: Container(
            decoration: BoxDecoration(
                color: AppColors.clickTextColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: TextView(
              text: "strProfile".tr,
              textStyle: TextStyle(color: AppColors.clickTextColor),
            ).marginSymmetric(horizontal: 10, vertical: 5),
          ),
          label: '', // hide label by default
        )
      ],
    );
  }
}

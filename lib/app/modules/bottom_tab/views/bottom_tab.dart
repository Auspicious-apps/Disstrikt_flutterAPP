import 'package:disstrikt/app/modules/Portfolio/views/portfolio_screen.dart';
import 'package:disstrikt/app/modules/home/view/start_journey.dart';

import '../../../export.dart';
import '../../home/view/setting_screen.dart';
import '../../jobs/views/jobScreen.dart';
import '../../jobs/views/search_screen.dart';
import '../controllers/bottom_tab_controller.dart';

class BottomTab extends StatelessWidget {
  List<Widget> screens = <Widget>[
    StartJourney(),
    Jobscreen(),
    SearchScreen(),
    PortfolioScreen(),
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
          icon: AssetImageWidget(
            bottomhome,
            imageWidth: 25,
            imageHeight: 25,
            imageFitType: BoxFit.contain,
          ),
          activeIcon: Container(
            decoration: BoxDecoration(
                color: AppColors.clickTextColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: TextView(
              text: "strHome".tr,
              textStyle:
                  TextStyle(color: AppColors.clickTextColor, fontSize: 12),
            ).marginSymmetric(horizontal: 10, vertical: 5),
          ),
          label: '', // hide label by default
        ),
        BottomNavigationBarItem(
          icon: AssetImageWidget(
            bottomjobs,
            imageWidth: 25,
            imageHeight: 25,
            imageFitType: BoxFit.contain,
          ),
          activeIcon: Container(
            decoration: BoxDecoration(
                color: AppColors.clickTextColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: TextView(
              text: "bottomJobs".tr,
              textStyle:
                  TextStyle(color: AppColors.clickTextColor, fontSize: 12),
            ).marginSymmetric(horizontal: 10, vertical: 5),
          ),
          label: '', // hide label by default
        ),
        BottomNavigationBarItem(
          icon: AssetImageWidget(
            bottomjobsearch,
            imageWidth: 25,
            imageHeight: 25,
            imageFitType: BoxFit.contain,
          ),
          activeIcon: Container(
            decoration: BoxDecoration(
                color: AppColors.clickTextColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: TextView(
              text: "bottomSearch".tr,
              textStyle:
                  TextStyle(color: AppColors.clickTextColor, fontSize: 12),
            ).marginSymmetric(horizontal: 10, vertical: 5),
          ),
          label: '', // hide label by default
        ),
        BottomNavigationBarItem(
          icon: AssetImageWidget(
            bottomportfolio,
            imageWidth: 25,
            imageHeight: 25,
            imageFitType: BoxFit.contain,
          ),
          activeIcon: Container(
            decoration: BoxDecoration(
                color: AppColors.clickTextColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: TextView(
              text: "strPortfolio".tr,
              textStyle:
                  TextStyle(color: AppColors.clickTextColor, fontSize: 12),
            ).marginSymmetric(horizontal: 10, vertical: 5),
          ),
          label: '', // hide label by default
        ),
        BottomNavigationBarItem(
          icon: AssetImageWidget(
            bottomprofile,
            imageWidth: 25,
            imageHeight: 25,
            imageFitType: BoxFit.contain,
          ),
          activeIcon: Container(
            decoration: BoxDecoration(
                color: AppColors.clickTextColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: TextView(
              text: "strProfile".tr,
              textStyle:
                  TextStyle(color: AppColors.clickTextColor, fontSize: 12),
            ).marginSymmetric(horizontal: 10, vertical: 5),
          ),
          label: '', // hide label by default
        )
      ],
    );
  }
}

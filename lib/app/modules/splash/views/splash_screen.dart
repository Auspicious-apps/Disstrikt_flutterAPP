import 'package:disstrikt/app/core/widget/annotated_region_widget.dart';

import '../../../export.dart';

import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return AnnotatedRegionWidget(
            statusBarBrightness: Brightness.light,
            statusBarColor: Color.fromRGBO(37, 33, 34, 1),
            bottomColor: Color.fromRGBO(37, 33, 34, 1),
            child: Scaffold(
              backgroundColor: AppColors.backgroundColor,
              body: Stack(
                children: [
                  AssetImageWidget(
                    onBoardingimage,
                    imageHeight: Get.height,
                    imageWidth: Get.width,
                    imageFitType: BoxFit.cover,
                  ),
                  SizedBox(
                    width: Get.width,
                    child: GestureDetector(
                      onTap: () {
                        controller.localStorage.saveFirstLaunch(true);
                        Get.offNamed(AppRoutes.chooseLanguage);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AssetImageWidget(
                            iconSplashBackground,
                            imageHeight: height_175,
                          ),
                          TextView(
                            text: "strRibbonClick".tr,
                            textStyle: TextStyle(
                                color: AppColors.whiteColor,
                                fontFamily: "minorksans",
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                            maxLines: 4,
                          ).marginSymmetric(vertical: margin_20)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

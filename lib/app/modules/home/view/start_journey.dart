import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../core/widget/asset_image_widget.dart';
import '../../../core/widget/text_view.dart';
import '../../../core/widget/material_button_widget.dart';
import '../controller/plans_controller.dart';
import '../controller/start_journey_controller.dart';

class StartJourney extends StatelessWidget {
  const StartJourney({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartJourneyController>(
      init: StartJourneyController(),
      builder: (controller) {
        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.light,
          statusBarColor: const Color.fromRGBO(37, 33, 34, 1),
          child: Scaffold(
            body: Stack(
              children: [
                AssetImageWidget(
                  onBoardingimage,
                  imageHeight: Get.height,
                  imageWidth: Get.width,
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: TextView(
                                text: "Home",
                                textAlign: TextAlign.center,
                                textStyle: const TextStyle(
                                  color: AppColors.whiteColor,
                                  fontFamily: "minorksans",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                                maxLines: 4,
                              ).marginSymmetric(vertical: margin_20),
                            ),
                          ],
                        ),
                      ),
                      MaterialButtonWidget(
                        buttonBgColor: AppColors.buttonColor,
                        buttonRadius: 8,
                        buttonText: "LogOut",
                        textColor: AppColors.backgroundColor,
                        onPressed: () {
                          controller.logout();
                        },
                      ).marginSymmetric(vertical: 20, horizontal: 20),
                    ],
                  ).marginOnly(bottom: Get.height * 0.1),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

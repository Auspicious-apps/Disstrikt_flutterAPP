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
import '../controller/Setting_Screen_Controller.dart';
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
          statusBarColor: AppColors.buttonColor,
          child: Scaffold(
            backgroundColor: AppColors.buttonColor.withOpacity(0.3),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width,
                    height: Get.height * 0.08,
                    decoration: BoxDecoration(
                      color: AppColors.buttonColor,
                    ),
                    child: TextView(
                      text: "strHome".tr,
                      textAlign: TextAlign.start,
                      textStyle: const TextStyle(
                        color: AppColors.blackColor,
                        fontFamily: "minorksans",
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 4,
                    ).marginSymmetric(horizontal: 20, vertical: 10),
                  ),
                ],
              ).marginOnly(bottom: Get.height * 0.1),
            ),
          ),
        );
      },
    );
  }
}

import 'package:disstrikt/app/core/widget/network_image_widget.dart';
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

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingScreenController>(
      init: SettingScreenController(),
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
                    // transform: new Matrix4.identity()
                    //   ..rotateZ(12 * 3.1415927 / 180),
                    width: Get.width,
                    height: Get.height * 0.08,
                    decoration: BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: TextView(
                      text: "strProfile".tr,
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
                  Column(
                    children: [
                      Row(
                        children: [
                          NetworkImageWidget(
                            imageUrl:
                                "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?_gl=1*111uq57*_ga*NzM2NTkzNTIwLjE3NDc4OTgxMjc.*_ga_8JE65Q40S6*czE3NTI2Mzg2MDIkbzMkZzEkdDE3NTI2Mzg2MTQkajQ4JGwwJGgw",
                            imageHeight: height_80,
                            imageWidth: width_80,
                            radiusAll: 100,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                text: "Puneet Kumar",
                                textAlign: TextAlign.start,
                                textStyle: const TextStyle(
                                  color: AppColors.blackColor,
                                  fontFamily: "minorksans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                                maxLines: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none, // Allow overflow
                                    children: [
                                      Container(
                                        height: height_20,
                                        width: width_20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(radius_20),
                                          color: AppColors.clickTextColor,
                                        ),
                                        child: Center(
                                          child: TextView(
                                            text: "3",
                                            textAlign: TextAlign.start,
                                            textStyle: const TextStyle(
                                              color: AppColors.whiteColor,
                                              fontFamily: "Kodchasan",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                            ),
                                            maxLines: 4,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top:
                                            -13, // Move the icon above the container
                                        right:
                                            -3, // Adjust if needed to center or align
                                        child: AssetImageWidget(
                                          iconWinner,
                                          imageWidth: 20,
                                          imageHeight: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ).marginSymmetric(vertical: 10)
                            ],
                          ).marginSymmetric(horizontal: 20)
                        ],
                      )
                    ],
                  ).marginSymmetric(horizontal: 20, vertical: 20)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

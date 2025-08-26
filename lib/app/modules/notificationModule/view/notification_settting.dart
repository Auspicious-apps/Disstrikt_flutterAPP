import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/utils/localization_service.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../core/widget/asset_image_widget.dart';
import '../../../core/widget/text_view.dart';
import '../../home/models/requestModels/buyplanRequestModel.dart';
import '../../settingModule/Controller/StaticController.dart';
import '../controller/notification_setting_controller.dart';

class NotificationSettting extends StatelessWidget {
  const NotificationSettting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationSettingController>(
      init: NotificationSettingController(),
      builder: (controller) {
        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.buttonColor,
          child: Scaffold(
              body: Obx(() => Skeletonizer(
                    enabled: controller.isLoading.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: Get.width,
                            height: Get.height * 0.08,
                            decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_back_ios_new_sharp,
                                      size: 20,
                                    ),
                                  ),
                                ).marginOnly(left: margin_10),
                                TextView(
                                  text: "strNotificationSettings".tr,
                                  textStyle: const TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ).marginSymmetric(horizontal: 10, vertical: 10),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(70)),
                                    child: Center(
                                      child: AssetImageWidget(
                                        JobModal,
                                        imageWidth: 35,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextView(
                                      maxLines: 2,
                                      text: "strJobAndApplications".tr,
                                      textStyle: const TextStyle(
                                        color: AppColors.blackColor,
                                        fontFamily: "Kodchasan",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ).marginSymmetric(horizontal: 10),
                                  ),
                                  Obx(() => GestureDetector(
                                        onTap: () async {
                                          controller.notificationSettingModel!
                                                  .value!.data!.jobAlerts =
                                              !controller
                                                  .notificationSettingModel!
                                                  .value!
                                                  .data!
                                                  .jobAlerts!;
                                          controller.update();
                                          Map<String, dynamic> requestModel =
                                              BuyPlanRequestModel
                                                  .changeNotificationSettingRequestModel(
                                            jobAlerts: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.jobAlerts,
                                            tasksPortfolioProgress: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.tasksPortfolioProgress,
                                            profilePerformance: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.profilePerformance,
                                            engagementMotivation: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.engagementMotivation,
                                          );
                                          controller.NotificationSettingChange(
                                              requestModel);
                                        },
                                        child: AssetImageWidget(
                                          controller
                                                      .notificationSettingModel
                                                      ?.value
                                                      ?.data
                                                      ?.jobAlerts ==
                                                  true
                                              ? ToggleButtonDisable
                                              : ToggleButtonEnable,
                                          imageWidth: 35,
                                        ),
                                      )),
                                ],
                              ).marginSymmetric(horizontal: 20, vertical: 10),
                              Divider(
                                color: AppColors.buttonColor,
                              ).marginSymmetric(horizontal: 20),
                              Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(70)),
                                    child: Center(
                                      child: AssetImageWidget(
                                        JobModal,
                                        imageWidth: 35,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextView(
                                      maxLines: 2,
                                      text: "strTaskAndPortfolio".tr,
                                      textStyle: const TextStyle(
                                        color: AppColors.blackColor,
                                        fontFamily: "Kodchasan",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ).marginSymmetric(horizontal: 10),
                                  ),
                                  Obx(() => GestureDetector(
                                        onTap: () {
                                          controller
                                                  .notificationSettingModel!
                                                  .value!
                                                  .data!
                                                  .tasksPortfolioProgress =
                                              !controller
                                                  .notificationSettingModel!
                                                  .value!
                                                  .data!
                                                  .tasksPortfolioProgress!;
                                          controller.update();
                                          Map<String, dynamic> requestModel =
                                              BuyPlanRequestModel
                                                  .changeNotificationSettingRequestModel(
                                            jobAlerts: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.jobAlerts,
                                            tasksPortfolioProgress: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.tasksPortfolioProgress,
                                            profilePerformance: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.profilePerformance,
                                            engagementMotivation: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.engagementMotivation,
                                          );
                                          controller.NotificationSettingChange(
                                              requestModel);
                                        },
                                        child: AssetImageWidget(
                                          controller
                                                      .notificationSettingModel
                                                      ?.value
                                                      ?.data
                                                      ?.tasksPortfolioProgress ==
                                                  true
                                              ? ToggleButtonDisable
                                              : ToggleButtonEnable,
                                          imageWidth: 35,
                                        ),
                                      )),
                                ],
                              ).marginSymmetric(
                                horizontal: 20,
                              ),
                              Divider(
                                color: AppColors.buttonColor,
                              ).marginSymmetric(horizontal: 20),
                              Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(70)),
                                    child: Center(
                                      child: AssetImageWidget(
                                        JobModal,
                                        imageWidth: 35,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextView(
                                      maxLines: 2,
                                      text: "strProfileAndPerformance".tr,
                                      textStyle: const TextStyle(
                                        color: AppColors.blackColor,
                                        fontFamily: "Kodchasan",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ).marginSymmetric(horizontal: 10),
                                  ),
                                  Obx(() => GestureDetector(
                                        onTap: () {
                                          controller
                                                  .notificationSettingModel!
                                                  .value!
                                                  .data!
                                                  .profilePerformance =
                                              !controller
                                                  .notificationSettingModel!
                                                  .value!
                                                  .data!
                                                  .profilePerformance!;
                                          controller.update();
                                          Map<String, dynamic> requestModel =
                                              BuyPlanRequestModel
                                                  .changeNotificationSettingRequestModel(
                                            jobAlerts: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.jobAlerts,
                                            tasksPortfolioProgress: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.tasksPortfolioProgress,
                                            profilePerformance: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.profilePerformance,
                                            engagementMotivation: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.engagementMotivation,
                                          );
                                          controller.NotificationSettingChange(
                                              requestModel);
                                        },
                                        child: AssetImageWidget(
                                          controller
                                                      .notificationSettingModel
                                                      ?.value
                                                      ?.data
                                                      ?.profilePerformance ==
                                                  true
                                              ? ToggleButtonDisable
                                              : ToggleButtonEnable,
                                          imageWidth: 35,
                                        ),
                                      )),
                                ],
                              ).marginSymmetric(horizontal: 20, vertical: 10),
                              Divider(
                                color: AppColors.buttonColor,
                              ).marginSymmetric(horizontal: 20),
                              Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(70)),
                                    child: Center(
                                      child: AssetImageWidget(
                                        JobModal,
                                        imageWidth: 35,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextView(
                                      maxLines: 2,
                                      text: "strImprovements".tr,
                                      textStyle: const TextStyle(
                                        color: AppColors.blackColor,
                                        fontFamily: "Kodchasan",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ).marginSymmetric(horizontal: 10),
                                  ),
                                  Obx(() => GestureDetector(
                                        onTap: () {
                                          controller
                                                  .notificationSettingModel!
                                                  .value!
                                                  .data!
                                                  .engagementMotivation =
                                              !controller
                                                  .notificationSettingModel!
                                                  .value!
                                                  .data!
                                                  .engagementMotivation!;
                                          controller.update();

                                          Map<String, dynamic> requestModel =
                                              BuyPlanRequestModel
                                                  .changeNotificationSettingRequestModel(
                                            jobAlerts: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.jobAlerts,
                                            tasksPortfolioProgress: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.tasksPortfolioProgress,
                                            profilePerformance: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.profilePerformance,
                                            engagementMotivation: controller
                                                .notificationSettingModel
                                                ?.value
                                                ?.data
                                                ?.engagementMotivation,
                                          );
                                          controller.NotificationSettingChange(
                                              requestModel);
                                        },
                                        child: AssetImageWidget(
                                          controller
                                                      .notificationSettingModel
                                                      ?.value
                                                      ?.data
                                                      ?.engagementMotivation ==
                                                  true
                                              ? ToggleButtonDisable
                                              : ToggleButtonEnable,
                                          imageWidth: 35,
                                        ),
                                      )),
                                ],
                              ).marginSymmetric(
                                horizontal: 20,
                              )
                            ],
                          ),
                        ),
                      ],
                    ).marginOnly(bottom: Get.height * 0.02),
                  ))),
        );
      },
    );
  }
}

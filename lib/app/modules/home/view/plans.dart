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

class ChoosePlanScreen extends StatelessWidget {
  const ChoosePlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChoosePalnController>(
      init: ChoosePalnController(),
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: height_40,
                            width: width_40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                                size: 18,
                              ),
                            ),
                          ).marginOnly(right: 2),
                        ).marginSymmetric(
                          horizontal: margin_13,
                          vertical: margin_13,
                        ),
                        AssetImageWidget(
                          plansImage,
                          imageHeight: Get.height * 0.3,
                          imageWidth: Get.width,
                          fit: BoxFit.fill,
                        ).marginSymmetric(horizontal: 20),
                        Align(
                          alignment: Alignment.center,
                          child: TextView(
                            text: "strPlansHeading".tr,
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
                        Obx(() => Skeletonizer(
                              enabled: controller.isloading.value,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.isloading.value
                                    ? 3 // Show 3 skeleton items when loading
                                    : controller.planResponseModel.value.data
                                            ?.length ??
                                        0,
                                itemBuilder: (context, index) {
                                  final plan = controller.isloading.value
                                      ? null
                                      : controller
                                          .planResponseModel.value.data?[index];
                                  return Obx(() => GestureDetector(
                                        onTap: controller.isloading.value
                                            ? null
                                            : () {
                                                controller.selectIndex.value =
                                                    index;
                                                controller.selectIndex
                                                    .refresh();
                                              },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: controller.isloading.value
                                                ? Colors.grey.shade400
                                                : controller.selectIndex
                                                            .value ==
                                                        index
                                                    ? AppColors.clickTextColor
                                                    : Colors.grey.shade400,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextView(
                                                      text: plan?.name ??
                                                          "Placeholder Plan",
                                                      textAlign:
                                                          TextAlign.center,
                                                      textStyle:
                                                          const TextStyle(
                                                        color: AppColors
                                                            .clickTextColor,
                                                        fontFamily:
                                                            "minorksans",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                      maxLines: 4,
                                                    ),
                                                    TextView(
                                                      text: controller
                                                              .isloading.value
                                                          ? "£0.00 / €0.00"
                                                          : "£${plan?.gbpAmount ?? '0.00'} / €${plan?.eurAmount ?? '0.00'}",
                                                      textAlign:
                                                          TextAlign.start,
                                                      textStyle:
                                                          const TextStyle(
                                                        color: AppColors
                                                            .blackColor,
                                                        fontFamily:
                                                            "minorksans",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                      maxLines: 4,
                                                    ),
                                                  ],
                                                ),
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: controller
                                                          .isloading.value
                                                      ? 3 // Show 3 skeleton features when loading
                                                      : plan?.features
                                                              ?.length ??
                                                          0,
                                                  itemBuilder:
                                                      (context, featureIndex) {
                                                    return Container(
                                                      height: 30,
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            FeaturesImage,
                                                            width: 20,
                                                            height: 20,
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          TextView(
                                                            text: controller
                                                                    .isloading
                                                                    .value
                                                                ? "Placeholder Feature"
                                                                : plan?.features?[
                                                                        featureIndex] ??
                                                                    "",
                                                            textStyle:
                                                                const TextStyle(
                                                              color: AppColors
                                                                  .smalltextColor,
                                                              fontFamily:
                                                                  "Kodchasan",
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                            ),
                                                            maxLines: 1,
                                                          ),
                                                        ],
                                                      ).marginOnly(
                                                        bottom: featureIndex ==
                                                                ((controller.isloading
                                                                            .value
                                                                        ? 3
                                                                        : plan?.features?.length ??
                                                                            0) -
                                                                    1)
                                                            ? 30
                                                            : 0,
                                                        top: 5,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ).marginSymmetric(
                                                horizontal: 16, vertical: 16),
                                          ).marginOnly(
                                              top: 0,
                                              right: 3,
                                              bottom: 4,
                                              left: 0),
                                        ),
                                      )
                                          .marginSymmetric(horizontal: 20)
                                          .marginOnly(
                                              top: index != 0 ? 15 : 0));
                                },
                              ),
                            )),
                      ],
                    ).marginOnly(bottom: Get.height * 0.1),
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: Obx(() => Skeletonizer(
                  enabled: controller.isloading.value,
                  child: MaterialButtonWidget(
                    buttonBgColor: AppColors.buttonColor,
                    buttonRadius: 8,
                    buttonText:
                        controller.setupIntent.value.data?.alreadySetup == true
                            ? "strStartSubscription".tr
                            : "strTrailText".tr,
                    textColor: AppColors.backgroundColor,
                    onPressed: controller.isloading.value
                        ? null
                        : () async {
                            if (controller
                                    .setupIntent.value.data?.alreadySetup ==
                                false) {
                              await controller.openCardInputSheet();
                            } else {
                              controller.SetupIntentPlans();
                            }
                          },
                  ).marginSymmetric(horizontal: 20),
                )),
          ),
        );
      },
    );
  }
}

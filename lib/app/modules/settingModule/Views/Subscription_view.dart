import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/utils/localization_service.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../core/widget/asset_image_widget.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/text_view.dart';

import '../../auth/models/requestmodels/RequestModel.dart';
import '../Controller/Subscription_controller.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(
      init: SubscriptionController(),
      builder: (controller) {
        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.buttonColor,
          child: Scaffold(
            backgroundColor: AppColors.buttonColor.withOpacity(0.3),
            body: Obx(() => Column(
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
                              text: "strSubscription".tr,
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
                    Expanded(
                      child: Skeletonizer(
                        enabled: controller.isloading.value,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              controller.setupIntent.value.data?.planId !=
                                          null ||
                                      controller.setupIntent.value.data?.planId
                                              ?.isNotEmpty ==
                                          true
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextView(
                                          text: "strYourActivePlan".tr,
                                          textStyle: const TextStyle(
                                            color: AppColors.blackColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ).marginSymmetric(
                                            horizontal: 20, vertical: 20),
                                        Container(
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: AppColors.buttonColor),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: TextView(
                                                      text: controller
                                                              ?.newFacePlan
                                                              .value
                                                              ?.name ??
                                                          "Placeholder Plan",
                                                      textAlign:
                                                          TextAlign.start,
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
                                                  ),
                                                  TextView(
                                                    text: controller
                                                            .isloading.value
                                                        ? "£0.00 / €0.00"
                                                        : LocalizationService
                                                                    .currentCountry ==
                                                                "United Kingdom"
                                                            ? "£${controller?.newFacePlan.value?.gbpAmount ?? '0.00'}"
                                                            : "€${controller?.newFacePlan.value?.eurAmount ?? '0.00'}",
                                                    textAlign: TextAlign.start,
                                                    textStyle: const TextStyle(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontFamily: "minorksans",
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
                                                    : controller
                                                            ?.newFacePlan
                                                            .value
                                                            ?.features
                                                            ?.length ??
                                                        0,
                                                itemBuilder:
                                                    (context, featureIndex) {
                                                  return Container(
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          FeaturesImage,
                                                          width: 20,
                                                          height: 20,
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Flexible(
                                                          child: TextView(
                                                            text: controller
                                                                    .isloading
                                                                    .value
                                                                ? "Placeholder Feature"
                                                                : controller
                                                                        ?.newFacePlan
                                                                        .value
                                                                        ?.features?[featureIndex] ??
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
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                      ],
                                                    ).marginOnly(
                                                      bottom: featureIndex ==
                                                              ((controller.isloading
                                                                          .value
                                                                      ? 3
                                                                      : controller
                                                                              ?.newFacePlan
                                                                              .value
                                                                              ?.features
                                                                              ?.length ??
                                                                          0) -
                                                                  1)
                                                          ? 30
                                                          : 0,
                                                      top: 5,
                                                    ),
                                                  );
                                                },
                                              ),
                                              Row(
                                                children: [
                                                  controller.setupIntent.value
                                                              .data?.status ==
                                                          "trialing"
                                                      ? Expanded(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                  context: Get
                                                                      .context!,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return Dialog(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                      ),
                                                                      elevation:
                                                                          0,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      child: _buildEndTrailModalContent(
                                                                          context,
                                                                          controller),
                                                                    );
                                                                  });
                                                            },
                                                            child: Container(
                                                              height: height_40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: AppColors
                                                                      .clickTextColor),
                                                              child: Center(
                                                                child: TextView(
                                                                  text:
                                                                      "strEndTrail"
                                                                          .tr,
                                                                  textStyle: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: AppColors
                                                                          .whiteColor,
                                                                      fontFamily:
                                                                          "Kodchasan",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox(),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  controller.setupIntent.value
                                                              .data?.status !=
                                                          "canceling"
                                                      ? Expanded(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                  context: Get
                                                                      .context!,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return Dialog(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                      ),
                                                                      elevation:
                                                                          0,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      child: _buildCancelSubsModalContent(
                                                                          context,
                                                                          controller),
                                                                    );
                                                                  });
                                                            },
                                                            child: Container(
                                                              height: height_40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border.all(
                                                                      color: AppColors
                                                                          .clickTextColor),
                                                                  color: AppColors
                                                                      .whiteColor),
                                                              child: Center(
                                                                child: TextView(
                                                                  text:
                                                                      "strCancelSubscription"
                                                                          .tr,
                                                                  textStyle: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: AppColors
                                                                          .clickTextColor,
                                                                      fontFamily:
                                                                          "Kodchasan",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox(),
                                                ],
                                              )
                                            ],
                                          ).marginSymmetric(
                                              horizontal: 16, vertical: 16),
                                        ).marginSymmetric(horizontal: 15),
                                      ],
                                    )
                                  : SizedBox(),
                              controller.queuePlans.value?.length != 0
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextView(
                                          text: "strPlaninQueue".tr,
                                          textStyle: const TextStyle(
                                            color: AppColors.blackColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ).marginSymmetric(
                                            horizontal: 20, vertical: 20),
                                        Obx(() => Skeletonizer(
                                              enabled:
                                                  controller.isloading.value,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: controller
                                                        .isloading.value
                                                    ? 3 // Show 3 skeleton items when loading
                                                    : controller.queuePlans
                                                            .value?.length ??
                                                        0,
                                                itemBuilder: (context, index) {
                                                  final plan =
                                                      controller.isloading.value
                                                          ? null
                                                          : controller
                                                              .queuePlans
                                                              .value?[index];
                                                  return Obx(
                                                      () => GestureDetector(
                                                            onTap: controller
                                                                    .isloading
                                                                    .value
                                                                ? null
                                                                : () {
                                                                    controller
                                                                        .selectIndex
                                                                        .value = index;
                                                                    controller
                                                                        .selectIndex
                                                                        .refresh();
                                                                  },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppColors
                                                                      .whiteColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              TextView(
                                                                            text:
                                                                                plan?.name ?? "Placeholder Plan",
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            textStyle:
                                                                                const TextStyle(
                                                                              color: AppColors.clickTextColor,
                                                                              fontFamily: "minorksans",
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.w800,
                                                                            ),
                                                                            maxLines:
                                                                                4,
                                                                          ),
                                                                        ),
                                                                        TextView(
                                                                          text: controller.isloading.value
                                                                              ? "£0.00 / €0.00"
                                                                              : LocalizationService.currentCountry == "United Kingdom"
                                                                                  ? "£${plan?.gbpAmount ?? '0.00'}"
                                                                                  : "€${plan?.eurAmount ?? '0.00'}",
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          textStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                AppColors.blackColor,
                                                                            fontFamily:
                                                                                "minorksans",
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w900,
                                                                          ),
                                                                          maxLines:
                                                                              4,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    ListView
                                                                        .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      itemCount: controller
                                                                              .isloading
                                                                              .value
                                                                          ? 3 // Show 3 skeleton features when loading
                                                                          : plan?.features?.length ??
                                                                              0,
                                                                      itemBuilder:
                                                                          (context,
                                                                              featureIndex) {
                                                                        return Container(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Image.asset(
                                                                                FeaturesImage,
                                                                                width: 20,
                                                                                height: 20,
                                                                              ),
                                                                              const SizedBox(width: 10),
                                                                              Flexible(
                                                                                child: TextView(
                                                                                  text: controller.isloading.value ? "Placeholder Feature" : plan?.features?[featureIndex] ?? "",
                                                                                  textStyle: const TextStyle(
                                                                                    color: AppColors.smalltextColor,
                                                                                    fontFamily: "Kodchasan",
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.w800,
                                                                                  ),
                                                                                  maxLines: 2,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ).marginOnly(
                                                                            bottom: featureIndex == ((controller.isloading.value ? 3 : plan?.features?.length ?? 0) - 1)
                                                                                ? 30
                                                                                : 0,
                                                                            top:
                                                                                5,
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ).marginSymmetric(
                                                                    horizontal:
                                                                        16,
                                                                    vertical:
                                                                        16),
                                                              ).marginOnly(
                                                                  top: 0,
                                                                  right: 3,
                                                                  bottom: 4,
                                                                  left: 0),
                                                            ),
                                                          )
                                                              .marginSymmetric(
                                                                  horizontal:
                                                                      20)
                                                              .marginOnly(
                                                                  top:
                                                                      index != 0
                                                                          ? 15
                                                                          : 0));
                                                },
                                              ),
                                            )),
                                      ],
                                    )
                                  : SizedBox(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    text: "StrUpgradePlan".tr,
                                    textStyle: const TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ).marginSymmetric(
                                      horizontal: 20, vertical: 20),
                                  Obx(() => Skeletonizer(
                                        enabled: controller.isloading.value,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: controller.isloading.value
                                              ? 3 // Show 3 skeleton items when loading
                                              : controller.otherPlans.value
                                                      ?.length ??
                                                  0,
                                          itemBuilder: (context, index) {
                                            final plan =
                                                controller.isloading.value
                                                    ? null
                                                    : controller.otherPlans
                                                        .value?[index];
                                            return Obx(() => GestureDetector(
                                                  onTap: controller
                                                          .isloading.value
                                                      ? null
                                                      : () {
                                                          controller.selectIndex
                                                              .value = index;
                                                          controller.selectIndex
                                                              .refresh();
                                                        },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: controller
                                                              .isloading.value
                                                          ? Colors.grey.shade400
                                                          : controller.selectIndex
                                                                      .value ==
                                                                  index
                                                              ? AppColors
                                                                  .clickTextColor
                                                              : Colors.grey
                                                                  .shade400,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .whiteColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: TextView(
                                                                  text: plan
                                                                          ?.name ??
                                                                      "Placeholder Plan",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    color: AppColors
                                                                        .clickTextColor,
                                                                    fontFamily:
                                                                        "minorksans",
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                  maxLines: 4,
                                                                ),
                                                              ),
                                                              TextView(
                                                                text: controller
                                                                        .isloading
                                                                        .value
                                                                    ? "£0.00 / €0.00"
                                                                    : LocalizationService.currentCountry ==
                                                                            "United Kingdom"
                                                                        ? "£${plan?.gbpAmount ?? '0.00'}"
                                                                        : "€${plan?.eurAmount ?? '0.00'}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                textStyle:
                                                                    const TextStyle(
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontFamily:
                                                                      "minorksans",
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
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
                                                                    .isloading
                                                                    .value
                                                                ? 3 // Show 3 skeleton features when loading
                                                                : plan?.features
                                                                        ?.length ??
                                                                    0,
                                                            itemBuilder: (context,
                                                                featureIndex) {
                                                              return Container(
                                                                child: Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      FeaturesImage,
                                                                      width: 20,
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
                                                                    Flexible(
                                                                      child:
                                                                          TextView(
                                                                        text: controller.isloading.value
                                                                            ? "Placeholder Feature"
                                                                            : plan?.features?[featureIndex] ??
                                                                                "",
                                                                        textStyle:
                                                                            const TextStyle(
                                                                          color:
                                                                              AppColors.smalltextColor,
                                                                          fontFamily:
                                                                              "Kodchasan",
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w800,
                                                                        ),
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ).marginOnly(
                                                                  bottom: featureIndex ==
                                                                          ((controller.isloading.value ? 3 : plan?.features?.length ?? 0) -
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
                                                          horizontal: 16,
                                                          vertical: 16),
                                                    ).marginOnly(
                                                        top: 0,
                                                        right: 3,
                                                        bottom: 4,
                                                        left: 0),
                                                  ),
                                                )
                                                    .marginSymmetric(
                                                        horizontal: 20)
                                                    .marginOnly(
                                                        top: index != 0
                                                            ? 15
                                                            : 0));
                                          },
                                        ),
                                      )),
                                  Obx(() => MaterialButtonWidget(
                                        isloading: controller.isloading.value,
                                        buttonBgColor:
                                            controller.selectIndex == 10
                                                ? AppColors.greyLightColor
                                                : AppColors.buttonColor,
                                        buttonRadius: 8,
                                        buttonText: "strChange".tr,
                                        iconWidget: Icon(
                                            Icons.arrow_forward_sharp,
                                            color: AppColors.backgroundColor),
                                        textColor: AppColors.backgroundColor,
                                        onPressed: () {
                                          if (controller.selectIndex != 10) {
                                            showDialog(
                                                context: Get.context!,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    elevation: 0,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child:
                                                        _buildOtpModalContent(
                                                            context,
                                                            controller),
                                                  );
                                                });
                                          }
                                        },
                                      ).marginSymmetric(
                                          vertical: 10, horizontal: 20)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ).marginOnly(bottom: Get.height * 0.02)),
          ),
        );
      },
    );
  }

  Widget _buildEndTrailModalContent(BuildContext context, controller) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.42,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imagemodalbackground), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            moneyImage,
            height: 80,
            width: 80,
          ),
          TextView(
            text: "strendTrailHeading".tr,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "minorksans",
                fontSize: 18,
                fontWeight: FontWeight.w800),
            maxLines: 4,
          ).marginOnly(top: 10, left: 10, right: 10),
          TextView(
            text: "strEndTrailSubHeading".tr,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "Kodchasan",
                fontSize: 12,
                fontWeight: FontWeight.w400),
            maxLines: 4,
          ).marginOnly(top: 5, left: 10, right: 10),
          SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: MaterialButtonWidget(
                    buttonBgColor: Colors.transparent,
                    buttonRadius: 8,
                    isOutlined: true,
                    borderColor: Colors.black,
                    buttonText: "strNoCancel".tr,
                    buttonTextStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontFamily: "Kodchasan",
                        fontWeight: FontWeight.w600),
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: Obx(() => MaterialButtonWidget(
                        isloading: controller.isloading.value,
                        buttonBgColor: AppColors.clickTextColor,
                        buttonRadius: 8,
                        buttonText: "stryesUpgrade".tr,
                        buttonTextStyle: TextStyle(
                            fontSize: 12,
                            color: AppColors.whiteColor,
                            fontFamily: "Kodchasan",
                            fontWeight: FontWeight.w600),
                        textColor: AppColors.whiteColor,
                        onPressed: () {
                          Map<String, dynamic> requestModel =
                              AuthRequestModel.ChangeSubscriptionRequestModel(
                            type: "cancelTrial",
                            // planId: controller
                            //     .setupIntent
                            //     .value
                            //     .data
                            //     ?.planId
                          );
                          controller.handleSubmit(requestModel);
                        },
                      )),
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 15),
        ],
      ),
    );
  }

  Widget _buildOtpModalContent(BuildContext context, controller) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.35,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imagemodalbackground), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            moneyImage,
            height: 80,
            width: 80,
          ),
          TextView(
            text: "strUpgradeModalheading".tr,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "minorksans",
                fontSize: 18,
                fontWeight: FontWeight.w800),
            maxLines: 4,
          ).marginOnly(top: 10, left: 10, right: 10),
          SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: MaterialButtonWidget(
                    buttonBgColor: Colors.transparent,
                    buttonRadius: 8,
                    isOutlined: true,
                    borderColor: Colors.black,
                    buttonText: "strNoCancel".tr,
                    buttonTextStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontFamily: "Kodchasan",
                        fontWeight: FontWeight.w600),
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: Obx(() => MaterialButtonWidget(
                        isloading: controller.isloading.value,
                        buttonBgColor: AppColors.clickTextColor,
                        buttonRadius: 8,
                        buttonText: "stryesUpgrade".tr,
                        buttonTextStyle: TextStyle(
                            fontSize: 12,
                            color: AppColors.whiteColor,
                            fontFamily: "Kodchasan",
                            fontWeight: FontWeight.w600),
                        textColor: AppColors.whiteColor,
                        onPressed: () {
                          if (controller.selectIndex.value != 10) {
                            if (controller.setupIntent.value.data?.status ==
                                "trialing") {
                              Map<String, dynamic> requestModel =
                                  AuthRequestModel
                                      .ChangeSubscriptionRequestModel(
                                          type: "cancelTrial",
                                          planId: controller
                                              .otherPlans
                                              .value[
                                                  controller.selectIndex.value]
                                              .sId);
                              controller.handleSubmit(requestModel);
                            } else {
                              Map<String, dynamic> requestModel =
                                  AuthRequestModel
                                      .ChangeSubscriptionRequestModel(
                                          type: "upgrade",
                                          planId: controller
                                              .otherPlans
                                              .value[
                                                  controller.selectIndex.value]
                                              .sId);
                              controller.handleSubmit(requestModel);
                            }
                          }
                        },
                      )),
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 15),
        ],
      ),
    );
  }

  Widget _buildCancelSubsModalContent(BuildContext context, controller) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.35,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imagemodalbackground), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            moneyImage,
            height: 80,
            width: 80,
          ),
          TextView(
            text: "strCancelModalheading".tr,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "minorksans",
                fontSize: 18,
                fontWeight: FontWeight.w800),
            maxLines: 4,
          ).marginOnly(top: 10, left: 10, right: 10),
          SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: MaterialButtonWidget(
                    buttonBgColor: Colors.transparent,
                    buttonRadius: 8,
                    isOutlined: true,
                    borderColor: Colors.black,
                    buttonText: "strNoCancel".tr,
                    buttonTextStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontFamily: "Kodchasan",
                        fontWeight: FontWeight.w600),
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: Obx(() => MaterialButtonWidget(
                        isloading: controller.isloading.value,
                        buttonBgColor: AppColors.clickTextColor,
                        buttonRadius: 8,
                        buttonText: "stryesUpgrade".tr,
                        buttonTextStyle: TextStyle(
                            fontSize: 12,
                            color: AppColors.whiteColor,
                            fontFamily: "Kodchasan",
                            fontWeight: FontWeight.w600),
                        textColor: AppColors.whiteColor,
                        onPressed: () {
                          Map<String, dynamic> requestModel =
                              AuthRequestModel.ChangeSubscriptionRequestModel(
                                  type: "cancelSubscription",
                                  planId: controller
                                      .setupIntent.value.data?.planId);
                          controller.handleSubmit(requestModel);
                        },
                      )),
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 15),
        ],
      ),
    );
  }

  getBookTitle({required dynamic name}) {
    const String defaultTitle = 'No Title';
    String selectedLanguage =
        LocalizationService.getLanguageName(LocalizationService.currentLocale);
    String languageCode = selectedLanguage == "English"
        ? "en"
        : selectedLanguage == "Dutch"
            ? "nl"
            : selectedLanguage == "French"
                ? "fr"
                : "es";
    if (name == null) return defaultTitle;

    try {
      switch (languageCode) {
        case 'en':
          return name.en?.toString();
        case 'nl':
          return name.nl?.toString();
        case 'fr':
          return name.fr?.toString();
        case 'es':
          return name.es?.toString();
        default:
          return defaultTitle;
      }
    } catch (e) {
      print("Error in getBookTitle: $e");
      return defaultTitle;
    }
  }
}

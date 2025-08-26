import 'dart:math';
import 'package:disstrikt/app/core/widget/text_view.dart';
import 'package:disstrikt/app/export.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../core/widget/asset_image.dart';
import '../../../core/widget/network_image_widget.dart';
import '../controller/start_journey_controller.dart';
import '../widget/flatingImage.dart';

class StartJourney extends StatelessWidget {
  const StartJourney({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<StartJourneyController>(
      init: StartJourneyController(),
      builder: (controller) {
        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.buttonColor,
          child: Scaffold(
            backgroundColor: AppColors.buttonColor.withOpacity(0.3),
            body: Obx(() => SafeArea(
                  child: Skeletonizer(
                    enabled: controller.isLoading.value,
                    child: Column(
                      children: [
                        _topHeader(context, controller),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () {
                              controller.GetHomeDetail();
                              return Future.delayed(Duration(seconds: 2));
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Top header

                                  // List below the header
                                  Center(
                                    child: Image.asset(
                                      controller.userResponseModel?.value?.data
                                                  ?.milestone ==
                                              1
                                          ? MileStoneBanner
                                          : controller.userResponseModel?.value
                                                      ?.data?.milestone ==
                                                  2
                                              ? MileStoneBanner2
                                              : controller
                                                          .userResponseModel
                                                          ?.value
                                                          ?.data
                                                          ?.milestone ==
                                                      3
                                                  ? MileStoneBanner3
                                                  : controller
                                                              .userResponseModel
                                                              ?.value
                                                              ?.data
                                                              ?.milestone ==
                                                          4
                                                      ? MileStoneBanner4
                                                      : controller
                                                                  .userResponseModel
                                                                  ?.value
                                                                  ?.data
                                                                  ?.milestone ==
                                                              5
                                                          ? MileStoneBanner5
                                                          : controller
                                                                      .userResponseModel
                                                                      ?.value
                                                                      ?.data
                                                                      ?.milestone ==
                                                                  6
                                                              ? MileStoneBanner6
                                                              : controller
                                                                          .userResponseModel
                                                                          ?.value
                                                                          ?.data
                                                                          ?.milestone ==
                                                                      7
                                                                  ? MileStoneBanner7
                                                                  : controller
                                                                              .userResponseModel
                                                                              ?.value
                                                                              ?.data
                                                                              ?.milestone ==
                                                                          8
                                                                      ? MileStoneBanner8
                                                                      : controller.userResponseModel?.value?.data?.milestone ==
                                                                              9
                                                                          ? MileStoneBanner9
                                                                          : controller.userResponseModel?.value?.data?.milestone == 10
                                                                              ? MileStoneBanner10
                                                                              : controller.userResponseModel?.value?.data?.milestone == 11
                                                                                  ? MileStoneBanner11
                                                                                  : controller.userResponseModel?.value?.data?.milestone == 12
                                                                                      ? MileStoneBanner12
                                                                                      : controller.userResponseModel?.value?.data?.milestone == 13
                                                                                          ? MileStoneBanner13
                                                                                          : controller.userResponseModel?.value?.data?.milestone == 14
                                                                                              ? MileStoneBanner14
                                                                                              : MileStoneBanner15,
                                      width: Get.width * 0.6,
                                      height: 60,
                                    ),
                                  ).marginOnly(top: 20),
                                  ListView.builder(
                                    itemCount: controller
                                            .userResponseModel
                                            ?.value
                                            .data
                                            ?.milestoneData
                                            ?.length ??
                                        0,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      // Calculate horizontal offset for the circular container
                                      double posPercent = index / 3;
                                      double horizontalOffset =
                                          (screenWidth / 3 - 20) *
                                              sin(posPercent * pi - pi / 4);

                                      // Logic for icon visibility and position
                                      bool showLeftIcon = (((index - 1) % 6) ==
                                          2); // Left icon at indices 2, 8, 14, ...
                                      bool showRightIcon = (((index - 1) % 6) ==
                                          5); // Right icon at indices 5, 11, 17, ...

                                      return Stack(
                                        children: [
                                          if (showLeftIcon)
                                            AnimatedPositioned(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeInOut,
                                              left: showLeftIcon ? 20 : -100,
                                              child: AnimatedOpacity(
                                                opacity:
                                                    showLeftIcon ? 1.0 : 0.0,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                child: FloatingIcon(
                                                  iconPath:
                                                      iconSplashBackground,
                                                ),
                                              ),
                                            ),
                                          Center(
                                            child: Transform.translate(
                                              offset:
                                                  Offset(horizontalOffset, 50),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 100,
                                                    child: Stack(
                                                      children: [
                                                        GestureDetector(
                                                          behavior:
                                                              HitTestBehavior
                                                                  .opaque,
                                                          onTap: () async {
                                                            if (controller
                                                                    .userResponseModel
                                                                    ?.value
                                                                    .data
                                                                    ?.unlockedTask ==
                                                                controller
                                                                    .userResponseModel
                                                                    ?.value
                                                                    .data
                                                                    ?.milestoneData?[
                                                                        index]
                                                                    ?.taskNumber) {
                                                              if (controller
                                                                      .userResponseModel
                                                                      ?.value
                                                                      .data
                                                                      ?.milestoneData?[
                                                                          index]
                                                                      ?.attempted ==
                                                                  false) {
                                                                await Get.toNamed(
                                                                    AppRoutes
                                                                        .taskDetail,
                                                                    arguments: {
                                                                      "id": controller
                                                                          .userResponseModel
                                                                          ?.value
                                                                          .data
                                                                          ?.milestoneData?[
                                                                              index]
                                                                          ?.sId,
                                                                      "type": controller
                                                                          .userResponseModel
                                                                          ?.value
                                                                          .data
                                                                          ?.milestoneData?[
                                                                              index]
                                                                          ?.taskType
                                                                    });
                                                                controller
                                                                    .currentpage
                                                                    .value = 1;
                                                                controller
                                                                    .GetHomeDetail();
                                                              } else {
                                                                Get.closeAllSnackbars();
                                                                Get.snackbar(
                                                                  'Warning',
                                                                  "strTaskDoNotSubmitted"
                                                                      .tr,
                                                                  backgroundColor: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.5),
                                                                );
                                                              }
                                                            } else {
                                                              Get.snackbar(
                                                                'Warning',
                                                                "strTaskNotUnlock"
                                                                    .tr,
                                                                backgroundColor:
                                                                    Colors.white
                                                                        .withOpacity(
                                                                            0.5),
                                                              );
                                                            }
                                                          },
                                                          child: Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          12),
                                                              width: 100,
                                                              height: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: controller
                                                                            .userResponseModel
                                                                            ?.value
                                                                            .data
                                                                            ?.milestoneData?[
                                                                                index]
                                                                            ?.attempted ==
                                                                        true
                                                                    ? AppColors
                                                                        .clickTextColor
                                                                    : AppColors
                                                                        .smalltextColor,
                                                                shape: BoxShape
                                                                    .circle,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: controller.userResponseModel?.value.data?.milestoneData?[index]?.attempted ==
                                                                            true
                                                                        ? AppColors
                                                                            .darkRed
                                                                        : AppColors
                                                                            .darkgrey,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            5),
                                                                    blurRadius:
                                                                        0,
                                                                  ),
                                                                ],
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child:
                                                                  Image.asset(
                                                                controller
                                                                            .userResponseModel
                                                                            ?.value
                                                                            .data
                                                                            ?.milestoneData?[
                                                                                index]
                                                                            ?.taskType ==
                                                                        "PROFILE_PIC"
                                                                    ? profiletask
                                                                    : controller.userResponseModel?.value.data?.milestoneData?[index]?.taskType ==
                                                                            "QUIZ"
                                                                        ? quizTask
                                                                        : controller.userResponseModel?.value.data?.milestoneData?[index]?.taskType == "PORT_BIO" ||
                                                                                controller.userResponseModel?.value.data?.milestoneData?[index]?.taskType == "PORT_IMAGE" ||
                                                                                controller.userResponseModel?.value.data?.milestoneData?[index]?.taskType == "SET_CARD" ||
                                                                                controller.userResponseModel?.value.data?.milestoneData?[index]?.taskType == "PORT_INTRO_VIDEO"
                                                                            ? CvTask
                                                                            : controller.userResponseModel?.value.data?.milestoneData?[index]?.taskType == "WATCH_VIDEO"
                                                                                ? videoTask
                                                                                : controller.userResponseModel?.value.data?.milestoneData?[index]?.taskType == "TEXT"
                                                                                    ? texttask
                                                                                    : controller.userResponseModel?.value.data?.milestoneData?[index]?.taskType == "UPLOAD"
                                                                                        ? uploadTask
                                                                                        : controller.userResponseModel?.value.data?.milestoneData?[index]?.taskType == "DOWNLOAD_FILE"
                                                                                            ? downloadTask
                                                                                            : controller.userResponseModel?.value.data?.milestoneData?[index]?.taskType == "CHECK_BOX"
                                                                                                ? DoneTask
                                                                                                : controller.userResponseModel?.value.data?.milestoneData?[index]?.taskType == "CALENDLY"
                                                                                                    ? CalendlyTask
                                                                                                    : controller.userResponseModel?.value.data?.milestoneData?[index]?.taskType == "LINK"
                                                                                                        ? linktask
                                                                                                        : jobtask,
                                                                height: 30,
                                                              )),
                                                        ),
                                                        Positioned(
                                                          bottom: 3,
                                                          left: 20,
                                                          child: Container(
                                                            height: 30,
                                                            width: 60,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        iconCloud))),
                                                            child: Center(
                                                              child: TextView(
                                                                text: controller
                                                                        .userResponseModel
                                                                        ?.value
                                                                        .data
                                                                        ?.milestoneData?[
                                                                            index]
                                                                        ?.taskNumber
                                                                        ?.toString() ??
                                                                    "",
                                                              ).marginOnly(
                                                                  top: 10),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (controller
                                                          .userResponseModel
                                                          ?.value
                                                          .data
                                                          ?.milestoneData?[
                                                              index]
                                                          ?.attempted ==
                                                      true)
                                                    CustomArcStarRating(
                                                      starCount: 3,
                                                      rating: controller
                                                              .userResponseModel
                                                              ?.value
                                                              .data
                                                              ?.milestoneData?[
                                                                  index]
                                                              ?.rating
                                                              ?.toDouble() ??
                                                          0.0,
                                                      starSize: 20.0,
                                                      arcRadius: 15.0,
                                                      filledColor:
                                                          Colors.orange,
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          if (showRightIcon && index != 0)
                                            AnimatedPositioned(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeInOut,
                                              right: showRightIcon ? 20 : -100,
                                              child: AnimatedOpacity(
                                                opacity:
                                                    showRightIcon ? 1.0 : 0.0,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                child: FloatingIcon(
                                                  iconPath:
                                                      iconSplashBackground,
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 100,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }

  Widget CustomArcStarRating({
    required int starCount,
    required double rating,
    required double starSize,
    required double arcRadius,
    required Color filledColor,
  }) {
    return SizedBox(
      height: starSize + arcRadius, // Accommodate downward arc
      width: starSize * starCount * 1.5, // Width for star spacing
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(starCount, (index) {
          // Calculate angle for downward arc, centered
          double angle = (index - (starCount - 1) / 2) * (pi / starCount);
          // Adjust vertical position to create downward arc (first and third up, second down)
          double verticalOffset = arcRadius * cos(angle).abs();
          return Positioned(
            left:
                starSize * 1.5 * index + starSize * 0.25, // Horizontal spacing
            top: verticalOffset, // Downward arc positioning
            child: Icon(
              Icons.star,
              size: starSize,
              color: index < rating ? filledColor : Colors.grey,
            ),
          );
        }),
      ),
    );
  }

  // _topHeader remains unchanged
  Widget _topHeader(BuildContext context, controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  controller.isLoading.value == false
                      ? Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red, width: 2),
                          ),
                          child:
                              controller.userResponseModel?.value.data.image !=
                                      null
                                  ? NetworkImageWidget(
                                      imageWidth: 30,
                                      imageHeight: 30,
                                      imageUrl: controller
                                          .userResponseModel?.value.data.image,
                                      radiusAll: 30,
                                      imageFitType: BoxFit.cover,
                                    )
                                  : CircleAvatar(
                                      radius: 15,
                                      backgroundColor: AppColors.whiteColor,
                                      child: Icon(
                                        Icons.person,
                                        color: AppColors.clickTextColor,
                                      ),
                                    ),
                        )
                      : SizedBox(),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "${'strWelcome'.tr} ${controller.userResponseModel?.value?.data?.fullName ?? ""}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'minorksans',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.NotificationScreen);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        iconHomeBell,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "strJourney".tr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: AppColors.clickTextColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        iconHomeCalender,
                        width: 22,
                        height: 22,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "${controller.userResponseModel?.value?.data?.planName ?? ""}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.clickTextColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${controller.userResponseModel?.value?.data?.milestone?.toString() ?? "0"}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -15,
                        right: -5,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: Center(
                            child: Image.asset(
                              iconWinner,
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: ((controller.userResponseModel?.value?.data
                                            ?.percentage ??
                                        0) /
                                    100)
                                ?.toDouble() ??
                            0.0,
                        backgroundColor: Colors.white,
                        color: AppColors.clickTextColor,
                        minHeight: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

import 'package:disstrikt/app/core/widget/asset_image_widget.dart';

import 'package:disstrikt/app/modules/jobs/controllers/jobscreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/custom_text_field.dart';
import '../../../core/widget/text_view.dart';
import '../../../routes/app_routes.dart';
import '../../auth/models/requestmodels/RequestModel.dart';

class Jobscreen extends StatelessWidget {
  const Jobscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobscreenController>(
      init: JobscreenController(),
      builder: (controller) {
        String _formatDate(String? dateString) {
          if (dateString == null || dateString.isEmpty) {
            return "No date available";
          }
          try {
            final dateTime = DateTime.parse(dateString).toLocal();
            final formatter = DateFormat('dd MMM yyyy, hh:mm a');
            return formatter.format(dateTime);
          } catch (e) {
            return "Invalid date";
          }
        }

        Widget _buildFilterContent(
            BuildContext context, JobscreenController controller) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              padding: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(20.0),
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.clickTextColor,
                    width: 5.0,
                  ),
                  right: BorderSide(
                    color: AppColors.clickTextColor,
                    width: 5.0,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: "strFilters".tr,
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        color: AppColors.blackColor,
                        fontFamily: "minorksans",
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 4,
                    ).marginOnly(top: 10),
                    SizedBox(height: 10.0),
                    TextView(
                      text: "sortBy".tr, // Updated to "Sort By"
                      textAlign: TextAlign.start,
                      textStyle: const TextStyle(
                        color: AppColors.blackColor,
                        fontFamily: "minorksans",
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 4,
                    ),
                    SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap:
                          true, // Ensure GridView takes only needed space
                      physics:
                          NeverScrollableScrollPhysics(), // Disable GridView scrolling
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 items per row
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 3, // Adjust for wider items
                      ),
                      itemCount: controller.sortOptions.length,
                      itemBuilder: (context, index) {
                        final sortOption = controller.sortOptions[index];
                        return Obx(() => GestureDetector(
                              onTap: () {
                                if (controller.sortBy.value == sortOption) {
                                  controller.sortBy.value = "";
                                } else {
                                  controller.sortBy.value = sortOption;
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AssetImageWidget(
                                    controller.sortBy.value == sortOption
                                        ? iconSelectIcon
                                        : iconUnSelectIcon,
                                    imageWidth: 20,
                                    imageHeight: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: TextView(
                                      maxLines: 2,
                                      text: sortOption, // Translate if needed
                                      textStyle: TextStyle(
                                        color: controller.sortBy.value ==
                                                sortOption
                                            ? AppColors.blackColor
                                            : AppColors.greyshadetext,
                                        fontFamily: "Kodchasan",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      },
                    ),
                    SizedBox(height: 10),
                    Divider(color: AppColors.ModalDivider),
                    TextView(
                      text: "strGender".tr,
                      textAlign: TextAlign.start,
                      textStyle: const TextStyle(
                        color: AppColors.blackColor,
                        fontFamily: "minorksans",
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 4,
                    ),
                    SizedBox(height: 10),
                    Obx(() => Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (controller.gender.value == "strMale".tr) {
                                    controller.gender.value = "";
                                  } else {
                                    controller.gender.value = "strMale".tr;
                                  }
                                  controller.update();
                                },
                                child: Row(
                                  children: [
                                    AssetImageWidget(
                                      controller.gender.value == "strMale".tr
                                          ? iconSelectIcon
                                          : iconUnSelectIcon,
                                      imageWidth: 20,
                                      imageHeight: 20,
                                    ),
                                    SizedBox(width: 10),
                                    TextView(
                                      text: "strMale".tr,
                                      textStyle: TextStyle(
                                        color: controller.gender.value ==
                                                "strMale".tr
                                            ? AppColors.blackColor
                                            : AppColors.greyshadetext,
                                        fontFamily: "Kodchasan",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (controller.gender.value ==
                                      "strFemale".tr) {
                                    controller.gender.value = "";
                                  } else {
                                    controller.gender.value = "strFemale".tr;
                                  }

                                  controller.update();
                                },
                                child: Row(
                                  children: [
                                    AssetImageWidget(
                                      controller.gender.value == "strFemale".tr
                                          ? iconSelectIcon
                                          : iconUnSelectIcon,
                                      imageWidth: 20,
                                      imageHeight: 20,
                                    ),
                                    SizedBox(width: 10),
                                    TextView(
                                      text: "strFemale".tr,
                                      textStyle: TextStyle(
                                        color: controller.gender.value ==
                                                "strFemale".tr
                                            ? AppColors.blackColor
                                            : AppColors.greyshadetext,
                                        fontFamily: "Kodchasan",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: 10),
                    Divider(color: AppColors.ModalDivider),
                    TextView(
                      text: "strMinimumAge".tr,
                      textAlign: TextAlign.start,
                      textStyle: const TextStyle(
                        color: AppColors.blackColor,
                        fontFamily: "minorksans",
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 4,
                    ),
                    SizedBox(height: 10),
                    TextFieldWidget(
                      hint: "strMinimumAge".tr,
                      hintStyle: TextStyle(
                        color: AppColors.greyshadetext,
                        fontFamily: "Kodchasan",
                      ),
                      textColors: Colors.black,
                      textController: controller.age,
                      fillColor: Colors.white.withOpacity(0.4),
                      color: Colors.black,
                      borderColor: AppColors.ModalDivider,
                      courserColor: AppColors.buttonColor,
                      maxLength: 3,
                      inputType: TextInputType.number,
                    ),
                    SizedBox(height: 20),

                    // Uncomment and update buttons if needed
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButtonWidget(
                            buttonBgColor: Colors.transparent,
                            buttonRadius: 8,
                            isOutlined: true,
                            borderColor: Colors.black,
                            buttonText: "strPhotoCancel".tr,
                            buttonTextStyle: TextStyle(
                              fontSize: 12,
                              color: AppColors.blackColor,
                              fontFamily: "Kodchasan",
                              fontWeight: FontWeight.w600,
                            ),
                            textColor: AppColors.whiteColor,
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: MaterialButtonWidget(
                            buttonBgColor: AppColors.clickTextColor,
                            buttonRadius: 8,
                            buttonText:
                                "strApply".tr, // Updated to Apply Filters
                            buttonTextStyle: TextStyle(
                              fontSize: 12,
                              color: AppColors.whiteColor,
                              fontFamily: "Kodchasan",
                              fontWeight: FontWeight.w600,
                            ),
                            textColor: AppColors.whiteColor,
                            onPressed: () {
                              controller
                                  .resetAndFetchJobs(); // Apply filters and fetch jobs
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ).marginSymmetric(horizontal: 20),
              ),
            ),
          );
        }

        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.buttonColor,
          child: Scaffold(
            backgroundColor: AppColors.buttonColor.withOpacity(0.3),
            body: SafeArea(
              child: Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(
                              text: "strJobBord".tr,
                              textAlign: TextAlign.start,
                              textStyle: const TextStyle(
                                color: AppColors.blackColor,
                                fontFamily: "minorksans",
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 4,
                            ).marginSymmetric(horizontal: 20, vertical: 10),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: Get.context!,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      child: _buildFilterContent(
                                          context, controller),
                                    );
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextView(
                                      text: "strFilters".tr,
                                      textStyle: TextStyle(
                                        color: AppColors.blackColor,
                                        fontFamily: "Kodchasan",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.filter_list_rounded,
                                    size: 25,
                                  ),
                                ],
                              ).marginSymmetric(horizontal: 30),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 50,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller.applied.value = false;
                                  controller.resetAndFetchJobs();
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: controller.applied.value
                                          ? AppColors.whiteColor
                                          : AppColors.clickTextColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                      child: TextView(
                                    text: "strNewJobs".tr,
                                    textStyle: TextStyle(
                                      color: controller.applied.value == false
                                          ? AppColors.whiteColor
                                          : AppColors.greyshadetext,
                                      fontFamily: "Kodchasan",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller.applied.value = true;
                                  controller.resetAndFetchJobs();
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: controller.applied.value
                                          ? AppColors.clickTextColor
                                          : AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                      child: TextView(
                                    text: "strApplyJobs".tr,
                                    textStyle: TextStyle(
                                      color: controller.applied.value
                                          ? AppColors.whiteColor
                                          : AppColors.greyshadetext,
                                      fontFamily: "Kodchasan",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).marginSymmetric(horizontal: 20),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Skeletonizer(
                          enabled: controller.loading
                              .value, // Skeleton effect active when loading is true
                          child: controller
                                      .userResponseModel?.data?.data?.length ==
                                  0
                              ? Center(
                                  child: TextView(
                                      text: "strNoJobsFound".tr,
                                      textStyle: TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontFamily: "Kodchasan",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      )),
                                )
                              : ListView.builder(
                                  controller: controller.scrollController,
                                  itemCount: controller.loading.value
                                      ? 10 // Show 10 skeleton items during loading
                                      : (controller.userResponseModel?.data
                                                  ?.data?.length ??
                                              0) +
                                          (controller.isLoadingMore.value
                                              ? controller.pageSize
                                              : 0),
                                  itemBuilder: (context, index) {
                                    // Show skeleton placeholders during loading
                                    if (controller.loading.value) {
                                      return Skeleton.leaf(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: AppColors.whiteColor
                                                .withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.buttonColor),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Skeleton.replace(
                                                child: TextView(
                                                  maxLines: 4,
                                                  text: "Placeholder Title",
                                                  textStyle: TextStyle(
                                                    color: AppColors.blackColor,
                                                    fontFamily: "minorksans",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Skeleton.replace(
                                                child: TextView(
                                                  maxLines: 5,
                                                  text:
                                                      "Placeholder Description",
                                                  textStyle: TextStyle(
                                                    color:
                                                        AppColors.greyshadetext,
                                                    fontFamily: "kodchasan",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Skeleton.replace(
                                                    child: AssetImageWidget(
                                                      iconBussinessName,
                                                      imageWidth: 20,
                                                      imageHeight: 20,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Skeleton.replace(
                                                    child: TextView(
                                                      maxLines: 2,
                                                      text:
                                                          "Placeholder Company",
                                                      textStyle: TextStyle(
                                                        color: AppColors
                                                            .greyshadetext,
                                                        fontFamily: "kodchasan",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Skeleton.replace(
                                                    child: AssetImageWidget(
                                                      iconBussinessLocation,
                                                      imageWidth: 20,
                                                      imageHeight: 20,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Skeleton.replace(
                                                    child: TextView(
                                                      maxLines: 2,
                                                      text:
                                                          "Placeholder Location",
                                                      textStyle: TextStyle(
                                                        color: AppColors
                                                            .greyshadetext,
                                                        fontFamily: "kodchasan",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Skeleton.replace(
                                                    child: AssetImageWidget(
                                                      iconCalenderDate,
                                                      imageWidth: 20,
                                                      imageHeight: 20,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Skeleton.replace(
                                                    child: TextView(
                                                      maxLines: 2,
                                                      text: "Placeholder Date",
                                                      textStyle: TextStyle(
                                                        color: AppColors
                                                            .greyshadetext,
                                                        fontFamily: "kodchasan",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Skeleton.replace(
                                                      child: Container(
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .buttonColor),
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                        child: Center(
                                                          child: TextView(
                                                            text:
                                                                "strDetail".tr,
                                                            textStyle:
                                                                TextStyle(
                                                              color: AppColors
                                                                  .blackColor,
                                                              fontFamily:
                                                                  "kodchasan",
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Skeleton.replace(
                                                      child: Container(
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .buttonColor),
                                                          color: AppColors
                                                              .buttonColor,
                                                        ),
                                                        child: Center(
                                                          child: TextView(
                                                            text: "strApply".tr,
                                                            textStyle:
                                                                TextStyle(
                                                              color: AppColors
                                                                  .blackColor,
                                                              fontFamily:
                                                                  "kodchasan",
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ).marginSymmetric(
                                              horizontal: 20, vertical: 20),
                                        ),
                                      );
                                    }
                                    // Handle pagination placeholders
                                    if (controller.isLoadingMore.value &&
                                        index >=
                                            (controller.userResponseModel?.data
                                                    ?.data?.length ??
                                                0)) {
                                      return Skeleton.leaf(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: AppColors.whiteColor
                                                .withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.buttonColor),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Skeleton.replace(
                                                child: TextView(
                                                  maxLines: 4,
                                                  text: "Placeholder Title",
                                                  textStyle: TextStyle(
                                                    color: AppColors.blackColor,
                                                    fontFamily: "minorksans",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Skeleton.replace(
                                                child: TextView(
                                                  maxLines: 5,
                                                  text:
                                                      "Placeholder Description",
                                                  textStyle: TextStyle(
                                                    color:
                                                        AppColors.greyshadetext,
                                                    fontFamily: "kodchasan",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              // ... other placeholder widgets (same as above)
                                            ],
                                          ).marginSymmetric(
                                              horizontal: 20, vertical: 20),
                                        ),
                                      );
                                    }
                                    // Render actual job items
                                    return GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor
                                              .withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.buttonColor),
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
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: TextView(
                                                    maxLines: 4,
                                                    text: controller
                                                            .userResponseModel
                                                            ?.data
                                                            ?.data?[index]
                                                            ?.title ??
                                                        "",
                                                    textStyle: TextStyle(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontFamily: "minorksans",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                                controller
                                                            .userResponseModel
                                                            ?.data
                                                            ?.data?[index]
                                                            ?.type ==
                                                        "APPLIED"
                                                    ? Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: AppColors
                                                                .statusColor),
                                                        child: TextView(
                                                          maxLines: 1,
                                                          text: controller
                                                                  .userResponseModel
                                                                  ?.data
                                                                  ?.data?[index]
                                                                  ?.status ??
                                                              "",
                                                          textStyle: TextStyle(
                                                            color: AppColors
                                                                .blackColor,
                                                            fontFamily:
                                                                "kodchasan",
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ).marginSymmetric(
                                                            horizontal: 10,
                                                            vertical: 2),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            TextView(
                                              maxLines: 5,
                                              text: controller
                                                      .userResponseModel
                                                      ?.data
                                                      ?.data?[index]
                                                      ?.description ??
                                                  "",
                                              textStyle: TextStyle(
                                                color: AppColors.greyshadetext,
                                                fontFamily: "kodchasan",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                AssetImageWidget(
                                                  iconBussinessName,
                                                  imageWidth: 20,
                                                  imageHeight: 20,
                                                ),
                                                SizedBox(width: 10),
                                                TextView(
                                                  maxLines: 2,
                                                  text: controller
                                                          .userResponseModel
                                                          ?.data
                                                          ?.data?[index]
                                                          ?.companyName ??
                                                      "",
                                                  textStyle: TextStyle(
                                                    color:
                                                        AppColors.greyshadetext,
                                                    fontFamily: "kodchasan",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                AssetImageWidget(
                                                  iconBussinessLocation,
                                                  imageWidth: 20,
                                                  imageHeight: 20,
                                                ),
                                                SizedBox(width: 10),
                                                Flexible(
                                                  child: TextView(
                                                    maxLines: 2,
                                                    text: controller
                                                            .userResponseModel
                                                            ?.data
                                                            ?.data?[index]
                                                            ?.location ??
                                                        "",
                                                    textStyle: TextStyle(
                                                      color: AppColors
                                                          .greyshadetext,
                                                      fontFamily: "kodchasan",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                AssetImageWidget(
                                                  iconCalenderDate,
                                                  imageWidth: 20,
                                                  imageHeight: 20,
                                                ),
                                                SizedBox(width: 10),
                                                TextView(
                                                  maxLines: 2,
                                                  text: _formatDate(
                                                    controller
                                                            .userResponseModel
                                                            ?.data
                                                            ?.data?[index]
                                                            ?.date ??
                                                        "",
                                                  ),
                                                  textStyle: TextStyle(
                                                    color:
                                                        AppColors.greyshadetext,
                                                    fontFamily: "kodchasan",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      await Get.toNamed(
                                                          AppRoutes
                                                              .jobDetailScreen,
                                                          arguments: {
                                                            "ID": controller
                                                                .userResponseModel
                                                                ?.data
                                                                ?.data?[index]
                                                                ?.sId
                                                          });
                                                      controller
                                                          .GetProfileDetail();
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .buttonColor),
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      child: Center(
                                                        child: TextView(
                                                          text: "strDetail".tr,
                                                          textStyle: TextStyle(
                                                            color: AppColors
                                                                .blackColor,
                                                            fontFamily:
                                                                "kodchasan",
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                controller
                                                            .userResponseModel
                                                            ?.data
                                                            ?.data?[index]
                                                            ?.type ==
                                                        "APPLIED"
                                                    ? SizedBox()
                                                    : Expanded(
                                                        child: Obx(
                                                            () =>
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    controller
                                                                            .index =
                                                                        index;
                                                                    if (controller
                                                                            .isloading
                                                                            .value ==
                                                                        false) {
                                                                      Map<String,
                                                                              dynamic>
                                                                          requestModel =
                                                                          AuthRequestModel
                                                                              .JobApplyRequestModel(
                                                                        jobId: controller
                                                                            .userResponseModel
                                                                            ?.data
                                                                            ?.data?[index]
                                                                            .sId,
                                                                      );
                                                                      controller.handleSubmit(
                                                                          requestModel,
                                                                          index);
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 50,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      border: Border.all(
                                                                          color:
                                                                              AppColors.buttonColor),
                                                                      color: AppColors
                                                                          .buttonColor,
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child: controller.isloading.value &&
                                                                              controller.index == index
                                                                          ? SizedBox(
                                                                              height: 20,
                                                                              width: 20,
                                                                              child: CircularProgressIndicator(
                                                                                color: Colors.black,
                                                                              ))
                                                                          : TextView(
                                                                              text: "strApply".tr,
                                                                              textStyle: TextStyle(
                                                                                color: AppColors.blackColor,
                                                                                fontFamily: "kodchasan",
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w800,
                                                                              ),
                                                                            ),
                                                                    ),
                                                                  ),
                                                                )),
                                                      ),
                                              ],
                                            ),
                                          ],
                                        ).marginSymmetric(
                                            horizontal: 20, vertical: 20),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                      if (controller.isLoadingMore.value)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}

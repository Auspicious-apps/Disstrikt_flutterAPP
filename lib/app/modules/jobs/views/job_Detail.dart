import 'package:disstrikt/app/modules/jobs/controllers/JobDetail_controller.dart';
import 'package:disstrikt/app/modules/jobs/controllers/jobscreen_controller.dart';
import 'package:disstrikt/app/modules/jobs/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_colors.dart';

import '../../../core/values/app_values.dart';
import '../../../core/widget/annotated_region_widget.dart';

import '../../../core/widget/asset_image.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/text_view.dart';
import '../../auth/models/requestmodels/RequestModel.dart';

class JobDetail extends StatelessWidget {
  const JobDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobdetailController>(
      init: JobdetailController(),
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

        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.buttonColor,
          child: Scaffold(
            backgroundColor: AppColors.buttonColor.withOpacity(0.3),
            body: SafeArea(
              child: Obx(() => Skeletonizer(
                    enabled: controller.isLoading.value,
                    child: Column(
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
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
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
                              ),
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
                            ],
                          ).marginOnly(bottom: 10),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextView(
                                          maxLines: 2,
                                          text: controller.userResponseModel
                                                  ?.data?.companyName ??
                                              "",
                                          textStyle: TextStyle(
                                            color: AppColors.blackColor,
                                            fontFamily: "minorksans",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        controller.userResponseModel?.data
                                                    ?.type ==
                                                "APPLIED"
                                            ? Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color:
                                                        AppColors.statusColor),
                                                child: TextView(
                                                  maxLines: 1,
                                                  text: controller
                                                          .userResponseModel
                                                          ?.data
                                                          ?.status ??
                                                      "",
                                                  textStyle: TextStyle(
                                                    color: AppColors.blackColor,
                                                    fontFamily: "kodchasan",
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ).marginSymmetric(
                                                    horizontal: 10,
                                                    vertical: 2),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    TextView(
                                      maxLines: 4,
                                      text: controller
                                              .userResponseModel?.data?.title ??
                                          "",
                                      textStyle: TextStyle(
                                        color: AppColors.blackColor,
                                        fontFamily: "minorksans",
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                      ),
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
                                            text: controller.userResponseModel
                                                    ?.data?.location ??
                                                "",
                                            textStyle: TextStyle(
                                              color: AppColors.greyshadetext,
                                              fontFamily: "kodchasan",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
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
                                            controller.userResponseModel?.data
                                                    ?.date ??
                                                "",
                                          ),
                                          textStyle: TextStyle(
                                            color: AppColors.greyshadetext,
                                            fontFamily: "kodchasan",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextView(
                                            maxLines: 1,
                                            text: "strEstimatePay".tr,
                                            textStyle: TextStyle(
                                              color: AppColors.greyshadetext,
                                              fontFamily: "kodchasan",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          TextView(
                                            maxLines: 1,
                                            text:
                                                "${controller.userResponseModel?.data?.currency == "eur" ? "€" : "£"}${controller.userResponseModel?.data?.pay?.toStringAsFixed(2) ?? ""}",
                                            textStyle: TextStyle(
                                              color: AppColors.blackColor,
                                              fontFamily: "minorksans",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ]),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextView(
                                          maxLines: 1,
                                          text: "strAboutJob".tr,
                                          textStyle: TextStyle(
                                            color: AppColors.blackColor,
                                            fontFamily: "kodchasan",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        TextView(
                                          maxLines: 100,
                                          text: controller.userResponseModel
                                                  ?.data?.description ??
                                              "",
                                          textStyle: TextStyle(
                                            color: AppColors.greyshadetext,
                                            fontFamily: "kodchasan",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        TextView(
                                          maxLines: 1,
                                          text: "strEligibility".tr,
                                          textStyle: TextStyle(
                                            color: AppColors.blackColor,
                                            fontFamily: "kodchasan",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        TextView(
                                          maxLines: 2,
                                          text:
                                              "${"strAge".tr}: ${controller.userResponseModel?.data?.minAge?.toString() ?? ""}-${controller.userResponseModel?.data?.maxAge?.toString() ?? ""} ${"strYearsOld".tr}",
                                          textStyle: TextStyle(
                                            color: AppColors.greyshadetext,
                                            fontFamily: "kodchasan",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        TextView(
                                          maxLines: 2,
                                          text:
                                              "${"strGender".tr}: ${controller.userResponseModel?.data?.gender?.toLowerCase() ?? ""}-${"stridentify".tr}",
                                          textStyle: TextStyle(
                                            color: AppColors.greyshadetext,
                                            fontFamily: "kodchasan",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ).marginSymmetric(vertical: 5),
                                        TextView(
                                          maxLines: 2,
                                          text:
                                              "${"strHieght".tr}: ${"strMinimum".tr} ${controller.userResponseModel?.data?.minHeightInCm?.toString() ?? "0"} Cm",
                                          textStyle: TextStyle(
                                            color: AppColors.greyshadetext,
                                            fontFamily: "kodchasan",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ).marginSymmetric(horizontal: 20, vertical: 20)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        controller.userResponseModel?.data?.type == "APPLIED"
                            ? SizedBox()
                            : Obx(() => MaterialButtonWidget(
                                  isloading: controller.isloading.value,
                                  buttonBgColor: AppColors.buttonColor,
                                  buttonRadius: 8,
                                  buttonText: "strApplyNow".tr,
                                  textColor: AppColors.blackColor,
                                  iconWidget: Icon(Icons.arrow_forward_sharp,
                                      color: AppColors.backgroundColor),
                                  onPressed: () async {
                                    if (controller.isloading.value == false) {
                                      Map<String, dynamic> requestModel =
                                          AuthRequestModel.JobApplyRequestModel(
                                        jobId: controller.Id.value,
                                      );
                                      controller.handleSubmit(requestModel);
                                    }
                                  },
                                ).marginSymmetric(
                                    vertical: 20, horizontal: 20)),
                      ],
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}

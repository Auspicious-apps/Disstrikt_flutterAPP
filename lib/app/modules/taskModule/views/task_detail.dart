import 'dart:io';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:disstrikt/app/core/widget/asset_image_widget.dart';
import 'package:disstrikt/app/data/repository/endpoint.dart';
import 'package:disstrikt/app/modules/taskModule/controllers/taskdetail_controller.dart';
import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:dotted_border/dotted_border.dart'
    show DottedBorder, RectDottedBorderOptions, RoundedRectDottedBorderOptions;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/custom_text_field.dart';
import '../../../core/widget/text_view.dart';
import '../../auth/models/requestmodels/RequestModel.dart';
import '../models/ResponseModels/QuizRequest.dart';

class TaskDetail extends StatelessWidget {
  const TaskDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskdetailController>(
      init: TaskdetailController(),
      builder: (controller) {
        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.dark,
          statusBarColor: AppColors.buttonColor.withOpacity(0.2),
          child: Scaffold(
            backgroundColor: AppColors.buttonColor.withOpacity(0.4),
            body: Obx(() => Skeletonizer(
                  enabled: controller.isLoading.value,
                  child: Column(
                    children: [
                      Expanded(
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
                                  width: Get.width,
                                  height: Get.height * 0.08,
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.buttonColor.withOpacity(0.0),
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
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: Center(
                                          child: Icon(
                                            Icons.arrow_back_ios_new_sharp,
                                            size: 20,
                                          ),
                                        ),
                                      ).marginOnly(left: margin_10),
                                      TextView(
                                        text:
                                            "${"strTabTask".tr} ${controller.taskDetailModel?.value.data?.taskNumber ?? ""}",
                                        textStyle: const TextStyle(
                                          color: AppColors.blackColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ).marginSymmetric(
                                          horizontal: 10, vertical: 10),
                                    ],
                                  ),
                                ),
                              ),
                              if (controller.taskDetailModel?.value?.data
                                          ?.answerType ==
                                      "DONE" &&
                                  controller.taskDetailModel?.value?.data
                                          ?.taskType !=
                                      "WATCH_VIDEO" &&
                                  controller.taskDetailModel?.value?.data
                                          ?.taskType !=
                                      "TEXT" &&
                                  controller.taskDetailModel?.value?.data
                                          ?.taskType !=
                                      "DOWNLOAD_FILE" &&
                                  controller.taskDetailModel?.value?.data
                                          ?.taskType !=
                                      "LINK")
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: Get.height * 0.7,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: TextView(
                                            maxLines: 100,
                                            text:
                                                "${controller.taskDetailModel?.value.data?.title}",
                                            textStyle: const TextStyle(
                                              color: AppColors.blackColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ).marginOnly(bottom: 5),
                                        TextView(
                                          maxLines: 10000000,
                                          textAlign: TextAlign.center,
                                          text:
                                              "${controller.taskDetailModel?.value.data?.description}",
                                          textStyle: const TextStyle(
                                            color: AppColors.greyshadetext,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ).marginSymmetric(horizontal: 20),
                                  ),
                                ),
                              if (controller.taskDetailModel?.value?.data
                                      ?.answerType ==
                                  "QUIZ")
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: Get.height * 0.7,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          QuizTaskModel,
                                          height: 100,
                                          width: 100,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: TextView(
                                            maxLines: 100,
                                            text:
                                                "${controller.taskDetailModel?.value.data?.title}",
                                            textStyle: const TextStyle(
                                              color: AppColors.blackColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ).marginOnly(bottom: 5),
                                        TextView(
                                          maxLines: 10000000,
                                          textAlign: TextAlign.center,
                                          text:
                                              "${controller.taskDetailModel?.value.data?.description?.isNotEmpty == true ? controller.taskDetailModel?.value.data?.description : "Please answer the following questions. Note that this quiz would also affect the overall level of your profile."}",
                                          textStyle: const TextStyle(
                                            color: AppColors.greyshadetext,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ).marginSymmetric(horizontal: 20),
                                  ),
                                ),
                              if (controller.taskDetailModel?.value?.data
                                          ?.answerType ==
                                      "DONE" &&
                                  controller.taskDetailModel?.value?.data
                                          ?.taskType ==
                                      "WATCH_VIDEO")
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: TextView(
                                        maxLines: 100,
                                        text:
                                            "${controller.taskDetailModel?.value.data?.title}",
                                        textStyle: const TextStyle(
                                          color: AppColors.blackColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ).marginOnly(bottom: 5),
                                    TextView(
                                      maxLines: 10000000,
                                      textAlign: TextAlign.center,
                                      text:
                                          "${controller.taskDetailModel?.value.data?.description}",
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    if (controller.videoWatch.value == false &&
                                        controller.isControllerValid.value)
                                      Container(
                                        width: Get.width,
                                        child: AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: BetterPlayer(
                                            controller: controller
                                                .betterPlayerController!,
                                          ),
                                        ),
                                      ).marginOnly(top: 20, bottom: 20)
                                  ],
                                ).marginSymmetric(horizontal: 20),
                              if (controller.taskDetailModel?.value?.data
                                              ?.answerType ==
                                          "UPLOAD_FILE" &&
                                      controller.taskDetailModel?.value?.data
                                              ?.taskType ==
                                          "TEXT" ||
                                  controller.taskDetailModel?.value?.data
                                              ?.answerType ==
                                          "UPLOAD_FILE" &&
                                      controller.taskDetailModel?.value?.data
                                              ?.taskType ==
                                          "DOWNLOAD_FILE")
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: TextView(
                                        maxLines: 100,
                                        text:
                                            "${controller.taskDetailModel?.value.data?.title}",
                                        textStyle: const TextStyle(
                                          color: AppColors.blackColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ).marginOnly(bottom: 5),
                                    TextView(
                                      maxLines: 10000000,
                                      textAlign: TextAlign.center,
                                      text:
                                          "${controller.taskDetailModel?.value.data?.description}",
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),

                                    controller.taskDetailModel?.value?.data
                                                ?.taskType ==
                                            "DOWNLOAD_FILE"
                                        ? ListView.builder(
                                            shrinkWrap:
                                                true, // important if inside Column/SingleChildScrollView
                                            physics:
                                                const NeverScrollableScrollPhysics(), // disable inner scroll if parent is scrollable
                                            itemCount: controller
                                                    .taskDetailModel
                                                    ?.value
                                                    .data
                                                    ?.link
                                                    ?.length ??
                                                0,
                                            itemBuilder: (context, index) {
                                              final link = controller
                                                  .taskDetailModel!
                                                  .value
                                                  .data!
                                                  .link![index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      // ensures text wraps properly
                                                      child: TextView(
                                                        maxLines: 4,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        text: link
                                                                ?.split("/")
                                                                ?.last ??
                                                            "",
                                                        textStyle:
                                                            const TextStyle(
                                                          color: AppColors
                                                              .greyshadetext,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "kodchasan",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final url =
                                                            "${imageBaseUrl}${link}" ??
                                                                "";

                                                        if (url.isNotEmpty) {
                                                          final uri =
                                                              Uri.parse(url);
                                                          if (await canLaunchUrl(
                                                              uri)) {
                                                            await launchUrl(uri,
                                                                mode: LaunchMode
                                                                    .externalApplication);
                                                          } else {
                                                            Get.snackbar(
                                                                "Error",
                                                                "Could not launch $url");
                                                          }
                                                        }
                                                      },
                                                      child: TextView(
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.start,
                                                        text: "strDownload".tr,
                                                        textStyle:
                                                            const TextStyle(
                                                          color: AppColors
                                                              .appBlueColor,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "kodchasan",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        : SizedBox(),

                                    TextView(
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                      text: "strUploadFile".tr,
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          1, // observable list of picked files
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () => _showFileDialog(
                                              context, controller),
                                          child: DottedBorder(
                                            options:
                                                RoundedRectDottedBorderOptions(
                                              dashPattern: [10, 4],
                                              color: AppColors.buttonColor,
                                              strokeWidth: 1,
                                              radius: Radius.circular(10),
                                            ),
                                            child: Container(
                                              width: Get.width,
                                              height: Get.height * 0.2,
                                              decoration: BoxDecoration(
                                                color: AppColors.whiteColor
                                                    .withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Obx(() {
                                                if ((controller.pickedFile.value
                                                            .length -
                                                        1) <
                                                    index) {
                                                  return Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        TextView(
                                                          text:
                                                              "SelectaFile".tr,
                                                          textStyle:
                                                              const TextStyle(
                                                            color: AppColors
                                                                .greyshadetext,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        TextView(
                                                          text: "strBrowse".tr,
                                                          textStyle:
                                                              const TextStyle(
                                                            color: AppColors
                                                                .appBlueColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  String fileName = controller
                                                      .pickedFile
                                                      .value![index]!
                                                      .path
                                                      .split('/')
                                                      .last;
                                                  return Stack(
                                                    children: [
                                                      // File details in center
                                                      Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                                Icons
                                                                    .insert_drive_file,
                                                                color: AppColors
                                                                    .appBlueColor,
                                                                size: 30),
                                                            const SizedBox(
                                                                height: 8),
                                                            SizedBox(
                                                              width: Get.width *
                                                                  0.7,
                                                              child: TextView(
                                                                maxLines: 2,
                                                                text: fileName,
                                                                textStyle:
                                                                    const TextStyle(
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      // Cross icon at top right
                                                      Positioned(
                                                        top: 8,
                                                        right: 8,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .pickedFile
                                                                .value
                                                                .removeAt(
                                                                    index);
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Colors.red
                                                                  .withOpacity(
                                                                      0.9),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4),
                                                            child: const Icon(
                                                              Icons.close,
                                                              size: 16,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              }),
                                            ),
                                          ).marginSymmetric(vertical: 10),
                                        );
                                      },
                                    ),
                                    // GestureDetector(
                                    //   onTap: () =>
                                    //       _showFileDialog(context, controller),
                                    //   child: DottedBorder(
                                    //     options: RoundedRectDottedBorderOptions(
                                    //       dashPattern: [10, 4],
                                    //       color: AppColors.buttonColor,
                                    //       strokeWidth: 1,
                                    //       radius: Radius.circular(10),
                                    //     ),
                                    //     child: Container(
                                    //       width: Get.width,
                                    //       height: Get.height * 0.2,
                                    //       decoration: BoxDecoration(
                                    //         color: AppColors.whiteColor
                                    //             .withOpacity(0.7),
                                    //         borderRadius:
                                    //             BorderRadius.circular(10),
                                    //       ),
                                    //       child: Obx(() {
                                    //         if ((controller.pickedFile.value
                                    //                     .length -
                                    //                 1) <
                                    //             1) {
                                    //           return Center(
                                    //             child: Column(
                                    //               mainAxisAlignment:
                                    //                   MainAxisAlignment.center,
                                    //               children: [
                                    //                 TextView(
                                    //                   text: "SelectaFile".tr,
                                    //                   textStyle:
                                    //                       const TextStyle(
                                    //                     color: AppColors
                                    //                         .greyshadetext,
                                    //                     fontSize: 14,
                                    //                     fontWeight:
                                    //                         FontWeight.w400,
                                    //                   ),
                                    //                 ),
                                    //                 TextView(
                                    //                   text: "strBrowse".tr,
                                    //                   textStyle:
                                    //                       const TextStyle(
                                    //                     color: AppColors
                                    //                         .appBlueColor,
                                    //                     fontSize: 14,
                                    //                     fontWeight:
                                    //                         FontWeight.w400,
                                    //                   ),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           );
                                    //         } else {
                                    //           String fileName = controller
                                    //                   .pickedFile
                                    //                   .value
                                    //                   .first!
                                    //                   .path
                                    //                   ?.split('/')
                                    //                   .last ??
                                    //               '';
                                    //           // String fileName = controller
                                    //           //     .pickedFile.value!.path
                                    //           //     .split('/')
                                    //           //     .last;
                                    //           return Stack(
                                    //             children: [
                                    //               // File details in center
                                    //               Center(
                                    //                 child: Column(
                                    //                   mainAxisAlignment:
                                    //                       MainAxisAlignment
                                    //                           .center,
                                    //                   children: [
                                    //                     const Icon(
                                    //                         Icons
                                    //                             .insert_drive_file,
                                    //                         color: AppColors
                                    //                             .appBlueColor,
                                    //                         size: 30),
                                    //                     const SizedBox(
                                    //                         height: 8),
                                    //                     SizedBox(
                                    //                       width:
                                    //                           Get.width * 0.7,
                                    //                       child: TextView(
                                    //                         maxLines: 2,
                                    //                         text: fileName,
                                    //                         textStyle:
                                    //                             const TextStyle(
                                    //                           color: AppColors
                                    //                               .blackColor,
                                    //                           fontSize: 14,
                                    //                           fontWeight:
                                    //                               FontWeight
                                    //                                   .w500,
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //
                                    //               // Cross icon at top right
                                    //               Positioned(
                                    //                 top: 8,
                                    //                 right: 8,
                                    //                 child: GestureDetector(
                                    //                   onTap: () {
                                    //                     controller
                                    //                         .pickedFile.value
                                    //                         .removeAt(0);
                                    //                   },
                                    //                   child: Container(
                                    //                     decoration:
                                    //                         BoxDecoration(
                                    //                       shape:
                                    //                           BoxShape.circle,
                                    //                       color: Colors.red
                                    //                           .withOpacity(0.9),
                                    //                     ),
                                    //                     padding:
                                    //                         const EdgeInsets
                                    //                             .all(4),
                                    //                     child: const Icon(
                                    //                       Icons.close,
                                    //                       size: 16,
                                    //                       color: Colors.white,
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           );
                                    //         }
                                    //       }),
                                    //     ),
                                    //   ).marginSymmetric(vertical: 10),
                                    // ),
                                    _writeSectionField(controller)
                                  ],
                                ).marginSymmetric(horizontal: 20),
                              if (controller.taskDetailModel?.value?.data
                                          ?.answerType ==
                                      "DONE" &&
                                  controller.taskDetailModel?.value?.data
                                          ?.taskType ==
                                      "TEXT")
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: TextView(
                                        maxLines: 100,
                                        text:
                                            "${controller.taskDetailModel?.value.data?.title}",
                                        textStyle: const TextStyle(
                                          color: AppColors.blackColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ).marginOnly(bottom: 5),
                                    TextView(
                                      maxLines: 10000000,
                                      textAlign: TextAlign.center,
                                      text:
                                          "${controller.taskDetailModel?.value.data?.description}",
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    _writeSectionField(controller)
                                  ],
                                ).marginSymmetric(horizontal: 20),
                              if (controller.taskDetailModel?.value?.data
                                          ?.answerType ==
                                      "DONE" &&
                                  controller.taskDetailModel?.value?.data
                                          ?.taskType ==
                                      "DOWNLOAD_FILE")
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: TextView(
                                        maxLines: 100,
                                        text:
                                            "${controller.taskDetailModel?.value.data?.title}",
                                        textStyle: const TextStyle(
                                          color: AppColors.blackColor,
                                          fontSize: 16,
                                          fontFamily: "minorksans",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ).marginOnly(bottom: 5),
                                    TextView(
                                      maxLines: 10000000,
                                      textAlign: TextAlign.center,
                                      text:
                                          "${controller.taskDetailModel?.value.data?.description}",
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontFamily: "kodchasan",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextView(
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      text: "strAttachment".tr,
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontFamily: "kodchasan",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap:
                                          true, // important if inside Column/SingleChildScrollView
                                      physics:
                                          const NeverScrollableScrollPhysics(), // disable inner scroll if parent is scrollable
                                      itemCount: controller.taskDetailModel
                                              ?.value.data?.link?.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        final link = controller.taskDetailModel!
                                            .value.data!.link![index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                // ensures text wraps properly
                                                child: TextView(
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  text:
                                                      link?.split("/")?.last ??
                                                          "",
                                                  textStyle: const TextStyle(
                                                    color:
                                                        AppColors.greyshadetext,
                                                    fontSize: 14,
                                                    fontFamily: "kodchasan",
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  final url =
                                                      "${imageBaseUrl}${link}" ??
                                                          "";

                                                  if (url.isNotEmpty) {
                                                    final uri = Uri.parse(url);
                                                    if (await canLaunchUrl(
                                                        uri)) {
                                                      await launchUrl(uri,
                                                          mode: LaunchMode
                                                              .externalApplication);
                                                    } else {
                                                      Get.snackbar("Error",
                                                          "Could not launch $url");
                                                    }
                                                  }
                                                },
                                                child: TextView(
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                  text: "strDownload".tr,
                                                  textStyle: const TextStyle(
                                                    color:
                                                        AppColors.appBlueColor,
                                                    fontSize: 14,
                                                    fontFamily: "kodchasan",
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ).marginSymmetric(horizontal: 20),
                              if (controller.taskDetailModel?.value?.data
                                      ?.answerType ==
                                  "CHECK_BOX")
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: TextView(
                                        maxLines: 100,
                                        text:
                                            "${controller.taskDetailModel?.value.data?.title}",
                                        textStyle: const TextStyle(
                                          color: AppColors.blackColor,
                                          fontSize: 16,
                                          fontFamily: "minorksans",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ).marginOnly(bottom: 5),
                                    TextView(
                                      maxLines: 10000000,
                                      textAlign: TextAlign.center,
                                      text:
                                          "${controller.taskDetailModel?.value.data?.description}",
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontFamily: "kodchasan",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextView(
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      text: "strSelectMultipleOptions".tr,
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontFamily: "kodchasan",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap:
                                          true, // important if inside Column/SingleChildScrollView
                                      physics:
                                          const BouncingScrollPhysics(), // disable inner scroll if parent is scrollable
                                      itemCount: controller.taskDetailModel
                                              ?.value.data?.checkbox?.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        final link = controller.taskDetailModel!
                                            .value.data!.checkbox![index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Obx(() => Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        if (controller
                                                            .checkboxValues
                                                            .value
                                                            .contains(link)) {
                                                          controller
                                                              .checkboxValues
                                                              .value
                                                              .remove(link);
                                                          controller
                                                              .checkboxValues
                                                              .refresh(); // Remove if already exists
                                                        } else {
                                                          controller
                                                              .checkboxValues
                                                              .value
                                                              .add(link);
                                                          controller
                                                              .checkboxValues
                                                              .refresh(); // Add if not exists
                                                        }
                                                      },
                                                      child: AssetImageWidget(
                                                        controller
                                                                .checkboxValues
                                                                .value
                                                                .contains(link)
                                                            ? CheckBoxFill
                                                            : CheckBoxBlank,
                                                        imageHeight: height_30,
                                                        imageWidth: width_30,
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    // ensures text wraps properly
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .whiteColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: TextView(
                                                        maxLines: 4,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        text: link,
                                                        textStyle:
                                                            const TextStyle(
                                                          color: AppColors
                                                              .greyshadetext,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "kodchasan",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ).paddingSymmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        );
                                      },
                                    ).marginSymmetric(vertical: 10),
                                  ],
                                ).marginSymmetric(horizontal: 20),
                              if (controller.taskDetailModel?.value?.data
                                              ?.answerType ==
                                          "UPLOAD_IMAGE" &&
                                      controller.taskDetailModel?.value?.data
                                              ?.taskType ==
                                          "TEXT" ||
                                  controller.taskDetailModel?.value?.data
                                              ?.answerType ==
                                          "UPLOAD_IMAGE" &&
                                      controller.taskDetailModel?.value?.data
                                              ?.taskType ==
                                          "SET_CARD")
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: TextView(
                                        maxLines: 100,
                                        text:
                                            "${controller.taskDetailModel?.value.data?.title}",
                                        textStyle: const TextStyle(
                                          color: AppColors.blackColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ).marginOnly(bottom: 5),
                                    TextView(
                                      maxLines: 10000000,
                                      textAlign: TextAlign.center,
                                      text:
                                          "${controller.taskDetailModel?.value.data?.description}",
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextView(
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                      text: "strUploadFile".tr,
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: controller
                                          .taskDetailModel?.value.data?.count
                                          ?.toInt(), // observable list of picked files
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                              type: FileType.image,
                                            );
                                            if (result != null) {
                                              var filePath =
                                                  result.files.single.path;
                                              debugPrint(
                                                  "Picked image: $filePath");
                                              controller.pickedFile.value
                                                  .add(File(filePath!));
                                            }
                                            controller.pickedFile.refresh();
                                          },
                                          child: DottedBorder(
                                            options:
                                                RoundedRectDottedBorderOptions(
                                              dashPattern: [10, 4],
                                              color: AppColors.buttonColor,
                                              strokeWidth: 1,
                                              radius: Radius.circular(10),
                                            ),
                                            child: Container(
                                              width: Get.width,
                                              height: Get.height * 0.2,
                                              decoration: BoxDecoration(
                                                color: AppColors.whiteColor
                                                    .withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Obx(() {
                                                if ((controller.pickedFile.value
                                                            .length -
                                                        1) <
                                                    index) {
                                                  return Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        TextView(
                                                          text:
                                                              "SelectaFile".tr,
                                                          textStyle:
                                                              const TextStyle(
                                                            color: AppColors
                                                                .greyshadetext,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        TextView(
                                                          text: "strBrowse".tr,
                                                          textStyle:
                                                              const TextStyle(
                                                            color: AppColors
                                                                .appBlueColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  String fileName = controller
                                                      .pickedFile
                                                      .value![index]!
                                                      .path
                                                      .split('/')
                                                      .last;
                                                  return Stack(
                                                    children: [
                                                      // File details in center
                                                      Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                                Icons
                                                                    .insert_drive_file,
                                                                color: AppColors
                                                                    .appBlueColor,
                                                                size: 30),
                                                            const SizedBox(
                                                                height: 8),
                                                            SizedBox(
                                                              width: Get.width *
                                                                  0.7,
                                                              child: TextView(
                                                                maxLines: 2,
                                                                text: fileName,
                                                                textStyle:
                                                                    const TextStyle(
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      // Cross icon at top right
                                                      Positioned(
                                                        top: 8,
                                                        right: 8,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .pickedFile
                                                                .value
                                                                .removeAt(
                                                                    index);
                                                            controller
                                                                .pickedFile
                                                                .refresh();
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Colors.red
                                                                  .withOpacity(
                                                                      0.9),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4),
                                                            child: const Icon(
                                                              Icons.close,
                                                              size: 16,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              }),
                                            ),
                                          ).marginSymmetric(vertical: 10),
                                        );
                                      },
                                    ),
                                    _writeSectionField(controller)
                                  ],
                                ).marginSymmetric(horizontal: 20),
                              if (controller.taskDetailModel?.value?.data
                                          ?.taskType ==
                                      "CALENDLY" ||
                                  controller.taskDetailModel?.value?.data
                                          ?.taskType ==
                                      "LINK")
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: TextView(
                                        maxLines: 100,
                                        text:
                                            "${controller.taskDetailModel?.value.data?.title}",
                                        textStyle: const TextStyle(
                                          color: AppColors.blackColor,
                                          fontSize: 16,
                                          fontFamily: "minorksans",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ).marginOnly(bottom: 5),
                                    TextView(
                                      maxLines: 10000000,
                                      textAlign: TextAlign.center,
                                      text:
                                          "${controller.taskDetailModel?.value.data?.description}",
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontFamily: "kodchasan",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextView(
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      text: "strLinks".tr,
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontFamily: "kodchasan",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap:
                                          true, // important if inside Column/SingleChildScrollView
                                      physics:
                                          const NeverScrollableScrollPhysics(), // disable inner scroll if parent is scrollable
                                      itemCount: controller.taskDetailModel
                                              ?.value.data?.link?.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        final link = controller.taskDetailModel!
                                            .value.data!.link![index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: GestureDetector(
                                            onTap: () async {
                                              final url = "${link}" ?? "";

                                              if (url.isNotEmpty) {
                                                final uri = Uri.parse(url);
                                                if (await canLaunchUrl(uri)) {
                                                  await launchUrl(uri,
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                } else {
                                                  Get.snackbar("Error",
                                                      "Could not launch $url");
                                                }
                                              }
                                            },
                                            child: TextView(
                                              maxLines: 40,
                                              textAlign: TextAlign.start,
                                              text: "$link",
                                              textStyle: const TextStyle(
                                                color: AppColors.appBlueColor,
                                                fontSize: 14,
                                                fontFamily: "kodchasan",
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    controller.taskDetailModel?.value?.data
                                                ?.answerType ==
                                            "UPLOAD_IMAGE"
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: controller
                                                .taskDetailModel
                                                ?.value
                                                .data
                                                ?.count
                                                ?.toInt(), // observable list of picked files
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  FilePickerResult? result =
                                                      await FilePicker.platform
                                                          .pickFiles(
                                                    type: FileType.image,
                                                  );
                                                  if (result != null) {
                                                    var filePath = result
                                                        .files.single.path;
                                                    debugPrint(
                                                        "Picked image: $filePath");
                                                    controller.pickedFile.value
                                                        .add(File(filePath!));
                                                  }
                                                  controller.pickedFile
                                                      .refresh();
                                                },
                                                child: DottedBorder(
                                                  options:
                                                      RoundedRectDottedBorderOptions(
                                                    dashPattern: [10, 4],
                                                    color:
                                                        AppColors.buttonColor,
                                                    strokeWidth: 1,
                                                    radius: Radius.circular(10),
                                                  ),
                                                  child: Container(
                                                    width: Get.width,
                                                    height: Get.height * 0.2,
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .whiteColor
                                                          .withOpacity(0.7),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Obx(() {
                                                      if ((controller
                                                                  .pickedFile
                                                                  .value
                                                                  .length -
                                                              1) <
                                                          index) {
                                                        return Center(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              TextView(
                                                                text:
                                                                    "SelectaFile"
                                                                        .tr,
                                                                textStyle:
                                                                    const TextStyle(
                                                                  color: AppColors
                                                                      .greyshadetext,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                              TextView(
                                                                text:
                                                                    "strBrowse"
                                                                        .tr,
                                                                textStyle:
                                                                    const TextStyle(
                                                                  color: AppColors
                                                                      .appBlueColor,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      } else {
                                                        String fileName =
                                                            controller
                                                                .pickedFile
                                                                .value![index]!
                                                                .path
                                                                .split('/')
                                                                .last;
                                                        return Stack(
                                                          children: [
                                                            // File details in center
                                                            Center(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const Icon(
                                                                      Icons
                                                                          .insert_drive_file,
                                                                      color: AppColors
                                                                          .appBlueColor,
                                                                      size: 30),
                                                                  const SizedBox(
                                                                      height:
                                                                          8),
                                                                  SizedBox(
                                                                    width:
                                                                        Get.width *
                                                                            0.7,
                                                                    child:
                                                                        TextView(
                                                                      maxLines:
                                                                          2,
                                                                      text:
                                                                          fileName,
                                                                      textStyle:
                                                                          const TextStyle(
                                                                        color: AppColors
                                                                            .blackColor,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            // Cross icon at top right
                                                            Positioned(
                                                              top: 8,
                                                              right: 8,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  controller
                                                                      .pickedFile
                                                                      .value
                                                                      .removeAt(
                                                                          index);
                                                                  controller
                                                                      .pickedFile
                                                                      .refresh();
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .red
                                                                        .withOpacity(
                                                                            0.9),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          4),
                                                                  child:
                                                                      const Icon(
                                                                    Icons.close,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                    }),
                                                  ),
                                                ).marginSymmetric(vertical: 10),
                                              );
                                            },
                                          )
                                        : SizedBox(),
                                    _writeSectionField(controller)
                                  ],
                                ).marginSymmetric(horizontal: 20),
                              if (controller.taskDetailModel?.value?.data
                                      ?.answerType ==
                                  "WRITE_SECTION")
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: TextView(
                                        maxLines: 100,
                                        text:
                                            "${controller.taskDetailModel?.value.data?.title}",
                                        textStyle: const TextStyle(
                                          color: AppColors.blackColor,
                                          fontSize: 16,
                                          fontFamily: "minorksans",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ).marginOnly(bottom: 5),
                                    TextView(
                                      maxLines: 10000000,
                                      textAlign: TextAlign.center,
                                      text:
                                          "${controller.taskDetailModel?.value.data?.description}",
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontFamily: "kodchasan",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    _writeSectionField(controller)
                                  ],
                                ).marginSymmetric(horizontal: 20),
                              if (controller.taskDetailModel?.value?.data
                                      ?.answerType ==
                                  "UPLOAD_VIDEO")
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: TextView(
                                        maxLines: 100,
                                        text:
                                            "${controller.taskDetailModel?.value.data?.title}",
                                        textStyle: const TextStyle(
                                          color: AppColors.blackColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ).marginOnly(bottom: 5),
                                    TextView(
                                      maxLines: 10000000,
                                      textAlign: TextAlign.center,
                                      text:
                                          "${controller.taskDetailModel?.value.data?.description}",
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextView(
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                      text: "strUploadFile".tr,
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          1, // observable list of picked files
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                              type: FileType.video,
                                            );
                                            if (result != null) {
                                              var filePath =
                                                  result.files.single.path;
                                              debugPrint(
                                                  "Picked image: $filePath");
                                              controller.pickedFile.value
                                                  .add(File(filePath!));
                                            }
                                            controller.pickedFile.refresh();
                                          },
                                          child: DottedBorder(
                                            options:
                                                RoundedRectDottedBorderOptions(
                                              dashPattern: [10, 4],
                                              color: AppColors.buttonColor,
                                              strokeWidth: 1,
                                              radius: Radius.circular(10),
                                            ),
                                            child: Container(
                                              width: Get.width,
                                              height: Get.height * 0.2,
                                              decoration: BoxDecoration(
                                                color: AppColors.whiteColor
                                                    .withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Obx(() {
                                                if ((controller.pickedFile.value
                                                            .length -
                                                        1) <
                                                    index) {
                                                  return Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        TextView(
                                                          text:
                                                              "SelectaFile".tr,
                                                          textStyle:
                                                              const TextStyle(
                                                            color: AppColors
                                                                .greyshadetext,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        TextView(
                                                          text: "strBrowse".tr,
                                                          textStyle:
                                                              const TextStyle(
                                                            color: AppColors
                                                                .appBlueColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  String fileName = controller
                                                      .pickedFile
                                                      .value![index]!
                                                      .path
                                                      .split('/')
                                                      .last;
                                                  return Stack(
                                                    children: [
                                                      // File details in center
                                                      Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                                Icons
                                                                    .insert_drive_file,
                                                                color: AppColors
                                                                    .appBlueColor,
                                                                size: 30),
                                                            const SizedBox(
                                                                height: 8),
                                                            SizedBox(
                                                              width: Get.width *
                                                                  0.7,
                                                              child: TextView(
                                                                maxLines: 2,
                                                                text: fileName,
                                                                textStyle:
                                                                    const TextStyle(
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      // Cross icon at top right
                                                      Positioned(
                                                        top: 8,
                                                        right: 8,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .pickedFile
                                                                .value
                                                                .removeAt(
                                                                    index);
                                                            controller
                                                                .pickedFile
                                                                .refresh();
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Colors.red
                                                                  .withOpacity(
                                                                      0.9),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4),
                                                            child: const Icon(
                                                              Icons.close,
                                                              size: 16,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              }),
                                            ),
                                          ).marginSymmetric(vertical: 10),
                                        );
                                      },
                                    ),
                                    _writeSectionField(controller)
                                  ],
                                ).marginSymmetric(horizontal: 20),
                            ],
                          ),
                        ),
                      ),
                      if (controller.taskDetailModel?.value?.data?.answerType ==
                          "QUIZ")
                        MaterialButtonWidget(
                          buttonBgColor: AppColors.buttonColor,
                          buttonRadius: 8,
                          buttonText: "strStartQuiz".tr,
                          textColor: AppColors.backgroundColor,
                          onPressed: () {
                            if (controller.taskDetailModel?.value?.data?.quiz
                                    ?.length !=
                                0) {
                              showDialog(
                                context: Get.context!,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    child: _buildOtpModalContent(
                                        context, controller),
                                  );
                                },
                              );
                            }
                          },
                        ).marginSymmetric(vertical: 10, horizontal: 20),
                      if (controller.taskDetailModel?.value?.data?.answerType !=
                              "QUIZ" &&
                          controller.taskDetailModel?.value?.data?.answerType !=
                              "UPLOAD_FILE" &&
                          controller.taskDetailModel?.value?.data?.answerType !=
                              "CHECK_BOX" &&
                          controller.taskDetailModel?.value?.data?.answerType !=
                              "UPLOAD_IMAGE" &&
                          controller.taskDetailModel?.value?.data?.answerType !=
                              "UPLOAD_VIDEO")
                        MaterialButtonWidget(
                          buttonBgColor: AppColors.buttonColor,
                          buttonRadius: 8,
                          buttonText: "strDone".tr,
                          textColor: AppColors.backgroundColor,
                          onPressed: () {
                            controller.videoWatch.value = true;
                            Map<String, dynamic> requestModel =
                                AuthRequestModel.SubmitTaskRequestModel(
                              writeSection: controller
                                  .doneWriteSectionTextController.text,
                            );
                            controller.submitTaskDetail(
                                controller.taskDetailModel?.value.data?.sId,
                                requestModel);
                          },
                        ).marginSymmetric(vertical: 10, horizontal: 20),
                      if (controller.taskDetailModel?.value?.data?.answerType ==
                              "UPLOAD_FILE" ||
                          controller.taskDetailModel?.value?.data?.answerType ==
                              "UPLOAD_IMAGE" ||
                          controller.taskDetailModel?.value?.data?.answerType ==
                              "UPLOAD_VIDEO")
                        MaterialButtonWidget(
                          buttonBgColor: AppColors.buttonColor,
                          buttonRadius: 8,
                          buttonText: "strSubmit".tr,
                          textColor: AppColors.backgroundColor,
                          onPressed: () async {
                            if (controller.pickedFile.isNotEmpty) {
                              List<String> uploadedKeys = [];

                              // Loop through all selected files
                              for (var file in controller.pickedFile) {
                                if (file != null) {
                                  final key = await controller
                                      .callFileUploadMedia(file);
                                  if (key != null) {
                                    uploadedKeys.add(key);
                                  }
                                }
                              }
                              // Now submit with all uploaded keys
                              if (uploadedKeys.isNotEmpty) {
                                Map<String, dynamic> requestModel =
                                    AuthRequestModel.SubmitTaskRequestModel(
                                  uploadLinks: uploadedKeys,
                                  writeSection: controller
                                      .doneWriteSectionTextController.text,
                                );

                                controller.submitTaskDetail(
                                  controller.taskDetailModel?.value.data?.sId,
                                  requestModel,
                                );
                              }
                            }
                          },
                        ).marginSymmetric(vertical: 10, horizontal: 20),
                      if (controller.taskDetailModel?.value?.data?.answerType ==
                          "CHECK_BOX")
                        MaterialButtonWidget(
                          buttonBgColor: AppColors.buttonColor,
                          buttonRadius: 8,
                          buttonText: "strSubmit".tr,
                          textColor: AppColors.backgroundColor,
                          onPressed: () async {
                            if (controller.checkboxValues.length != 0) {
                              Map<String, dynamic> requestModel =
                                  AuthRequestModel.SubmitTaskRequestModel(
                                      checkbox:
                                          controller.checkboxValues.value);
                              controller.submitTaskDetail(
                                  controller.taskDetailModel?.value.data?.sId,
                                  requestModel);
                            }
                          },
                        ).marginSymmetric(vertical: 10, horizontal: 20),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  Future<void> _showFileDialog(BuildContext context, controller) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text("Select File Type"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.image, color: Colors.blue),
                title: const Text("Pick Image"),
                onTap: () async {
                  Navigator.pop(ctx);
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );
                  if (result != null) {
                    var filePath = result.files.single.path;
                    debugPrint("Picked image: $filePath");
                    controller.pickedFile.value.add(File(filePath!));
                    controller.pickedFile.refresh();
                  }
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.insert_drive_file, color: Colors.green),
                title: const Text("Pick Document"),
                onTap: () async {
                  Navigator.pop(ctx);
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
                  );
                  if (result != null) {
                    var filePath = result.files.single.path;
                    debugPrint("Picked document: $filePath");
                    controller.pickedFile.value.add(File(filePath!));
                    controller.pickedFile.refresh();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOtpModalContent(BuildContext context, controller) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.62,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 238, 240, 1),
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
      child: Obx(() => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: TextView(
                    text:
                        "Question ${controller.currentQues.value + 1} of ${controller.taskDetailModel?.value?.data.quiz.length ?? 0}",
                    textStyle: const TextStyle(
                      color: AppColors.greyshadetext,
                      fontSize: 12,
                      fontFamily: "kodchasan",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ).marginOnly(bottom: 10),
                Align(
                  alignment: Alignment.center,
                  child: TextView(
                    maxLines: 100,
                    textAlign: TextAlign.center,
                    text:
                        "${controller.taskDetailModel?.value?.data.quiz[controller.currentQues.value].question}",
                    textStyle: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                      fontFamily: "minorksans",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ).marginOnly(bottom: 20),
                GestureDetector(
                  onTap: () {
                    controller.selectedAnswer.value = "option_A";
                    controller.selectedAnswer.refresh();
                  },
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: controller.selectedAnswer.value == "option_A"
                            ? AppColors.greenColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextView(
                        maxLines: 100,
                        textAlign: TextAlign.center,
                        text:
                            "${controller.taskDetailModel?.value?.data.quiz[controller.currentQues.value].optionA}",
                        textStyle: TextStyle(
                          color: controller.selectedAnswer.value == "option_A"
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                          fontSize: 14,
                          fontFamily: "kodchasan",
                          fontWeight: FontWeight.w400,
                        ),
                      ).marginSymmetric(horizontal: 10, vertical: 15),
                    ),
                  ),
                ).marginSymmetric(horizontal: 10),
                GestureDetector(
                  onTap: () {
                    controller.selectedAnswer.value = "option_B";
                    controller.selectedAnswer.refresh();
                  },
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: controller.selectedAnswer.value == "option_B"
                            ? AppColors.greenColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextView(
                        maxLines: 100,
                        textAlign: TextAlign.center,
                        text:
                            "${controller.taskDetailModel?.value?.data.quiz[controller.currentQues.value].optionB}",
                        textStyle: TextStyle(
                          color: controller.selectedAnswer.value == "option_B"
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                          fontSize: 14,
                          fontFamily: "kodchasan",
                          fontWeight: FontWeight.w400,
                        ),
                      ).marginSymmetric(horizontal: 10, vertical: 15),
                    ),
                  ),
                ).marginSymmetric(horizontal: 10, vertical: 20),
                GestureDetector(
                  onTap: () {
                    controller.selectedAnswer.value = "option_C";
                    controller.selectedAnswer.refresh();
                  },
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: controller.selectedAnswer.value == "option_C"
                            ? AppColors.greenColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextView(
                        maxLines: 100,
                        textAlign: TextAlign.center,
                        text:
                            "${controller.taskDetailModel?.value?.data.quiz[controller.currentQues.value].optionC}",
                        textStyle: TextStyle(
                          color: controller.selectedAnswer.value == "option_C"
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                          fontSize: 14,
                          fontFamily: "kodchasan",
                          fontWeight: FontWeight.w400,
                        ),
                      ).marginSymmetric(horizontal: 10, vertical: 15),
                    ),
                  ),
                ).marginSymmetric(horizontal: 10),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    controller.selectedAnswer.value = "option_D";
                    controller.selectedAnswer.refresh();
                  },
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: controller.selectedAnswer.value == "option_D"
                            ? AppColors.greenColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextView(
                        maxLines: 100,
                        textAlign: TextAlign.center,
                        text:
                            "${controller.taskDetailModel?.value?.data.quiz[controller.currentQues.value].optionD}",
                        textStyle: TextStyle(
                          color: controller.selectedAnswer.value == "option_D"
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                          fontSize: 14,
                          fontFamily: "kodchasan",
                          fontWeight: FontWeight.w400,
                        ),
                      ).marginSymmetric(horizontal: 10, vertical: 15),
                    ),
                  ),
                ).marginSymmetric(horizontal: 10),
                SizedBox(
                  height: 20,
                ),
                MaterialButtonWidget(
                  buttonBgColor: AppColors.buttonColor,
                  buttonRadius: 8,
                  borderColor: AppColors.clickTextColor,
                  isOutlined: true,
                  buttonText: "strSubmit".tr,
                  textColor: AppColors.backgroundColor,
                  onPressed: () {
                    if (controller.selectedAnswer.value.isNotEmpty) {
                      controller.quizAnswers.add(QuizAnswer(
                          quizId: controller.taskDetailModel?.value?.data
                                  .quiz[controller.currentQues.value].sId ??
                              "",
                          answer: controller.selectedAnswer.value));

                      controller.selectedAnswer.value = "";
                      if (controller.currentQues.value ==
                          (controller.taskDetailModel?.value?.data.quiz.length -
                              1)) {
                        Get.back();
                        Map<String, dynamic> requestModel =
                            AuthRequestModel.SubmitTaskRequestModel(
                          quiz: controller.quizAnswers,
                        );
                        controller.submitTaskDetail(
                            controller.taskDetailModel?.value.data?.sId,
                            requestModel);
                      } else {
                        controller.currentQues.value++;
                      }
                    }
                  },
                ).marginSymmetric(vertical: 10, horizontal: 20),
              ],
            ).paddingAll(10),
          )),
    );
  }

  Widget _writeSectionField(controller) => TextFieldWidget(
        hint: "strWriteHere".tr,
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textColors: Colors.black,
        maxline: 7,
        minLine: 7,
        textController: controller.doneWriteSectionTextController,
        fillColor: AppColors.whiteColor.withOpacity(0.5),
        borderColor: AppColors.buttonColor,
        courserColor: AppColors.buttonColor,
        focusNode: controller.doneWriteSectionFocusNode,
        inputType: TextInputType.text,
      );
}

import 'dart:io';

import 'package:disstrikt/app/data/repository/endpoint.dart';
import 'package:disstrikt/app/modules/Portfolio/views/videoDilogBox.dart';
import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart'
    show ImageFormat, VideoThumbnail;
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../core/widget/asset_image_widget.dart';
import '../../../core/widget/network_image_widget.dart';
import '../../../core/widget/text_view.dart';
import '../../../core/widget/material_button_widget.dart';
import '../../home/models/requestModels/buyplanRequestModel.dart';
import '../controller/portfolio_controller.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PortfolioController>(
      init: PortfolioController(),
      builder: (controller) {
        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.buttonColor,
          child: Scaffold(
            backgroundColor: AppColors.buttonColor.withOpacity(0.3),
            floatingActionButton: _buildFloatingActionButton(controller),
            body: SafeArea(
              child: Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width,
                        height: Get.height * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: AppColors.buttonColor,
                        ),
                        child: TextView(
                          text: "strMyPortfolio".tr,
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
                      Expanded(
                          child: Skeletonizer(
                              enabled: controller.loading.value,
                              child: SingleChildScrollView(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Row(
                                      children: [
                                        controller.portfolioResponseModel.value
                                                        .data?.image ==
                                                    null ||
                                                controller
                                                        .portfolioResponseModel
                                                        .value
                                                        .data
                                                        ?.image
                                                        ?.isEmpty ==
                                                    true
                                            ? Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.buttonColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80)),
                                                child: Icon(
                                                  Icons.person,
                                                  size: 80,
                                                  color: AppColors.whiteColor,
                                                ),
                                              )
                                            : NetworkImageWidget(
                                                imageUrl: controller
                                                        .portfolioResponseModel
                                                        .value
                                                        .data
                                                        ?.image ??
                                                    "",
                                                imageHeight: 100,
                                                imageWidth: 100,
                                                radiusAll: 100,
                                              ),
                                        SizedBox(
                                          width: margin_10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextView(
                                              text:
                                                  "${controller.portfolioResponseModel.value.data?.fullName}",
                                              textStyle: const TextStyle(
                                                color: AppColors.blackColor,
                                                fontFamily: "minorksans",
                                                fontSize: 16,
                                              ),
                                            ).marginOnly(left: 10),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    await Get.toNamed(AppRoutes
                                                        .EditPortfolioScreen);
                                                    controller.GetPortfolio();
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppColors
                                                                .buttonColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.white),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.edit_outlined,
                                                          size: 18,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        TextView(
                                                          text: "strEdit".tr,
                                                          textStyle: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontFamily:
                                                                  "kodchasan"),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    _shareApp(controller);
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppColors
                                                                .buttonColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.white),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.share,
                                                          size: 18,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Flexible(
                                                          child: TextView(
                                                            text: "strShare".tr,
                                                            textStyle: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontFamily:
                                                                    "kodchasan"),
                                                          ),
                                                        ),
                                                      ],
                                                    ).marginSymmetric(
                                                        horizontal: 8),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ).marginSymmetric(horizontal: 20),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        controller
                                                    .portfolioResponseModel
                                                    .value
                                                    .data
                                                    ?.aboutMe
                                                    ?.isNotEmpty ==
                                                true
                                            ? TextView(
                                                text: "strAboutMe".tr,
                                                textStyle: const TextStyle(
                                                  color: AppColors.blackColor,
                                                  fontFamily: "kodchasan",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ).marginOnly(top: 20)
                                            : SizedBox(),
                                        controller
                                                    .portfolioResponseModel
                                                    .value
                                                    .data
                                                    ?.aboutMe
                                                    ?.isNotEmpty ==
                                                true
                                            ? TextView(
                                                maxLines: null,
                                                overflow: TextOverflow.visible,
                                                text: controller
                                                        .portfolioResponseModel
                                                        .value
                                                        .data
                                                        ?.aboutMe ??
                                                    "",
                                                textStyle: const TextStyle(
                                                  color: AppColors.blackColor,
                                                  fontFamily: "kodchasan",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ).marginOnly(top: 7)
                                            : SizedBox(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            controller
                                                            .portfolioResponseModel
                                                            .value
                                                            .data
                                                            ?.links?[0]
                                                            ?.url
                                                            ?.isEmpty ==
                                                        true ||
                                                    controller
                                                            .portfolioResponseModel
                                                            .value
                                                            .data
                                                            ?.links?[0]
                                                            ?.url ==
                                                        null
                                                ? SizedBox()
                                                : GestureDetector(
                                                    onTap: () async {
                                                      final uri = Uri.parse(
                                                          controller
                                                                  .portfolioResponseModel
                                                                  .value
                                                                  .data
                                                                  ?.links?[0]
                                                                  ?.url ??
                                                              "");
                                                      if (await canLaunchUrl(
                                                          uri)) {
                                                        await launchUrl(uri,
                                                            mode: LaunchMode
                                                                .externalApplication);
                                                      } else {
                                                        // Handle error
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  'Could not open URL: $uri')),
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width:
                                                          (Get.width * 0.8) / 2,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .buttonColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: Colors.white),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          AssetImageWidget(
                                                            iconInstagram,
                                                            imageWidth: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          TextView(
                                                            text: "strInstagram"
                                                                .tr,
                                                            textStyle: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontFamily:
                                                                    "kodchasan"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            controller
                                                            .portfolioResponseModel
                                                            .value
                                                            .data
                                                            ?.links?[1]
                                                            ?.url
                                                            ?.isEmpty ==
                                                        true ||
                                                    controller
                                                            .portfolioResponseModel
                                                            .value
                                                            .data
                                                            ?.links?[1]
                                                            ?.url ==
                                                        null
                                                ? SizedBox()
                                                : GestureDetector(
                                                    onTap: () async {
                                                      final uri = Uri.parse(
                                                          controller
                                                                  .portfolioResponseModel
                                                                  .value
                                                                  .data
                                                                  ?.links?[1]
                                                                  ?.url ??
                                                              "");
                                                      if (await canLaunchUrl(
                                                          uri)) {
                                                        await launchUrl(uri,
                                                            mode: LaunchMode
                                                                .externalApplication);
                                                      } else {
                                                        // Handle error
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  'Could not open URL: $uri')),
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width:
                                                          (Get.width * 0.8) / 2,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .buttonColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: Colors.white),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          AssetImageWidget(
                                                            iconYoutube,
                                                            imageWidth: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          TextView(
                                                            text:
                                                                "strYouTube".tr,
                                                            textStyle: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontFamily:
                                                                    "kodchasan"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ).marginSymmetric(vertical: 20),
                                        controller.portfolioResponseModel?.value
                                                    ?.data?.setCards?.length !=
                                                0
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextView(
                                                    text: "strSetCard".tr,
                                                    textStyle: const TextStyle(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontFamily: "kodchasan",
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      final imageUrl = controller
                                                              .portfolioResponseModel
                                                              ?.value
                                                              ?.data
                                                              ?.setCards?[0] ??
                                                          "";

                                                      if (imageUrl.isNotEmpty) {
                                                        Get.dialog(
                                                          Stack(
                                                            children: [
                                                              // Transparent background tap-to-close area
                                                              GestureDetector(
                                                                onTap: () =>
                                                                    Get.back(),
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .black54, // dim background
                                                                ),
                                                              ),

                                                              // Centered white container with zoomable image
                                                              Center(
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          20),
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          20),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                  ),
                                                                  width:
                                                                      Get.width *
                                                                          0.9,
                                                                  height:
                                                                      Get.height *
                                                                          0.5,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    child:
                                                                        PhotoView(
                                                                      imageProvider:
                                                                          NetworkImage(
                                                                              "${imageBaseUrl}${imageUrl}"),
                                                                      backgroundDecoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .transparent,
                                                                      ),
                                                                      minScale:
                                                                          PhotoViewComputedScale
                                                                              .contained,
                                                                      maxScale:
                                                                          PhotoViewComputedScale.covered *
                                                                              2.5,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          barrierDismissible:
                                                              true,
                                                        );
                                                      }
                                                    },
                                                    child: NetworkImageWidget(
                                                      imageUrl: controller
                                                              .portfolioResponseModel
                                                              ?.value
                                                              ?.data
                                                              ?.setCards?[0] ??
                                                          "",
                                                      imageHeight:
                                                          Get.height * 0.25,
                                                      imageFitType: BoxFit.fill,
                                                      imageWidth: Get.width,
                                                      radiusAll: 10,
                                                    ).marginSymmetric(
                                                        vertical: 10),
                                                  ),
                                                ],
                                              )
                                            : SizedBox(),
                                      ],
                                    ).marginSymmetric(
                                      horizontal: 20,
                                    )

                                    // Column(
                                    //   children: [
                                    //     AssetImageWidget(emptyProtfolio)
                                    //         .marginSymmetric(
                                    //             horizontal: 20, vertical: 30),
                                    //     TextView(
                                    //       text: "strEmptyportfolioHeading".tr,
                                    //       textStyle: const TextStyle(
                                    //         color: AppColors.blackColor,
                                    //         fontSize: 12,
                                    //         fontFamily: "Kodchasan",
                                    //         fontWeight: FontWeight.w900,
                                    //       ),
                                    //     ),
                                    //     TextView(
                                    //       text:
                                    //           "strEmptyportfolioSubheading".tr,
                                    //       maxLines: 4,
                                    //       textAlign: TextAlign.center,
                                    //       textStyle: const TextStyle(
                                    //         color: AppColors.blackColor,
                                    //         fontSize: 12,
                                    //         fontFamily: "Kodchasan",
                                    //         fontWeight: FontWeight.w400,
                                    //       ),
                                    //     ).marginSymmetric(
                                    //         horizontal: 10, vertical: 5),
                                    //     MaterialButtonWidget(
                                    //       buttonBgColor: AppColors.buttonColor,
                                    //       buttonRadius: 8,
                                    //       buttonText: "strEditPortfolio".tr,
                                    //       buttonTextStyle: TextStyle(
                                    //           fontFamily: "minorksans"),
                                    //       textColor: AppColors.backgroundColor,
                                    //       onPressed: () async {},
                                    //     ).marginSymmetric(
                                    //         vertical: 10,
                                    //         horizontal: margin_60),
                                    //   ],
                                    // )
                                    ,
                                    Obx(() => Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.isImages.value =
                                                      true;
                                                  controller.isImages.refresh();
                                                },
                                                child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                        color: AppColors
                                                            .buttonColor,
                                                        width: 1.5,
                                                      ),
                                                      bottom: BorderSide(
                                                        color: AppColors
                                                            .buttonColor,
                                                        width: 1.5,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      controller.isImages
                                                                  .value ==
                                                              true
                                                          ? AssetImageWidget(
                                                              iconpinkGallery,
                                                              imageHeight: 25,
                                                            )
                                                          : AssetImageWidget(
                                                              iconGallery,
                                                              imageHeight: 25,
                                                            ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      TextView(
                                                          text: "strImages".tr,
                                                          textStyle: TextStyle(
                                                            color: controller
                                                                        .isImages
                                                                        .value ==
                                                                    true
                                                                ? AppColors
                                                                    .clickTextColor
                                                                : AppColors
                                                                    .blackColor,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                "Kodchasan",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          )),
                                                    ],
                                                  ),
                                                ).marginOnly(top: 10),
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.isImages.value =
                                                      false;
                                                  controller.isImages.refresh();
                                                },
                                                child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                        color: AppColors
                                                            .buttonColor,
                                                        width: 1.5,
                                                      ),
                                                      bottom: BorderSide(
                                                        color: AppColors
                                                            .buttonColor,
                                                        width: 1.5,
                                                      ),
                                                      left: BorderSide(
                                                        color: AppColors
                                                            .buttonColor,
                                                        width: 1.5,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      controller.isImages
                                                                  .value ==
                                                              false
                                                          ? AssetImageWidget(
                                                              iconPinkVideo,
                                                              imageHeight: 25,
                                                            )
                                                          : AssetImageWidget(
                                                              iconVideo,
                                                              imageHeight: 25,
                                                            ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      TextView(
                                                          text: "strVideos".tr,
                                                          textStyle: TextStyle(
                                                            color: controller
                                                                        .isImages
                                                                        .value ==
                                                                    false
                                                                ? AppColors
                                                                    .clickTextColor
                                                                : AppColors
                                                                    .blackColor,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                "Kodchasan",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          )),
                                                    ],
                                                  ),
                                                ).marginOnly(top: 10),
                                              ),
                                            ),
                                          ],
                                        )),
                                    controller.isImages == true
                                        ? controller
                                                    .portfolioResponseModel
                                                    .value
                                                    .data
                                                    ?.portfolioImages
                                                    ?.length ==
                                                0
                                            ? Column(
                                                children: [
                                                  AssetImageWidget(
                                                    emptyProtfolio,
                                                    imageHeight: 150,
                                                    imageWidth: 150,
                                                  ).marginSymmetric(
                                                      horizontal: 20,
                                                      vertical: 30),
                                                  TextView(
                                                    text:
                                                        "strEmptyportfolioHeading"
                                                            .tr,
                                                    textStyle: const TextStyle(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontSize: 12,
                                                      fontFamily: "Kodchasan",
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  TextView(
                                                    text:
                                                        "strEmptyportfolioSubheading"
                                                            .tr,
                                                    maxLines: 4,
                                                    textAlign: TextAlign.center,
                                                    textStyle: const TextStyle(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontSize: 12,
                                                      fontFamily: "Kodchasan",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ).marginSymmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  // MaterialButtonWidget(
                                                  //   buttonBgColor:
                                                  //       AppColors.buttonColor,
                                                  //   buttonRadius: 8,
                                                  //   buttonText:
                                                  //       "strEditPortfolio".tr,
                                                  //   buttonTextStyle: TextStyle(
                                                  //       fontFamily:
                                                  //           "minorksans"),
                                                  //   textColor: AppColors
                                                  //       .backgroundColor,
                                                  //   onPressed: () async {},
                                                  // ).marginSymmetric(
                                                  //     vertical: 10,
                                                  //     horizontal: margin_60),
                                                ],
                                              )
                                            : controller
                                                        .portfolioResponseModel
                                                        .value
                                                        .data
                                                        ?.portfolioImages
                                                        ?.length ==
                                                    0
                                                ? Column(
                                                    children: [
                                                      AssetImageWidget(
                                                        emptyProtfolio,
                                                        imageHeight: 150,
                                                        imageWidth: 150,
                                                      ).marginSymmetric(
                                                          horizontal: 20,
                                                          vertical: 30),
                                                      TextView(
                                                        text:
                                                            "strEmptyportfolioHeading"
                                                                .tr,
                                                        textStyle:
                                                            const TextStyle(
                                                          color: AppColors
                                                              .blackColor,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              "Kodchasan",
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ),
                                                      ),
                                                      TextView(
                                                        text:
                                                            "strEmptyportfolioSubheading"
                                                                .tr,
                                                        maxLines: 4,
                                                        textAlign:
                                                            TextAlign.center,
                                                        textStyle:
                                                            const TextStyle(
                                                          color: AppColors
                                                              .blackColor,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              "Kodchasan",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ).marginSymmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                      // MaterialButtonWidget(
                                                      //   buttonBgColor:
                                                      //       AppColors.buttonColor,
                                                      //   buttonRadius: 8,
                                                      //   buttonText:
                                                      //       "strEditPortfolio".tr,
                                                      //   buttonTextStyle: TextStyle(
                                                      //       fontFamily:
                                                      //           "minorksans"),
                                                      //   textColor: AppColors
                                                      //       .backgroundColor,
                                                      //   onPressed: () async {},
                                                      // ).marginSymmetric(
                                                      //     vertical: 10,
                                                      //     horizontal: margin_60),
                                                    ],
                                                  )
                                                : GridView.builder(
                                                    itemCount: controller
                                                            .portfolioResponseModel
                                                            .value
                                                            .data
                                                            ?.portfolioImages
                                                            ?.length ??
                                                        0,
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisSpacing: 12,
                                                      crossAxisSpacing: 12,
                                                      childAspectRatio: 1,
                                                    ),
                                                    itemBuilder:
                                                        (context, index) {
                                                      final image = controller
                                                          .portfolioResponseModel
                                                          .value
                                                          .data
                                                          ?.portfolioImages?[index];
                                                      return GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .selectedPhotoIndex
                                                              .value = index;
                                                          controller
                                                              .selectedPhotoIndex
                                                              .refresh();
                                                          print(controller
                                                              .selectedPhotoIndex
                                                              .value);
                                                          final imageUrl = controller
                                                              .portfolioResponseModel
                                                              .value
                                                              .data
                                                              ?.portfolioImages?[index];

                                                          Get.dialog(
                                                            Stack(
                                                              children: [
                                                                // Transparent background tap-to-close area
                                                                GestureDetector(
                                                                  onTap: () =>
                                                                      Get.back(),
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .black54, // dim background
                                                                  ),
                                                                ),

                                                                // Centered white container with zoomable image and buttons
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            20),
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            20),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                    ),
                                                                    width:
                                                                        Get.width *
                                                                            0.9,
                                                                    height:
                                                                        Get.height *
                                                                            0.5,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            child:
                                                                                PhotoView(
                                                                              imageProvider: NetworkImage("${imageBaseUrl}${imageUrl}"),
                                                                              backgroundDecoration: const BoxDecoration(
                                                                                color: Colors.transparent,
                                                                              ),
                                                                              minScale: PhotoViewComputedScale.contained,
                                                                              maxScale: PhotoViewComputedScale.covered * 2,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                20.0),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Obx(
                                                                                () => MaterialButtonWidget(
                                                                                  isloading: controller.isLoading.value,
                                                                                  buttonBgColor: AppColors.clickTextColor,
                                                                                  buttonRadius: 8,
                                                                                  buttonText: "strDeletephoto".tr,
                                                                                  buttonTextStyle: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    color: AppColors.whiteColor,
                                                                                    fontFamily: "Kodchasan",
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                                  textColor: AppColors.whiteColor,
                                                                                  onPressed: () async {
                                                                                    Map<String, dynamic> requestModel = BuyPlanRequestModel.addImageRequestModel(url: [
                                                                                      controller.portfolioResponseModel.value.data?.portfolioImages?[index] ?? ""
                                                                                    ]);
                                                                                    controller.deleteImagePortfolio(requestModel);
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(width: 5),
                                                                            Expanded(
                                                                              child: MaterialButtonWidget(
                                                                                buttonBgColor: Colors.transparent,
                                                                                buttonRadius: 8,
                                                                                isOutlined: true,
                                                                                borderColor: AppColors.clickTextColor,
                                                                                buttonText: "strPhotoCancel".tr,
                                                                                buttonTextStyle: const TextStyle(
                                                                                  fontSize: 12,
                                                                                  color: AppColors.blackColor,
                                                                                  fontFamily: "Kodchasan",
                                                                                  fontWeight: FontWeight.w600,
                                                                                ),
                                                                                textColor: AppColors.whiteColor,
                                                                                onPressed: () => {
                                                                                  Get.back()
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            barrierDismissible:
                                                                true,
                                                          );
                                                        },
                                                        child:
                                                            NetworkImageWidget(
                                                          imageUrl: image ?? '',
                                                          radiusAll: 8,
                                                          imageFitType:
                                                              BoxFit.cover,
                                                        ),
                                                      );
                                                    },
                                                  ).marginSymmetric(
                                                    horizontal: 20,
                                                    vertical: 20)
                                        : controller
                                                    .portfolioResponseModel
                                                    .value
                                                    .data
                                                    ?.videos
                                                    ?.length ==
                                                0
                                            ? Column(
                                                children: [
                                                  AssetImageWidget(
                                                    emptyProtfolio,
                                                    imageHeight: 150,
                                                    imageWidth: 150,
                                                  ).marginSymmetric(
                                                      horizontal: 20,
                                                      vertical: 30),
                                                  TextView(
                                                    text:
                                                        "strEmptyportfolioHeading"
                                                            .tr,
                                                    textStyle: const TextStyle(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontSize: 12,
                                                      fontFamily: "Kodchasan",
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  TextView(
                                                    text:
                                                        "strEmptyportfolioSubheading"
                                                            .tr,
                                                    maxLines: 4,
                                                    textAlign: TextAlign.center,
                                                    textStyle: const TextStyle(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontSize: 12,
                                                      fontFamily: "Kodchasan",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ).marginSymmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  // MaterialButtonWidget(
                                                  //   buttonBgColor:
                                                  //       AppColors.buttonColor,
                                                  //   buttonRadius: 8,
                                                  //   buttonText:
                                                  //       "strEditPortfolio".tr,
                                                  //   buttonTextStyle: TextStyle(
                                                  //       fontFamily:
                                                  //           "minorksans"),
                                                  //   textColor: AppColors
                                                  //       .backgroundColor,
                                                  //   onPressed: () async {},
                                                  // ).marginSymmetric(
                                                  //     vertical: 10,
                                                  //     horizontal: margin_60),
                                                ],
                                              )
                                            : GridView.builder(
                                                itemCount: controller
                                                        .portfolioResponseModel
                                                        .value
                                                        .data
                                                        ?.videos
                                                        ?.length ??
                                                    0,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 1,
                                                  mainAxisSpacing: 12,
                                                  crossAxisSpacing: 12,
                                                  childAspectRatio: 3 / 2,
                                                ),
                                                itemBuilder: (context, index) {
                                                  final image = controller
                                                      .portfolioResponseModel
                                                      .value
                                                      .data
                                                      ?.videos?[index];
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) => VideoDialog(
                                                            videoUrl:
                                                                "${imageBaseUrl}${controller.portfolioResponseModel.value.data?.videos?[index].url}"),
                                                      );
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            TextView(
                                                              text: image?.title ==
                                                                      "catwalkVideo"
                                                                  ? "catwalkVideo"
                                                                      .tr
                                                                  : image?.title ==
                                                                          "introVideo"
                                                                      ? "introVideo"
                                                                          .tr
                                                                      : "strOthers"
                                                                          .tr,
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: AppColors
                                                                    .blackColor,
                                                                fontFamily:
                                                                    "kodchasan",
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                              ),
                                                            ),
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
                                                                      child: _photoDeleteModalContent(
                                                                          context,
                                                                          controller,
                                                                          index),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  AssetImageWidget(
                                                                    iconbucket,
                                                                    imageHeight:
                                                                        20,
                                                                    imageWidth:
                                                                        20,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  TextView(
                                                                    text:
                                                                        "strDelete"
                                                                            .tr,
                                                                    textStyle:
                                                                        const TextStyle(
                                                                      color: AppColors
                                                                          .greyshadetext,
                                                                      fontFamily:
                                                                          "kodchasan",
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          height:
                                                              Get.height * 0.2,
                                                          child: Stack(
                                                            children: [
                                                              NetworkImageWidget(
                                                                imageUrl: image
                                                                        ?.thumbnail ??
                                                                    '',
                                                                radiusAll: 8,
                                                                imageHeight:
                                                                    Get.height *
                                                                        0.2,
                                                                imageWidth:
                                                                    Get.width,
                                                                imageFitType:
                                                                    BoxFit
                                                                        .cover,
                                                              ),
                                                              Center(
                                                                child: Icon(
                                                                  Icons
                                                                      .play_circle_outline,
                                                                  size: 40,
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.8),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ).marginSymmetric(
                                                horizontal: 20, vertical: 20),
                                  ]).marginSymmetric(vertical: 20))))
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  String _getPortfolioFeatureDescription(String portfolioDeepLink) {
    return '''
💃 Showcase Your Style with Our Portfolio Feature!

Our modeling app is more than just bookings — it’s your digital stage. With the built-in **Portfolio feature**, models can effortlessly upload and organize their best shots, videos, and collaborations all in one place.

✨ Portfolio Highlights:
• Upload images & videos in high quality  
• Categorize by theme (ramp, editorial, casual, etc.)  
• Share your portfolio with agencies & brands  
• Privacy controls for each media item  
• Fast & smooth media browsing experience

🎯 Whether you're a rising model or a seasoned pro, our portfolio system helps you **stand out** and get discovered faster.


🔗 View Portfolio: $portfolioDeepLink  

#ModelLife #DigitalPortfolio #ModelApp #ShowYourStyle #FashionTech #CastingReady
''';
  }

  Future<void> _shareApp(controller) async {
    try {
      // App description with platform-specific content
      final String appDescription = _getPortfolioFeatureDescription(
          "https://disstrikt-portfolio.vercel.app/portfolio/${controller.portfolioResponseModel.value.data?.userId}");

      // Share the app
      await Share.share(
        appDescription,
      );
    } catch (e) {
      debugPrint('Error sharing app: $e');
      // Show error message to user
    }
  }

  Widget _photoDeleteModalContent(BuildContext context, controller, index) {
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
            deleteModal,
            height: 80,
            width: 80,
          ),
          TextView(
            text: "strDeleteModal".tr,
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
                  child: Obx(
                    () => MaterialButtonWidget(
                      isloading: controller.isLoading.value,
                      buttonBgColor: AppColors.clickTextColor,
                      buttonRadius: 8,
                      buttonText: "strYesDelete".tr,
                      buttonTextStyle: TextStyle(
                          fontSize: 12,
                          color: AppColors.whiteColor,
                          fontFamily: "Kodchasan",
                          fontWeight: FontWeight.w600),
                      textColor: AppColors.whiteColor,
                      onPressed: () {
                        Map<String, dynamic> requestModel =
                            BuyPlanRequestModel.addVideoRequestModel(
                                url: controller.portfolioResponseModel.value
                                        .data?.videos?[index].url ??
                                    "",
                                thumbnail: controller.portfolioResponseModel
                                        .value.data?.videos?[index].thumbnail ??
                                    "");
                        controller.deleteVideoPortfolio(requestModel);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 15),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(controller) {
    return SpeedDial(
      icon: Icons.add,
      iconTheme: const IconThemeData(size: 30),
      activeIcon: Icons.close,
      backgroundColor: AppColors.clickTextColor,
      overlayOpacity: 0.4,
      overlayColor: Colors.black,
      foregroundColor: Colors.white,
      spaceBetweenChildren: 10,
      children: [
        SpeedDialChild(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            child: ClipOval(
              child: Container(
                color: AppColors.whiteColor,
                height: 50,
                width: 50,
                child: Center(
                  child: AssetImageWidget(
                    iconGallery,
                    imageWidth: 20,
                    imageHeight: 20,
                  ),
                ),
              ),
            ),
            label: 'strUploadImage'.tr,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontFamily: "kodchasan",
              fontWeight: FontWeight.w400,
              color: AppColors.blackColor,
            ),
            onTap: () {
              controller.videoList.clear();
              controller.tumbhnailList.clear();
              controller.uploadedTumbhnailList.clear();
              controller.pickedImage = Rx<File?>(null);
              controller.isLoading.value = false;
              showDialog(
                context: Get.context!,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: _buildDeleteModalContent(context, controller),
                  );
                },
              );
            }),
        SpeedDialChild(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            child: ClipOval(
              child: Container(
                color: AppColors.whiteColor,
                height: 50,
                width: 50,
                child: Center(
                  child: AssetImageWidget(
                    iconVideo,
                    imageWidth: 20,
                    imageHeight: 20,
                  ),
                ),
              ),
            ),
            label: 'strUploadVideo'.tr,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontFamily: "kodchasan",
              fontWeight: FontWeight.w400,
              color: AppColors.blackColor,
            ),
            onTap: () {
              controller.videoList.clear();
              controller.tumbhnailList.clear();
              controller.uploadedTumbhnailList.clear();
              controller.pickedImage = Rx<File?>(null);
              controller.isLoading.value = false;
              showDialog(
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      child: _buildVideoContent(context, controller),
                    );
                  });
            }),
      ],
    );
  }

  Widget _buildVideoContent(BuildContext context, controller) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                imagemodalbackground), // Ensure imagemodalbackground is defined
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Container(
                  decoration: BoxDecoration(
                      color: AppColors.textfieldcolor,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        "strSelect".tr,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: "Mulish",
                          color: AppColors.blackColor,
                        ),
                      ),
                      items: controller.genders
                          .map<DropdownMenuItem<String>>((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  gender,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      value: controller.selectGender.value.isEmpty
                          ? null
                          : controller.selectGender.value,
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (String? value) {
                        if (value != null) {
                          controller.selectGender.value = value;
                        }
                      },
                      iconStyleData: IconStyleData(
                        icon: Obx(() => Icon(
                              controller.isSecondDropdownOpen.value
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: Colors.black,
                            )),
                      ),
                      onMenuStateChange: (isOpen) {
                        controller.isSecondDropdownOpen.value = isOpen;
                      },
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.only(right: 16),
                        height: 49,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 20.0),
            Obx(() {
              // Wrap GridView in Obx to react to videoList changes
              return GridView.builder(
                itemCount: controller.videoList.length == 0
                    ? 1
                    : controller.videoList.length, // Fixed: Use length + 1
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  if (index < controller.videoList.length) {
                    return _buildVideoTile(
                        controller.videoList[index], index, controller);
                  } else {
                    return _buildAddMoreTile(controller);
                  }
                },
              );
            }),
            const SizedBox(height: 20.0),
            Obx(() => controller.videoList.value.length == 0
                ? SizedBox()
                : MaterialButtonWidget(
                    buttonBgColor: Colors.transparent,
                    buttonRadius: 100,
                    isOutlined: true,
                    borderColor: Colors.white,
                    buttonText: "uploadtumbh".tr,
                    buttonTextStyle: const TextStyle(
                      fontSize: 12,
                      color: AppColors.blackColor,
                      fontFamily: "Kodchasan",
                      fontWeight: FontWeight.w600,
                    ),
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      controller.pickThumbImage();
                    },
                  ).marginSymmetric(horizontal: 10)),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: MaterialButtonWidget(
                    buttonBgColor: Colors.transparent,
                    buttonRadius: 8,
                    isOutlined: true,
                    borderColor: Colors.black,
                    buttonText: "strPhotoCancel".tr,
                    buttonTextStyle: const TextStyle(
                      fontSize: 12,
                      color: AppColors.blackColor,
                      fontFamily: "Kodchasan",
                      fontWeight: FontWeight.w600,
                    ),
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      Get.back();
                      controller.videoList.clear();
                      controller.tumbhnailList.clear();
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Obx(
                    () => MaterialButtonWidget(
                      isloading: controller.isLoading.value,
                      buttonBgColor: AppColors.clickTextColor,
                      buttonRadius: 8,
                      buttonText: "strSave".tr,
                      buttonTextStyle: const TextStyle(
                        fontSize: 12,
                        color: AppColors.whiteColor,
                        fontFamily: "Kodchasan",
                        fontWeight: FontWeight.w600,
                      ),
                      textColor: AppColors.whiteColor,
                      onPressed: () async {
                        if (controller.videoList.isNotEmpty) {
                          try {
                            await controller
                                .uploadAllVideos(); // Replace with your upload logic
                          } catch (e) {
                            print('Failed to upload videos: $e');
                          }
                        } else {
                          print('No videos to upload');
                        }
                      },
                    ),
                  ),
                ),
              ],
            ).marginSymmetric(horizontal: 15),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoTile(String videoPath, int index, controller) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => VideoPlayerScreen(videoPath: videoPath)); // Ensure VideoPlayerScreen is defined
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: FutureBuilder<String?>(
              future: controller.generateThumbnail(
                  videoPath), // Generate thumbnail if not cached
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Container(
                          height: Get.height * 0.2,
                          width: Get.width,
                          child: Center(
                            child:
                                Obx(() => controller.pickedImage.value != null
                                    ? Image.file(
                                        controller.pickedImage
                                            .value!, // Display the new thumbnail
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          print(
                                              'Error loading thumbnail for $videoPath: $error');
                                          return Center(
                                            child: Icon(
                                              Icons.videocam,
                                              size: 40,
                                              color: Colors.grey[600],
                                            ),
                                          );
                                        },
                                      )
                                    : Image.file(
                                        File(snapshot
                                            .data!), // Display the new thumbnail
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          print(
                                              'Error loading thumbnail for $videoPath: $error');
                                          return Center(
                                            child: Icon(
                                              Icons.videocam,
                                              size: 40,
                                              color: Colors.grey[600],
                                            ),
                                          );
                                        },
                                      )),
                          ),
                        ),
                        Center(
                          child: Icon(
                            Icons.play_circle_outline,
                            size: 40,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  print(
                      'Thumbnail generation error for $videoPath: ${snapshot.error}');
                  return Center(
                    child: Icon(
                      Icons.videocam,
                      size: 40,
                      color: Colors.grey[600],
                    ),
                  );
                }
                // Fallback to CircularProgressIndicator if no cached thumbnail
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: GestureDetector(
              onTap: () => {
                controller.videoList.removeAt(index),
                controller.pickedImage.value = null,
                controller.tumbhnailList.clear()
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddMoreTile(controller) {
    return GestureDetector(
      onTap: () => controller.pickVideo(),
      child: Container(
        width: double.infinity,
        height: Get.height * 0.2,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "strAddMore".tr,
                style: const TextStyle(
                  color: AppColors.greyshadetext,
                  fontFamily: "kodchasan",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteModalContent(BuildContext context, controller) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagemodalbackground),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Obx(() {
          final imageList = controller.imageList;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GridView.builder(
                itemCount: imageList.length < 4 ? imageList.length + 1 : 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  if (index < imageList.length) {
                    final image = imageList[index];
                    return Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: image is String
                                  ? (image.startsWith('http')
                                      ? NetworkImage(image)
                                      : FileImage(File(image)) as ImageProvider)
                                  : const AssetImage('assets/placeholder.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 6,
                          right: 6,
                          child: GestureDetector(
                            onTap: () => controller.imageList.removeAt(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(4),
                              child: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return GestureDetector(
                      onTap: () => controller.pickImage(),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextView(
                                text: "strAddMore".tr,
                                textStyle: const TextStyle(
                                  color: AppColors.greyshadetext,
                                  fontFamily: "kodchasan",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: MaterialButtonWidget(
                      buttonBgColor: Colors.transparent,
                      buttonRadius: 8,
                      isOutlined: true,
                      borderColor: Colors.black,
                      buttonText: "strPhotoCancel".tr,
                      buttonTextStyle: const TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontFamily: "Kodchasan",
                        fontWeight: FontWeight.w600,
                      ),
                      textColor: AppColors.whiteColor,
                      onPressed: () =>
                          {Get.back(), controller.imageList.clear()},
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Obx(
                      () => MaterialButtonWidget(
                        isloading: controller.isLoading.value,
                        buttonBgColor: AppColors.clickTextColor,
                        buttonRadius: 8,
                        buttonText: "strSave".tr,
                        buttonTextStyle: const TextStyle(
                          fontSize: 12,
                          color: AppColors.whiteColor,
                          fontFamily: "Kodchasan",
                          fontWeight: FontWeight.w600,
                        ),
                        textColor: AppColors.whiteColor,
                        onPressed: () async {
                          if (controller.imageList.isNotEmpty) {
                            controller.uploadAllImages();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ).marginSymmetric(horizontal: 15),
            ],
          );
        }),
      ),
    );
  }
}

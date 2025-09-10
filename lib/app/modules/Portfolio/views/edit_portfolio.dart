import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../core/widget/asset_image_widget.dart';
import '../../../core/widget/custom_text_field.dart';
import '../../../core/widget/network_image_widget.dart';
import '../../../core/widget/text_view.dart';
import '../../../core/widget/material_button_widget.dart';
import '../../home/models/requestModels/buyplanRequestModel.dart';
import '../controller/edit_portfolio_controller.dart';
import '../controller/portfolio_controller.dart';

class EditPortfolio extends StatelessWidget {
  const EditPortfolio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditPortfolioController>(
      init: EditPortfolioController(),
      builder: (controller) {
        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.buttonColor,
          child: Scaffold(
            backgroundColor: AppColors.buttonColor.withOpacity(0.3),
            body: SafeArea(
              child: Obx(() => GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Column(
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
                                text: "strEditPortfolio".tr,
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
                          ),
                        ),
                        Expanded(
                            child: Skeletonizer(
                                enabled: controller.isLoading.value,
                                child: SingleChildScrollView(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      fullName(controller),
                                      instagramLink(controller),
                                      YouTubeLink(controller),
                                      Obx(() => controller.pickedImage.value ==
                                                  null &&
                                              controller
                                                      .portfolioResponseModel
                                                      .value
                                                      .data
                                                      ?.setCards
                                                      ?.length ==
                                                  0
                                          ? setCard(controller)
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                TextView(
                                                  text: "strSetCard".tr,
                                                  textStyle: const TextStyle(
                                                    color: AppColors.blackColor,
                                                    fontFamily: "kodchasan",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ).marginOnly(bottom: 10),
                                                Stack(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                      height: Get.height * 0.3,
                                                      width: Get.width,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                        child: Obx(
                                                          () {
                                                            if (controller
                                                                    .pickedImage
                                                                    .value !=
                                                                null) {
                                                              return Image.file(
                                                                controller
                                                                    .pickedImage
                                                                    .value!,
                                                                fit: BoxFit
                                                                    .cover,
                                                              );
                                                            } else if (controller
                                                                    .portfolioResponseModel
                                                                    .value
                                                                    .data
                                                                    ?.setCards
                                                                    ?.length !=
                                                                0) {
                                                              return NetworkImageWidget(
                                                                imageUrl: controller
                                                                        .portfolioResponseModel
                                                                        .value
                                                                        .data
                                                                        ?.setCards?[0] ??
                                                                    "",
                                                                imageHeight:
                                                                    Get.height *
                                                                        0.3,
                                                                imageFitType:
                                                                    BoxFit.fill,
                                                                imageWidth:
                                                                    Get.width,
                                                                radiusAll: 10,
                                                              );
                                                            }
                                                            // Display locally picked image if available
                                                            // Fallback to person icon with light grey background
                                                            else {
                                                              return Container(
                                                                color: AppColors
                                                                    .buttonColor,
                                                                child: Icon(
                                                                  Icons.person,
                                                                  size: 80,
                                                                  color: AppColors
                                                                      .whiteColor,
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                        top: 5,
                                                        right: 5,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .pickedImage
                                                                .value = null;
                                                            // Optionally clear the network image data if needed
                                                            if (controller
                                                                    .portfolioResponseModel
                                                                    .value
                                                                    .data !=
                                                                null) {
                                                              controller
                                                                  .portfolioResponseModel
                                                                  .value
                                                                  .data
                                                                  ?.setCards = [];
                                                              controller
                                                                  .setCardController
                                                                  .text = "";
                                                            } else if (controller
                                                                    .userResponseModel
                                                                    ?.data !=
                                                                null) {
                                                              controller
                                                                  .userResponseModel
                                                                  ?.data
                                                                  ?.image = "";
                                                            }
                                                            // Notify the UI to rebuild
                                                            controller.update();
                                                          },
                                                          child: Icon(
                                                            Icons.cancel,
                                                            color: AppColors
                                                                .buttonColor,
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ],
                                            ).marginOnly(top: 10)),
                                    ]).marginSymmetric(
                                        horizontal: 20, vertical: 20)))),
                        Obx(() => MaterialButtonWidget(
                              isloading: controller.isLoading.value,
                              buttonBgColor: AppColors.clickTextColor,
                              buttonRadius: 8,
                              buttonText: "strSave".tr,
                              textColor: AppColors.whiteColor,
                              onPressed: () {
                                // Handle photo upload if a photo is selected
                                if (controller.pickedImage.value != null) {
                                  controller.callUploadMedia(
                                      controller.pickedImage.value!);
                                }

                                // Handle portfolio submission if setCards is not empty or any text fields are filled
                                if (controller.portfolioResponseModel.value.data
                                            ?.setCards?.isNotEmpty ==
                                        true ||
                                    controller
                                        .aboutMeController.text.isNotEmpty ||
                                    controller.instagramLinkController.text
                                        .isNotEmpty ||
                                    controller.YoutubeLinkController.text
                                        .isNotEmpty) {
                                  Map<String, dynamic> requestModel =
                                      BuyPlanRequestModel
                                          .postPortfolioRequestModel(
                                    aboutMe: controller.aboutMeController.text,
                                    setCards: controller.portfolioResponseModel
                                        .value.data?.setCards,
                                    links: [
                                      if (controller.instagramLinkController
                                          .text.isNotEmpty)
                                        {
                                          "platform": "Instagram",
                                          "url": controller
                                              .instagramLinkController.text,
                                        },
                                      if (controller.YoutubeLinkController.text
                                          .isNotEmpty)
                                        {
                                          "platform": "Youtube",
                                          "url": controller
                                              .YoutubeLinkController.text,
                                        },
                                    ],
                                  );
                                  controller.postPortfolio(requestModel);
                                } else {
                                  if (controller.portfolioResponseModel.value
                                              .data?.setCards?.isNotEmpty ==
                                          null ||
                                      controller
                                          .aboutMeController.text.isEmpty ||
                                      controller.instagramLinkController.text
                                          .isEmpty ||
                                      controller
                                          .YoutubeLinkController.text.isEmpty) {
                                    Map<String, dynamic> requestModel =
                                        BuyPlanRequestModel
                                            .postPortfolioRequestModel(
                                      aboutMe:
                                          controller.aboutMeController.text,
                                      setCards: [],
                                      links: [
                                        {
                                          "platform": "Instagram",
                                          "url": "",
                                        },
                                        {"platform": "Youtube", "url": ""},
                                      ],
                                    );
                                    controller.postPortfolio(requestModel);
                                  }
                                }
                              },
                            ).marginSymmetric(vertical: 20, horizontal: 20)),
                      ],
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }

  Widget fullName(controller) => TextFieldWidget(
        hint: "strWriteHere".tr,
        textColors: Colors.black,
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        label: "strAboutMe".tr,
        textlableStyle: TextStyle(
            color: Colors.black,
            fontFamily: "Kodchasan",
            fontWeight: FontWeight.w900),

        maxline: 7, // Already set for multiline support
        minLine: 6, // Start with 3 visible lines for better visibility
        lableColor: AppColors.blackColor,
        textController: controller.aboutMeController,
        fillColor: AppColors.whiteColor,
        borderColor: AppColors.buttonColor,
        courserColor: AppColors.textfieldBorderColor,
        focusNode: controller.aboutMeFocusNode,
        inputType: TextInputType
            .multiline, // Changed to multiline for better keyboard support
        contentPadding: EdgeInsets.symmetric(
          horizontal: margin_15,
          vertical: margin_20, // Increased vertical padding for multiline
        ),
        // validate: (value) => NameValidator.validateName(
        //   title: "strFullName".tr,
        //   value: value?.trim() ?? '',
        // ),
        // maxLength: 200, // Optional: Limit total characters
      );

  Widget instagramLink(controller) => TextFieldWidget(
        hint: "strInstaLink".tr,
        textColors: Colors.black,
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        label: "strInstaLink".tr,
        textlableStyle: TextStyle(
            color: Colors.black,
            fontFamily: "Kodchasan",
            fontWeight: FontWeight.w900),

        maxline: 1, // Already set for multiline support
        minLine: 1, // Start with 3 visible lines for better visibility
        lableColor: AppColors.blackColor,
        textController: controller.instagramLinkController,
        fillColor: AppColors.whiteColor,
        borderColor: AppColors.buttonColor,
        courserColor: AppColors.textfieldBorderColor,
        focusNode: controller.inastagramLinkFocusNode,
        inputType: TextInputType
            .multiline, // Changed to multiline for better keyboard support
        contentPadding: EdgeInsets.symmetric(
          horizontal: margin_15,
          vertical: margin_20, // Increased vertical padding for multiline
        ),
        // validate: (value) => NameValidator.validateName(
        //   title: "strFullName".tr,
        //   value: value?.trim() ?? '',
        // ),
        maxLength: 200, // Optional: Limit total characters
      ).marginOnly(top: 10);

  Widget YouTubeLink(controller) => TextFieldWidget(
        hint: "strYouTubeLink".tr,
        textColors: Colors.black,
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        label: "strYouTubeLink".tr,
        textlableStyle: TextStyle(
            color: Colors.black,
            fontFamily: "Kodchasan",
            fontWeight: FontWeight.w900),

        maxline: 1, // Already set for multiline support
        minLine: 1, // Start with 3 visible lines for better visibility
        lableColor: AppColors.blackColor,
        textController: controller.YoutubeLinkController,
        fillColor: AppColors.whiteColor,
        borderColor: AppColors.buttonColor,
        courserColor: AppColors.textfieldBorderColor,
        focusNode: controller.YouTubeLinkFocusNode,
        inputType: TextInputType
            .multiline, // Changed to multiline for better keyboard support
        contentPadding: EdgeInsets.symmetric(
          horizontal: margin_15,
          vertical: margin_20, // Increased vertical padding for multiline
        ),
        // validate: (value) => NameValidator.validateName(
        //   title: "strFullName".tr,
        //   value: value?.trim() ?? '',
        // ),
        maxLength: 200, // Optional: Limit total characters
      ).marginOnly(top: 10);

  Widget setCard(controller) => TextFieldWidget(
        onTap: () {
          controller.pickImage(ImageSource.gallery);
        },
        hint: "strUpload".tr,
        textColors: Colors.black,
        hintStyle: TextStyle(
          color: AppColors.greyColor,
          fontFamily: "Kodchasan",
        ),
        label: "strSetCard".tr,
        textlableStyle: TextStyle(
            color: Colors.black,
            fontFamily: "Kodchasan",
            fontWeight: FontWeight.w900),
        suffixIcon: Image.asset(
          iconfile,
          height: 20,
          width: 20,
        ).marginSymmetric(horizontal: 20),
        maxline: 1, // Already set for multiline support
        minLine: 1,
        readOnly: true, // Start with 3 visible lines for better visibility
        lableColor: AppColors.blackColor,
        textController: controller.setCardController,
        fillColor: AppColors.whiteColor,
        borderColor: AppColors.buttonColor,
        courserColor: AppColors.textfieldBorderColor,
        focusNode: controller.setCardFocusNode,
        inputType: TextInputType
            .multiline, // Changed to multiline for better keyboard support
        contentPadding: EdgeInsets.symmetric(
          horizontal: margin_15,
          vertical: margin_20, // Increased vertical padding for multiline
        ),
        // validate: (value) => NameValidator.validateName(
        //   title: "strFullName".tr,
        //   value: value?.trim() ?? '',
        // ),
        maxLength: 200, // Optional: Limit total characters
      ).marginOnly(top: 10);
}

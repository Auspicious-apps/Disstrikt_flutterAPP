import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/utils/localization_service.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../core/widget/asset_image_widget.dart';
import '../../../core/widget/text_view.dart';
import '../Controller/StaticController.dart';
import '../Controller/supportController.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Supportcontroller>(
      init: Supportcontroller(),
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
                              text: "strSupport".tr,
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
                        enabled: controller.isLoading.value,
                        child: SingleChildScrollView(
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.makePhoneCall(controller
                                            .staticdatamodel
                                            ?.data
                                            ?.support
                                            ?.phone ??
                                        "");
                                  },
                                  child: Row(
                                    children: [
                                      AssetImageWidget(
                                        iconsSupportPhone,
                                        imageWidth: 30,
                                        imageHeight: height_30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextView(
                                            text: "supportPhone".tr,
                                            textStyle: const TextStyle(
                                              color: AppColors.greyshadetext,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextView(
                                            text:
                                                "${controller.staticdatamodel?.data?.support?.phone ?? "No Available"}",
                                            textStyle: TextStyle(
                                              color: controller
                                                              .staticdatamodel
                                                              ?.data
                                                              ?.support
                                                              ?.phone !=
                                                          null ||
                                                      controller
                                                              .staticdatamodel
                                                              ?.data
                                                              ?.support
                                                              ?.phone !=
                                                          ""
                                                  ? Colors.blue
                                                  : AppColors.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ).marginSymmetric(horizontal: 20),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.openEmailClient(controller
                                            .staticdatamodel
                                            ?.data
                                            ?.support
                                            ?.email ??
                                        "");
                                  },
                                  child: Row(
                                    children: [
                                      AssetImageWidget(
                                        iconsSupportEmail,
                                        imageWidth: 30,
                                        imageHeight: height_30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextView(
                                            text: "supportEmail".tr,
                                            textStyle: const TextStyle(
                                              color: AppColors.greyshadetext,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextView(
                                            text:
                                                "${controller.staticdatamodel?.data?.support?.email ?? "No Available"}",
                                            textStyle: TextStyle(
                                              color: controller
                                                              .staticdatamodel
                                                              ?.data
                                                              ?.support
                                                              ?.email !=
                                                          null ||
                                                      controller
                                                              .staticdatamodel
                                                              ?.data
                                                              ?.support
                                                              ?.email !=
                                                          ""
                                                  ? Colors.blue
                                                  : AppColors.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ).marginSymmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                Row(
                                  children: [
                                    AssetImageWidget(
                                      iconsSupportAddress,
                                      imageWidth: 30,
                                      imageHeight: height_30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextView(
                                          text: "supportAddress".tr,
                                          textStyle: const TextStyle(
                                            color: AppColors.greyshadetext,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextView(
                                          text:
                                              "${getBookTitle(name: controller.staticdatamodel?.data?.support?.address)}",
                                          textStyle: const TextStyle(
                                            color: AppColors.blackColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ).marginSymmetric(horizontal: 20),
                              ],
                            ).marginSymmetric(vertical: 20),
                          ).marginSymmetric(vertical: 20, horizontal: 15),
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

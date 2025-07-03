import 'package:disstrikt/app/core/widget/annotated_region_widget.dart';
import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widget/asset_image_widget.dart';
import '../../../core/widget/text_view.dart';
import '../../../core/widget/material_button_widget.dart';
import '../../../core/utils/localization_service.dart';
import '../controllers/choose_language_controller.dart';

class ChooseLanguageScreen extends GetView<ChooseLanguageController> {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegionWidget(
      statusBarBrightness: Brightness.light,
      statusBarColor: Color.fromRGBO(37, 33, 34, 1),
      child: Scaffold(
        body: Stack(
          children: [
            AssetImageWidget(
              onBoardingimage,
              imageHeight: Get.height,
              imageWidth: Get.width,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: Get.width,
              child: Obx(() => Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),

                      // Header
                      TextView(
                        text: "strChooseYour".tr,
                        textStyle: const TextStyle(
                            color: AppColors.whiteColor,
                            fontFamily: "minorksans",
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                        maxLines: 4,
                      ).marginSymmetric(vertical: margin_20),

                      // Country Selection
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: "strCountry".tr,
                            textStyle: const TextStyle(
                                color: AppColors.whiteColor,
                                fontFamily: "minorksans",
                                fontSize: 14,
                                fontWeight: FontWeight.w800),
                            maxLines: 4,
                          ).marginSymmetric(
                              vertical: margin_10, horizontal: margin_22),

                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              children: [
                                // Show selected country flag or default icon
                                Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: AssetImageWidget(
                                      network,
                                      imageHeight: 20,
                                    )),

                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        "strSelectCountry".tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      items: controller.countries
                                          .map((String country) =>
                                              DropdownMenuItem<String>(
                                                value: country,
                                                child: Row(
                                                  children: [
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        country,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                      value: controller
                                              .selectedCountry.value.isEmpty
                                          ? null
                                          : controller.selectedCountry.value,
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        decoration: BoxDecoration(
                                          color: AppColors.backgroundColor,
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onChanged: (String? value) {
                                        if (value != null) {
                                          controller.changeCountry(value);
                                        }
                                      },
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                        ),
                                      ),
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        height: 50,
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).marginSymmetric(horizontal: 20),

                          // Language Selection
                          TextView(
                            text: "strChooseLanguages".tr,
                            textStyle: const TextStyle(
                                color: AppColors.whiteColor,
                                fontFamily: "minorksans",
                                fontSize: 14,
                                fontWeight: FontWeight.w800),
                            maxLines: 4,
                          ).marginSymmetric(
                              vertical: margin_10, horizontal: margin_22),

                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              children: [
                                // Show selected language flag or default icon
                                Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: AssetImageWidget(
                                      language,
                                      imageHeight: 20,
                                    )),

                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        "strSelectLanguage".tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      items: controller.languages
                                          .map((String language) =>
                                              DropdownMenuItem<String>(
                                                value: language,
                                                child: Row(
                                                  children: [
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        language,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                      value: controller
                                              .selectedLanguage.value.isEmpty
                                          ? null
                                          : controller.selectedLanguage.value,
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        decoration: BoxDecoration(
                                          color: AppColors.backgroundColor,
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onChanged: (String? value) {
                                        if (value != null) {
                                          controller.changeLanguage(value);
                                        }
                                      },
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                        ),
                                      ),
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        height: 50,
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).marginSymmetric(horizontal: 20),
                        ],
                      ),
                      const Spacer(),
                      MaterialButtonWidget(
                        buttonBgColor: AppColors.buttonColor,
                        buttonRadius: 8,
                        buttonText: "strNext".tr,
                        iconWidget: Icon(Icons.arrow_forward_sharp,
                            color: AppColors.backgroundColor),
                        textColor: AppColors.backgroundColor,
                        onPressed: () {
                          print(
                              ">>>>>>>>>>>${controller.selectedCountry.value}");
                          print(
                              ">>>>>>>>>>>${controller.selectedLanguage.value}");
                          var token = controller.localStorage.getAuthToken();
                          if (token != null) {
                            Get.toNamed(AppRoutes.ChoosePlan);
                            // Get.toNamed(AppRoutes.UserInfo, arguments: {
                            //   "country": controller.selectedCountry.value ==
                            //           "United Kingdom"
                            //       ? "UK"
                            //       : controller.selectedCountry.value == "Belgium"
                            //           ? "BE"
                            //           : controller.selectedCountry.value == "France"
                            //               ? "FR"
                            //               : controller.selectedCountry.value ==
                            //                       "Netherlands"
                            //                   ? "NL"
                            //                   : "ES",
                            //   "language":
                            //       controller.selectedLanguage.value == "English"
                            //           ? "en"
                            //           : controller.selectedLanguage.value == "Dutch"
                            //               ? "nl"
                            //               : controller.selectedLanguage.value ==
                            //                       "French"
                            //                   ? "fr"
                            //                   : "es",
                            // });
                          } else {
                            Get.toNamed(AppRoutes.signupRoute, arguments: {
                              "country": controller.selectedCountry.value ==
                                      "United Kingdom"
                                  ? "UK"
                                  : controller.selectedCountry.value ==
                                          "Belgium"
                                      ? "BE"
                                      : controller.selectedCountry.value ==
                                              "France"
                                          ? "FR"
                                          : controller.selectedCountry.value ==
                                                  "Netherlands"
                                              ? "NL"
                                              : "ES",
                              "language": controller.selectedLanguage.value ==
                                      "English"
                                  ? "en"
                                  : controller.selectedLanguage.value == "Dutch"
                                      ? "nl"
                                      : controller.selectedLanguage.value ==
                                              "French"
                                          ? "fr"
                                          : "es",
                            });
                          }

                          // controller.next();
                        },
                      ).marginSymmetric(horizontal: 20, vertical: 20),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

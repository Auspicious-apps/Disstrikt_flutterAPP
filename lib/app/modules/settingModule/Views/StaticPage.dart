import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/utils/localization_service.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../core/widget/asset_image_widget.dart';
import '../../../core/widget/text_view.dart';
import '../../../core/widget/material_button_widget.dart';
import '../Controller/StaticController.dart';

class Staticpage extends StatelessWidget {
  const Staticpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Staticcontroller>(
      init: Staticcontroller(),
      builder: (controller) {
        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.buttonColor,
          child: Scaffold(
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
                              text: "${controller.titile.value}",
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
                        child: controller.isLoading.value
                            ? _buildSkeletonTextLines() // Placeholder for text lines
                            : SingleChildScrollView(
                                child: Container(
                                  width: Get.width,
                                  child: Html(
                                    data: getBookTitle(
                                        name: controller.from == "Terms"
                                            ? controller.staticdatamodel?.data
                                                ?.termAndCondition
                                            : controller.staticdatamodel?.data
                                                ?.privacyPolicy),
                                    style: {
                                      'p': Style(
                                          fontSize: FontSize(14),
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(68, 68, 68, 1),
                                          fontFamily: "Kodchasan"),
                                      'h2': Style(
                                        fontSize: FontSize(14),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    },
                                  ),
                                ).marginSymmetric(horizontal: 10),
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
    // Default title if name is null or invalid
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
          ;
        case 'es':
          return name.es?.toString();
          ;
        default:
          return defaultTitle;
      }
    } catch (e) {
      // Handle case where name is not null but doesn't have the expected properties
      print("Error in getBookTitle: $e");
      return defaultTitle;
    }
  }

  Widget _buildSkeletonTextLines() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Simulate a heading
        Skeleton.leaf(
          child: Container(
            width: Get.width * 0.6,
            height: 20,
            color: Colors.grey[300],
            margin: const EdgeInsets.only(bottom: 10),
          ),
        ),
        // Simulate multiple paragraph lines
        for (int i = 0; i < 5; i++)
          Skeleton.leaf(
            child: Container(
              width: Get.width * (0.9 - i * 0.1), // Varying widths for realism
              height: 14,
              color: Colors.grey[300],
              margin: const EdgeInsets.only(bottom: 8),
            ),
          ),
        // Simulate another heading
        Skeleton.leaf(
          child: Container(
            width: Get.width * 0.5,
            height: 20,
            color: Colors.grey[300],
            margin: const EdgeInsets.only(bottom: 10, top: 10),
          ),
        ),
        // More paragraph lines
        for (int i = 0; i < 3; i++)
          Skeleton.leaf(
            child: Container(
              width: Get.width * 0.85,
              height: 14,
              color: Colors.grey[300],
              margin: const EdgeInsets.only(bottom: 8),
            ),
          ),
      ],
    ).marginOnly(top: 10, left: 20, right: 20);
  }
}

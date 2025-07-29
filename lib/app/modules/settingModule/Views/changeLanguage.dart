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
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/custom_text_field.dart';
import '../../../core/widget/text_view.dart';
import '../../../core/widget/validator.dart';
import '../../auth/models/requestmodels/RequestModel.dart';
import '../Controller/StaticController.dart';
import '../Controller/changeLanguageController.dart'
    show Changelanguagecontroller;
import '../Controller/changePasswordController.dart';
import '../Controller/supportController.dart';

class Changelanguage extends StatelessWidget {
  const Changelanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Changelanguagecontroller>(
      init: Changelanguagecontroller(),
      builder: (controller) {
        return AnnotatedRegionWidget(
            statusBarBrightness: Brightness.light,
            statusBarColor: AppColors.buttonColor,
            child: Scaffold(
              backgroundColor: AppColors.buttonColor.withOpacity(0.3),
              body: Obx(
                () => Column(
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
                                      text: "strLanguage".tr,
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
                            TextView(
                              text: "strSelectedLanguage".tr,
                              textStyle: const TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ).marginSymmetric(horizontal: 20, vertical: 20),
                            Container(
                              width: Get.width,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColors.buttonColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    text: controller.value.value == "English"
                                        ? "strEnglish".tr
                                        : controller.value.value == "Dutch"
                                            ? "strDutch".tr
                                            : controller.value.value == "French"
                                                ? "strFrench".tr
                                                : "strSpanish".tr,
                                    textStyle: const TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 14,
                                      fontFamily: "Kodchasan",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ).marginSymmetric(horizontal: 20),
                                ],
                              ),
                            ).marginSymmetric(horizontal: 20),
                            TextView(
                              text: "strPreffered".tr,
                              textStyle: const TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ).marginSymmetric(horizontal: 20, vertical: 20),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.countries.length,
                              itemBuilder: (BuildContext context, int index) {
                                final String country =
                                    controller.countries[index];
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.value.value = country;
                                        controller.value.refresh();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: Row(
                                          children: [
                                            controller.value.value == country
                                                ? AssetImageWidget(
                                                    iconsCheckMark,
                                                    imageHeight: 20,
                                                    imageWidth: 20,
                                                  )
                                                : SizedBox(
                                                    width: 20,
                                                  ),
                                            Text(
                                              country == "English"
                                                  ? "strEnglish".tr
                                                  : country == "Dutch"
                                                      ? "strDutch".tr
                                                      : country == "French"
                                                          ? "strFrench".tr
                                                          : "strSpanish".tr,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ).marginSymmetric(horizontal: 20),
                                          ],
                                        ),
                                      ).paddingSymmetric(vertical: 10),
                                    ),
                                    index != (controller.countries.length - 1)
                                        ? Divider(
                                            color: AppColors.buttonColor,
                                          )
                                        : SizedBox()
                                  ],
                                ).marginSymmetric(horizontal: 20);
                              },
                            ),
                          ],
                        ).marginOnly(bottom: Get.height * 0.02),
                      ),
                    ),
                    Obx(() => MaterialButtonWidget(
                          isloading: controller.isloading.value,
                          buttonBgColor: AppColors.buttonColor,
                          buttonRadius: 8,
                          buttonText: "strChange".tr,
                          iconWidget: Icon(Icons.arrow_forward_sharp,
                              color: AppColors.backgroundColor),
                          textColor: AppColors.backgroundColor,
                          onPressed: () {
                            LocalizationService.changeLocale(
                                controller.value.value);

                            Map<String, dynamic> requestModel =
                                AuthRequestModel.ChangeLanguageRequestModel(
                              updatedLanguage:
                                  controller.value.value == "English"
                                      ? "en"
                                      : controller.value.value == "Dutch"
                                          ? "nl"
                                          : controller.value.value == "French"
                                              ? "fr"
                                              : "es",
                            );

                            controller.handleSubmit(requestModel);
                            Get.back();
                          },
                        ).marginSymmetric(vertical: 10, horizontal: 20)),
                  ],
                ),
              ),
            ));
      },
    );
  }
}

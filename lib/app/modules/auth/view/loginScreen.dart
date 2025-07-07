import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:disstrikt/app/core/widget/annotated_region_widget.dart';
import 'package:disstrikt/app/modules/auth/controllers/login_controller.dart';
import 'package:disstrikt/app/modules/auth/controllers/signupcontroller.dart';
import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../core/widget/asset_image_widget.dart';
import '../../../core/widget/custom_text_field.dart';
import '../../../core/widget/intl_phone_field/country_picker_text_field.dart';
import '../../../core/widget/text_view.dart';
import '../../../core/widget/material_button_widget.dart';
import '../../../core/utils/localization_service.dart';
import '../../../core/widget/validator.dart';
import '../models/requestmodels/RequestModel.dart';

class Loginscreen extends GetView<LoginController> {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegionWidget(
      statusBarBrightness: Brightness.light,
      statusBarColor: AppColors.blackColor,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(signupBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Center(
              // Added Center widget to ensure horizontal centering
              child: SingleChildScrollView(
                child: Form(
                  key: controller.signupFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center vertically
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center horizontally
                    children: [
                      SizedBox(
                        height: Get.height * 0.15,
                      ),
                      TextView(
                        text: "strLogintoyour".tr,
                        textStyle: const TextStyle(
                            color: AppColors.whiteColor,
                            fontFamily: "minorksans",
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                        maxLines: 4,
                      ),
                      TextView(
                        text: "strkindlyprovideyour".tr,
                        textAlign: TextAlign.center,
                        textStyle: const TextStyle(
                          color: AppColors.smalltextColor,
                          fontFamily: "Kodchasan",
                          fontSize: 12,
                        ),
                        maxLines: 4,
                      ).marginOnly(bottom: 20, top: 10),
                      _EmailAddress().marginSymmetric(vertical: 10),
                      _Password(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(() => controller.rememberMe.value
                                  ? GestureDetector(
                                      onTap: () {
                                        controller.rememberMe.value = false;
                                        controller.rememberMe.refresh();
                                      },
                                      child: Icon(
                                        Icons.check_box,
                                        color: Colors.white,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        controller.rememberMe.value = true;
                                        controller.rememberMe.refresh();
                                      },
                                      child: Icon(
                                        Icons.check_box_outline_blank_rounded,
                                        color: Colors.white,
                                      ),
                                    )),
                              TextView(
                                text: "strRememberme".tr,
                                textStyle: const TextStyle(
                                    color: AppColors.textfieldBorderColor,
                                    fontFamily: "Kodchasan",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                                maxLines: 4,
                              ).marginSymmetric(horizontal: 5),
                            ],
                          ).marginSymmetric(vertical: 10),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.forgetEmail);
                            },
                            child: TextView(
                              text: "strForgetPassword".tr,
                              textStyle: const TextStyle(
                                  color: AppColors.voilet,
                                  fontFamily: "Kodchasan",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                              maxLines: 4,
                            ).marginSymmetric(horizontal: 5),
                          ),
                        ],
                      ),
                      Obx(() => MaterialButtonWidget(
                            isloading: controller.isloading.value,
                            buttonBgColor: AppColors.buttonColor,
                            buttonRadius: 8,
                            buttonText: "strLogin".tr,
                            iconWidget: Icon(Icons.arrow_forward_sharp,
                                color: AppColors.backgroundColor),
                            textColor: AppColors.backgroundColor,
                            onPressed: () {
                              if (controller.signupFormKey.currentState!
                                  .validate()) {
                                if (controller.isloading.value == false) {
                                  controller.isloading.value = true;
                                  controller.isloading.refresh();
                                  Map<String, dynamic> requestModel =
                                      AuthRequestModel.LoginRequestModel(
                                          email: controller
                                              .emailAddressController?.text
                                              ?.trim(),
                                          country: controller.country.value ==
                                                  "United Kingdom"
                                              ? "UK"
                                              : controller
                                                          .country.value ==
                                                      "Belgium"
                                                  ? "BE"
                                                  : controller
                                                              .country.value ==
                                                          "France"
                                                      ? "FR"
                                                      : controller.country
                                                                  .value ==
                                                              "Netherlands"
                                                          ? "NL"
                                                          : "ES",
                                          language: controller
                                                      .language.value ==
                                                  "English"
                                              ? "en"
                                              : controller
                                                          .language.value ==
                                                      "Dutch"
                                                  ? "nl"
                                                  : controller
                                                              .language.value ==
                                                          "French"
                                                      ? "fr"
                                                      : "es",
                                          password: controller
                                              .PasswordTextController.text,
                                          fcmToken: controller.fcmtoken.value);
                                  controller.handleSubmit(requestModel);
                                }
                              }
                            },
                          ).marginSymmetric(vertical: 20)),
                      TextView(
                        text: "strOr".tr,
                        textAlign: TextAlign.center,
                        textStyle: const TextStyle(
                          color: AppColors.smalltextColor,
                          fontFamily: "Kodchasan",
                          fontSize: 12,
                        ),
                        maxLines: 4,
                      ).marginOnly(bottom: 10, top: 10),
                      Container(
                        height: 49,
                        decoration: BoxDecoration(
                            color: AppColors.textfieldcolor,
                            border: Border.all(
                                color: AppColors.textfieldBorderColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AssetImageWidget(
                              googleicon,
                              imageHeight: 20,
                              imageWidth: 20,
                            ).marginSymmetric(horizontal: 5),
                            TextView(
                              text: "strContinueGoogle".tr,
                              textAlign: TextAlign.center,
                              textStyle: const TextStyle(
                                color: AppColors.smalltextColor,
                                fontFamily: "Kodchasan",
                                fontSize: 12,
                              ),
                              maxLines: 4,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 49,
                        decoration: BoxDecoration(
                            color: AppColors.textfieldcolor,
                            border: Border.all(
                                color: AppColors.textfieldBorderColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AssetImageWidget(
                              appleicon,
                              imageHeight: 20,
                              imageWidth: 20,
                            ).marginSymmetric(horizontal: 5),
                            TextView(
                              text: "strContinueApple".tr,
                              textAlign: TextAlign.center,
                              textStyle: const TextStyle(
                                color: AppColors.smalltextColor,
                                fontFamily: "Kodchasan",
                                fontSize: 12,
                              ),
                              maxLines: 4,
                            ),
                          ],
                        ),
                      ).marginSymmetric(vertical: 10),
                      SizedBox(
                        height: Get.height * 0.12,
                      ),
                      Container(
                        color: Colors.transparent,
                        child: _termOfUse(),
                      )
                    ],
                  ).marginSymmetric(horizontal: 20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _EmailAddress() => TextFieldWidget(
        hint: "strEmailAddress".tr,
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        prefixIcon: SizedBox(
            height: 10,
            width: 10,
            child: Image.asset(
              emails,
              height: 10,
              width: 10,
            )).marginAll(10),
        textController: controller.emailAddressController,
        fillColor: AppColors.textfieldcolor,
        borderColor: AppColors.textfieldBorderColor,
        courserColor: AppColors.textfieldBorderColor,
        maxLength: 30,
        validate: (value) => EmailValidator.validateEmail(value?.trim() ?? ""),
        focusNode: controller.emailAddressFocusNode,
        inputType: TextInputType.emailAddress,
      );

  Widget _Password() => Obx(() => TextFieldWidget(
        hint: "strPassword".tr,
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        prefixIcon: SizedBox(
            height: 10,
            width: 10,
            child: Image.asset(
              iconpassword,
              height: 10,
              width: 10,
            )).marginAll(10),
        textController: controller.PasswordTextController,
        fillColor: AppColors.textfieldcolor,
        borderColor: AppColors.textfieldBorderColor,
        courserColor: AppColors.textfieldBorderColor,
        validate: (value) =>
            PasswordFormValidator.validatePassword(value?.trim() ?? ""),
        obscureText: controller.ShowPassword.value,
        onTap: () {
          controller.ShowPassword.value = !controller.ShowPassword.value;
        },
        suffixIcon: !controller.ShowPassword.value
            ? GestureDetector(
                onTap: () => {
                      controller.ShowPassword.value =
                          !controller.ShowPassword.value
                    },
                child: SizedBox(
                    height: 10,
                    width: 10,
                    child: Image.asset(
                      iconcloseeye,
                      height: 10,
                      width: 10,
                    )).marginAll(10))
            : GestureDetector(
                onTap: () => {
                      controller.ShowPassword.value =
                          !controller.ShowPassword.value
                    },
                child: SizedBox(
                    height: 10,
                    width: 10,
                    child: Image.asset(
                      iconopeneye,
                      height: 10,
                      width: 10,
                    )).marginAll(10)),
        maxLength: 30,
        focusNode: controller.PasswordFocusNode,
        inputType: TextInputType.text,
      ));

  _termOfUse() => Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: "strDon'thave".tr,
          style: textStyleBodyLarge().copyWith(
            color: AppColors.smalltextColor,
            fontSize: 12,
            fontFamily: "Kodchasan",
          ),
          children: [
            TextSpan(
                text: "strSignup".tr,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.offNamed(AppRoutes.signupRoute);
                  },
                style: textStyleTitleSmall().copyWith(
                  color: AppColors.voilet,
                  fontSize: 14,
                  fontFamily: "Kodchasan",
                )),
          ],
        ),
      );
}

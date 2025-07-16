import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:disstrikt/app/core/widget/annotated_region_widget.dart';
import 'package:disstrikt/app/modules/auth/controllers/signupcontroller.dart';
import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

class Signupscreen extends GetView<Signupcontroller> {
  const Signupscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegionWidget(
      statusBarBrightness: Brightness.light,
      statusBarColor: AppColors.blackColor,
      bottomColor: AppColors.blackColor,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
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
                          height: Get.height * 0.1,
                        ),
                        TextView(
                          text: "strCreateanewaccount".tr,
                          textStyle: const TextStyle(
                              color: AppColors.whiteColor,
                              fontFamily: "minorksans",
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                          maxLines: 4,
                        ),
                        TextView(
                          text: "strFillYour".tr,
                          textStyle: const TextStyle(
                            color: AppColors.smalltextColor,
                            fontFamily: "Kodchasan",
                            fontSize: 12,
                          ),
                          maxLines: 4,
                        ).marginOnly(bottom: 20, top: 10),
                        _fullName(),
                        _EmailAddress().marginSymmetric(vertical: 10),
                        _Password(),
                        _ConfirmPassword().marginSymmetric(vertical: 10),
                        CountryPickerTextField(
                          controller: controller.mobileNumberTextController!,
                          focusNode: controller.mobileNumberFocusNode!,
                          hintText: 'strPhoneNumber'.tr,
                          showBorder: true,
                          showCountryFlag: true,
                          textInputAction: TextInputAction.done,
                          inputTextStyle: textStyleTitleMedium().copyWith(
                              color: AppColors.smalltextColor,
                              fontFamily: "Kodchasan",
                              fontSize: 13),
                          selectedCountry: controller.selectedCountry,
                          onCountryChanged: (value) {
                            controller.selectedCountry.value = value;
                          },
                          borderRadius: 10,
                        ),
                        SizedBox(
                          height: Get.height * 0.08,
                        ),
                        Obx(() => MaterialButtonWidget(
                              isloading: controller.isloading.value,
                              buttonBgColor: AppColors.buttonColor,
                              buttonRadius: 8,
                              buttonText: "strModelCreate".tr,
                              iconWidget: Icon(Icons.arrow_forward_sharp,
                                  color: AppColors.backgroundColor),
                              textColor: AppColors.backgroundColor,
                              onPressed: () async {
                                if (controller.signupFormKey.currentState!
                                    .validate()) {
                                  if (controller.isloading.value == false) {
                                    controller.isloading.value = true;
                                    controller.isloading.refresh();
                                    var selectedLanguage =
                                        LocalizationService.getLanguageName(
                                            LocalizationService.currentLocale);
                                    var selectedCountry =
                                        LocalizationService.currentCountry;
                                    print(
                                        "${selectedCountry}>>>>>>>>>>>>>>$selectedLanguage");
                                    Map<String, dynamic> requestModel =
                                        AuthRequestModel.SignupRequestModel(
                                            fullName: controller
                                                ?.fullNameController?.text,
                                            email: controller
                                                .emailAddressController?.text
                                                ?.trim(),
                                            countryCode:
                                                "+${controller.selectedCountry.value.dialCode}",
                                            phone: controller
                                                .mobileNumberTextController
                                                .text,
                                            country: selectedCountry ==
                                                    "United Kingdom"
                                                ? "UK"
                                                : selectedCountry == "Belgium"
                                                    ? "BE"
                                                    : selectedCountry ==
                                                            "France"
                                                        ? "FR"
                                                        : selectedCountry ==
                                                                "Netherlands"
                                                            ? "NL"
                                                            : "ES",
                                            language: selectedLanguage ==
                                                    "English"
                                                ? "en"
                                                : selectedLanguage == "Dutch"
                                                    ? "nl"
                                                    : selectedLanguage ==
                                                            "French"
                                                        ? "fr"
                                                        : "es",
                                            password: controller
                                                .ConfirmPasswordTextController
                                                .text,
                                            fcmToken: await FirebaseMessaging
                                                .instance
                                                .getToken());
                                    controller.handleSubmit(requestModel);
                                  }
                                }
                              },
                            ).marginSymmetric(vertical: 20)),
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
      ),
    );
  }

  Widget _fullName() => TextFieldWidget(
        hint: "strFullName".tr,
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        prefixIcon: SizedBox(
            height: 10,
            width: 10,
            child: Image.asset(
              email,
              height: 10,
              width: 10,
            )).marginAll(10),
        textController: controller.fullNameController,
        fillColor: AppColors.textfieldcolor,
        borderColor: AppColors.textfieldBorderColor,
        courserColor: AppColors.textfieldBorderColor,
        maxLength: 30,
        focusNode: controller.fullNameFocusNode,
        inputType: TextInputType.text,
        validate: (value) => NameValidator.validateName(
          title: "strFullName".tr,
          value: value?.trim() ?? '',
        ),
      );

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
        inputType: TextInputType.emailAddress,
        validate: (value) => EmailValidator.validateEmail(value?.trim() ?? ""),
        maxLength: 30,
        focusNode: controller.emailAddressFocusNode,
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
        obscureText: controller.ShowPassword.value,
        validate: (value) =>
            PasswordFormValidator.validatePassword(value?.trim() ?? ""),
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

  Widget _ConfirmPassword() => Obx(() => TextFieldWidget(
        hint: "strConfirmPassword".tr,
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
        textController: controller.ConfirmPasswordTextController,
        fillColor: AppColors.textfieldcolor,
        validate: (value) => PasswordFormValidator.validateConfirmPasswordMatch(
            value: value?.trim() ?? "",
            password: controller.PasswordTextController.text),
        borderColor: AppColors.textfieldBorderColor,
        courserColor: AppColors.textfieldBorderColor,
        obscureText: controller.ShowConfirmPassword.value,
        suffixIcon: !controller.ShowConfirmPassword.value
            ? GestureDetector(
                onTap: () => {
                      controller.ShowConfirmPassword.value =
                          !controller.ShowConfirmPassword.value
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
                      controller.ShowConfirmPassword.value =
                          !controller.ShowConfirmPassword.value
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
        focusNode: controller.ConfirmPasswordFocusNode,
        inputType: TextInputType.text,
      ));

  _termOfUse() => Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: "strAlreadyhaveAccount".tr,
          style: textStyleBodyLarge().copyWith(
            color: AppColors.smalltextColor,
            fontSize: 12,
            fontFamily: "Kodchasan",
          ),
          children: [
            TextSpan(
                text: "strLogin".tr,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.offNamed(AppRoutes.loginRoute);
                  },
                style: textStyleTitleSmall().copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.voilet,
                  color: AppColors.voilet,
                  fontSize: 14,
                  fontFamily: "Kodchasan",
                )),
          ],
        ),
      );
}

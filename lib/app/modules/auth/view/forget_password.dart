import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:disstrikt/app/core/widget/annotated_region_widget.dart';
import 'package:disstrikt/app/modules/auth/controllers/login_controller.dart';
import 'package:disstrikt/app/modules/auth/controllers/signupcontroller.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/localization_service.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_text_styles.dart';

import '../../../core/widget/custom_text_field.dart';

import '../../../core/widget/text_view.dart';
import '../../../core/widget/material_button_widget.dart';

import '../../../core/widget/validator.dart';
import '../../../routes/app_routes.dart';

import '../controllers/forget_password_controller.dart';
import '../models/requestmodels/RequestModel.dart';

class ForgetPassword extends GetView<ForgetPasswordController> {
  const ForgetPassword({Key? key}) : super(key: key);

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
            child: Stack(
              children: [
                Center(
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
                            height: Get.height * 0.25,
                          ),
                          TextView(
                            text: "strCreatepass".tr,
                            textStyle: const TextStyle(
                                color: AppColors.whiteColor,
                                fontFamily: "minorksans",
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                            maxLines: 4,
                          ),
                          TextView(
                            text: "strPassforget".tr,
                            textAlign: TextAlign.center,
                            textStyle: const TextStyle(
                              color: AppColors.smalltextColor,
                              fontFamily: "Kodchasan",
                              fontSize: 12,
                            ),
                            maxLines: 4,
                          ).marginOnly(bottom: 20, top: 10),
                          _Password(),
                          _ConfirmPassword().marginSymmetric(vertical: 10),
                          Obx(() => MaterialButtonWidget(
                                isloading: controller.isloading.value,
                                buttonBgColor: AppColors.buttonColor,
                                buttonRadius: 8,
                                buttonText: "strupdate".tr,
                                iconWidget: Icon(Icons.arrow_forward_sharp,
                                    color: AppColors.backgroundColor),
                                textColor: AppColors.backgroundColor,
                                onPressed: () {
                                  if (controller.signupFormKey.currentState!
                                      .validate()) {
                                    controller.isloading.value = true;
                                    controller.isloading.refresh();
                                    final language =
                                        LocalizationService.getLanguageName(
                                            LocalizationService.currentLocale);
                                    Map<String, dynamic> requestModel =
                                        AuthRequestModel.SignupRequestModel(
                                            password: controller
                                                .ConfirmPasswordTextController
                                                .text,
                                            language: language == "English"
                                                ? "en"
                                                : language == "Dutch"
                                                    ? "nl"
                                                    : language == "French"
                                                        ? "fr"
                                                        : "es");
                                    controller.handleSubmit(requestModel);
                                  }
                                },
                              ).marginSymmetric(vertical: 10)),
                          SizedBox(
                            height: Get.height * 0.25,
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
                GestureDetector(
                    onTap: () => {Get.back()},
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      ).marginOnly(left: 5),
                    ).marginSymmetric(horizontal: 20, vertical: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
        validate: (value) =>
            PasswordFormValidator.validatePassword(value?.trim() ?? ""),
        borderColor: AppColors.textfieldBorderColor,
        courserColor: AppColors.textfieldBorderColor,
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
          text: "strRememberPass".tr,
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
                    debugPrint("helllo>>>>>>>>>>>>>>");
                    Get.back();
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

import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:disstrikt/app/core/widget/annotated_region_widget.dart';
import 'package:disstrikt/app/core/widget/validator.dart';
import 'package:disstrikt/app/modules/auth/controllers/login_controller.dart';
import 'package:disstrikt/app/modules/auth/controllers/signupcontroller.dart';
import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:pinput/pinput.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../core/widget/asset_image_widget.dart';
import '../../../core/widget/custom_text_field.dart';
import '../../../core/widget/intl_phone_field/country_picker_text_field.dart';
import '../../../core/widget/text_view.dart';
import '../../../core/widget/material_button_widget.dart';
import '../../../core/utils/localization_service.dart';
import '../controllers/forget_email_controller.dart';
import '../controllers/otp_controller.dart';
import '../models/requestmodels/RequestModel.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({Key? key}) : super(key: key);

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
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center vertically
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Center horizontally
                      children: [
                        SizedBox(
                          height: Get.height * 0.3,
                        ),
                        TextView(
                          text: "strEnterOtpheading".tr,
                          textStyle: const TextStyle(
                              color: AppColors.whiteColor,
                              fontFamily: "minorksans",
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                          maxLines: 4,
                        ),
                        TextView(
                          text: "strOtpSubheading".tr,
                          textAlign: TextAlign.center,
                          textStyle: const TextStyle(
                            color: AppColors.smalltextColor,
                            fontFamily: "Kodchasan",
                            fontSize: 12,
                          ),
                          maxLines: 4,
                        ).marginOnly(bottom: 20, top: 10),
                        _pinPutWidget().marginOnly(bottom: 20),
                        Obx(() {
                          return Center(
                            child: GestureDetector(
                                onTap: () {
                                  if (controller.timerSeconds.value == 0) {
                                    Map<String, dynamic> requestModel =
                                        AuthRequestModel.ResendRequestModel(
                                            value: controller.email,
                                            language: controller.language,
                                            purpose: Get.previousRoute ==
                                                    AppRoutes.signupRoute
                                                ? "SIGNUP"
                                                : "FORGOT_PASSWORD");
                                    controller.ResendOtpApi(requestModel);
                                  }
                                },
                                child: Text(
                                  controller.timerSeconds.value > 0
                                      ? "Resend OTP in ${(controller.timerSeconds.value ~/ 60).toString().padLeft(2, '0')}:${(controller.timerSeconds.value % 60).toString().padLeft(2, '0')}"
                                      : "Resend OTP",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: controller.timerSeconds.value > 0
                                        ? AppColors.smalltextColor
                                        : AppColors.clickTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Kodchasan",
                                  ),
                                )),
                          );
                        }).marginOnly(bottom: 10),
                        Obx(() => MaterialButtonWidget(
                              isloading: controller.isLoading.value,
                              buttonBgColor: AppColors.buttonColor,
                              buttonRadius: 8,
                              buttonText: "strVerify".tr,
                              iconWidget: Icon(Icons.arrow_forward_sharp,
                                  color: AppColors.backgroundColor),
                              textColor: AppColors.backgroundColor,
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  Map<String, dynamic> requestModel =
                                      AuthRequestModel.ResendRequestModel(
                                          value: controller.email,
                                          language: controller.language,
                                          otp: controller.otpController.text);
                                  controller.VerifyOtpApi(requestModel);
                                  controller.otpController.clear();
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

  Widget _pinPutWidget() {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: textStyleTitleSmall()!
          .copyWith(fontSize: 22, color: AppColors.smalltextColor),
      decoration: BoxDecoration(
          color: AppColors.textfieldcolor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.textfieldBorderColor)),
    );

    return Form(
        key: controller.formKey,
        child: Pinput(
          length: 6,
          controller: controller.otpController,
          focusNode: controller.pinFocusNode,
          // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
          // listenForMultipleSmsOnAndroid: true,
          defaultPinTheme: defaultPinTheme,

          forceErrorState: controller.forceErrorState.value,
          separatorBuilder: (index) => SizedBox(width: 10),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            final data = FieldChecker.otpValidator(value: value);
            if (data != null) {
              controller.forceErrorState.value = true;
            }
            return data;
          },
          hapticFeedbackType: HapticFeedbackType.lightImpact,
          onCompleted: (pin) {
            debugPrint('onCompleted: $pin');
          },
          onChanged: (value) {
            controller.forceErrorState.value = false;
            debugPrint('onChanged: $value');
          },
          cursor:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: 1, height: 30, color: AppColors.textfieldBorderColor),
          ]),

          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration!.copyWith(
              border: Border.all(color: AppColors.textfieldBorderColor),
            ),
          ),

          // :  defaultPinTheme.copyWith(
          //   decoration: defaultPinTheme.decoration!.copyWith(
          //     border: Border.all(color: AppColors.textfieldBorderColor),
          //   ),
          // ),
          disabledPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: AppColors.textfieldBorderColor),
          )),
          submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: AppColors.textfieldBorderColor),
          )),
          errorPinTheme: defaultPinTheme.copyBorderWith(
            border: Border.all(color: AppColors.redColor.withOpacity(0.8)),
          ),
        ));
  }

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
                  color: AppColors.smalltextColor,
                  fontSize: 14,
                  fontFamily: "Kodchasan",
                )),
          ],
        ),
      );
}

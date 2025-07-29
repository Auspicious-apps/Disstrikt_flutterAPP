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
import '../Controller/changePasswordController.dart';
import '../Controller/supportController.dart';

class Changepassword extends StatelessWidget {
  const Changepassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Changepasswordcontroller>(
      init: Changepasswordcontroller(),
      builder: (controller) {
        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.buttonColor,
          child: Scaffold(
            backgroundColor: AppColors.buttonColor.withOpacity(0.3),
            body: Form(
              key: controller.signupFormKey,
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
                                borderRadius: BorderRadius.circular(40)),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios_new_sharp,
                                size: 20,
                              ),
                            ),
                          ).marginOnly(left: margin_10),
                          TextView(
                            text: "strChangePassword".tr,
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
                  _Password(controller)
                      .marginSymmetric(horizontal: 20, vertical: 20),
                  _newPassword(controller).marginSymmetric(horizontal: 20),
                  _confirmPassword(controller)
                      .marginSymmetric(horizontal: 20, vertical: 20),
                  Spacer(),
                  Obx(() => MaterialButtonWidget(
                        isloading: controller.isloading.value,
                        buttonBgColor: AppColors.buttonColor,
                        buttonRadius: 8,
                        buttonText: "strChangePassword".tr,
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
                                AuthRequestModel.ChangePasswordRequestModel(
                                    oldPassword:
                                        controller.PasswordTextController.text,
                                    newPassword: controller
                                        .ConfiormPasswordTextController.text);
                            controller.handleSubmit(requestModel);
                          }
                        },
                      ).marginSymmetric(vertical: 10, horizontal: 20)),
                ],
              ).marginOnly(bottom: Get.height * 0.02),
            ),
          ),
        );
      },
    );
  }

  Widget _Password(controller) => Obx(() => TextFieldWidget(
        hint: "strOldPassword".tr,
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textColors: Colors.black,
        textController: controller.PasswordTextController,
        fillColor: AppColors.whiteColor,
        color: Colors.black,
        validate: (value) =>
            FieldChecker.fieldChecker(value?.trim() ?? "", "strOldPassword".tr),
        borderColor: AppColors.buttonColor,
        courserColor: AppColors.buttonColor,
        obscureText: controller.ShowPassword.value,
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

  Widget _newPassword(controller) => Obx(() => TextFieldWidget(
        hint: "strNewPassword".tr,
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textColors: Colors.black,
        textController: controller.newPasswordTextController,
        fillColor: AppColors.whiteColor,
        validate: (value) =>
            PasswordFormValidator.validatePassword(value?.trim() ?? ""),
        borderColor: AppColors.buttonColor,
        courserColor: AppColors.buttonColor,
        obscureText: controller.ShowNeewPassword.value,
        suffixIcon: !controller.ShowNeewPassword.value
            ? GestureDetector(
                onTap: () => {
                      controller.ShowNeewPassword.value =
                          !controller.ShowNeewPassword.value
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
                      controller.ShowNeewPassword.value =
                          !controller.ShowNeewPassword.value
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
        focusNode: controller.newPasswordFocusNode,
        inputType: TextInputType.text,
      ));

  Widget _confirmPassword(controller) => Obx(() => TextFieldWidget(
        hint: "strConfirmPassword".tr,
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textColors: Colors.black,
        textController: controller.ConfiormPasswordTextController,
        fillColor: AppColors.whiteColor,
        validate: (value) => PasswordFormValidator.validateConfirmPasswordMatch(
            value: value?.trim() ?? "",
            password: controller.newPasswordTextController.text),
        borderColor: AppColors.buttonColor,
        courserColor: AppColors.buttonColor,
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
        focusNode: controller.ConfiormPasswordFocusNode,
        inputType: TextInputType.text,
      ));
}

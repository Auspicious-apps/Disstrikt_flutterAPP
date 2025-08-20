import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:disstrikt/app/core/widget/annotated_region_widget.dart';
import 'package:disstrikt/app/modules/auth/controllers/signupcontroller.dart';
import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widget/asset_image_widget.dart';
import '../../../core/widget/custom_text_field.dart';
import '../../../core/widget/intl_phone_field/country_picker_text_field.dart';
import '../../../core/widget/text_view.dart';
import '../../../core/widget/material_button_widget.dart';
import '../../../core/utils/localization_service.dart';
import '../../../core/widget/validator.dart';
import '../../auth/models/requestmodels/RequestModel.dart';
import '../controller/user_info_controller.dart';

class UserInfo extends GetView<UserInfoController> {
  const UserInfo({Key? key}) : super(key: key);

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
                          MainAxisAlignment.start, // Center vertically
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Center horizontally
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.localStorage.clearLoginData();

                            Get.offAllNamed(AppRoutes.chooseLanguage);
                          },
                          child: Container(
                            height: height_40,
                            width: width_40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                                size: 18,
                              ),
                            ),
                          ).marginOnly(right: 2),
                        ).marginSymmetric(
                          horizontal: margin_13,
                          vertical: margin_13,
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextView(
                            text: "strYourInformation".tr,
                            textStyle: const TextStyle(
                                color: AppColors.whiteColor,
                                fontFamily: "minorksans",
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                            maxLines: 4,
                          ),
                        ),
                        TextView(
                          text: "strFillinginmost".tr,
                          textAlign: TextAlign.center,
                          textStyle: const TextStyle(
                            color: AppColors.smalltextColor,
                            fontFamily: "Kodchasan",
                            fontSize: 12,
                          ),
                          maxLines: 4,
                        ).marginOnly(bottom: 20, top: 10),
                        TextView(
                          text: "strBasicDetail".tr,
                          textStyle: const TextStyle(
                              color: AppColors.whiteColor,
                              fontFamily: "minorksans",
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                          maxLines: 4,
                        ).marginOnly(bottom: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    text: 'strDateofBirth'.tr,
                                    textStyle: const TextStyle(
                                        color: AppColors.smalltextColor,
                                        fontFamily: "Kodchasan",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800),
                                    maxLines: 1,
                                  ).marginOnly(bottom: 10),
                                  Obx(
                                    () => InkWell(
                                      onTap: () async {
                                        final today = DateTime.now();
                                        final eighteenYearsAgo = DateTime(
                                            today.year, today.month, today.day);
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: eighteenYearsAgo,
                                          firstDate: DateTime(1900),
                                          lastDate: eighteenYearsAgo,
                                        );
                                        if (date != null) {
                                          controller.birthDate.value = date
                                              .toLocal()
                                              .toString()
                                              .split(' ')[0];
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: AppColors.textfieldcolor,
                                          border: Border.all(
                                              width: 2,
                                              color: AppColors
                                                  .textfieldBorderColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: TextView(
                                                text: controller
                                                        .birthDate.value.isEmpty
                                                    ? 'strDateofBirth'.tr
                                                    : controller
                                                        .birthDate.value,
                                                textStyle: TextStyle(
                                                    color: controller.birthDate
                                                            .value.isEmpty
                                                        ? AppColors
                                                            .smalltextColor
                                                        : AppColors.whiteColor,
                                                    fontFamily: "Kodchasan",
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w800),
                                                maxLines: 1,
                                              ),
                                            ),
                                            Icon(
                                              Icons.calendar_month,
                                              color: AppColors.smalltextColor,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    text: 'strGender'.tr,
                                    textStyle: const TextStyle(
                                        color: AppColors.smalltextColor,
                                        fontFamily: "Kodchasan",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800),
                                    maxLines: 1,
                                  ).marginOnly(bottom: 10),
                                  Obx(() => Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.textfieldcolor,
                                            border: Border.all(
                                                width: 2,
                                                color: AppColors
                                                    .textfieldBorderColor),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2<String>(
                                            isExpanded: true,
                                            hint: Text(
                                              "strSelect".tr,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Mulish",
                                                color: AppColors.smalltextColor,
                                              ),
                                            ),
                                            items: controller.genders
                                                .map((String country) =>
                                                    DropdownMenuItem<String>(
                                                      value: country,
                                                      child: Row(
                                                        children: [
                                                          const SizedBox(
                                                              width: 10),
                                                          Expanded(
                                                            child: Text(
                                                              country,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ))
                                                .toList(),
                                            value: controller
                                                    .selectGender.value.isEmpty
                                                ? null
                                                : controller.selectGender.value,
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              maxHeight: 200,
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColors.backgroundColor,
                                                border: Border.all(
                                                    color: Color.fromRGBO(
                                                        24, 34, 38, 1)),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            onChanged: (String? value) {
                                              if (value != null) {
                                                controller.selectGender.value =
                                                    value;
                                              }
                                            },
                                            iconStyleData: IconStyleData(
                                              icon: Obx(() => Icon(
                                                    controller
                                                            .isSecondDropdownOpen
                                                            .value
                                                        ? Icons.arrow_drop_up
                                                        : Icons.arrow_drop_down,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                            onMenuStateChange: (isOpen) {
                                              controller.isSecondDropdownOpen
                                                      .value =
                                                  isOpen; // Update dropdown state
                                            },
                                            buttonStyleData: ButtonStyleData(
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppColors.textfieldcolor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              padding:
                                                  EdgeInsets.only(right: 16),
                                              height: 49,
                                            ),
                                            menuItemStyleData:
                                                const MenuItemStyleData(
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextView(
                          text: "strYourMeasurements".tr,
                          textStyle: const TextStyle(
                              color: AppColors.whiteColor,
                              fontFamily: "minorksans",
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                          maxLines: 4,
                        ).marginOnly(bottom: 10),
                        Row(
                          children: [
                            Expanded(child: _hieght()),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(child: _weight())
                          ],
                        ),
                        TextView(
                          text: 'strShoes'.tr,
                          textStyle: const TextStyle(
                              color: AppColors.smalltextColor,
                              fontFamily: "Kodchasan",
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                          maxLines: 1,
                        ).marginOnly(bottom: 10, top: 15),
                        Obx(() => Container(
                              decoration: BoxDecoration(
                                  color: AppColors.textfieldcolor,
                                  border: Border.all(
                                      width: 2,
                                      color: AppColors.textfieldBorderColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    "strSelect".tr,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Mulish",
                                      color: AppColors.smalltextColor,
                                    ),
                                  ),
                                  items: controller.ShoesSize.map(
                                      (String country) =>
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )).toList(),
                                  value:
                                      controller.selectShoesSize.value.isEmpty
                                          ? null
                                          : controller.selectShoesSize.value,
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundColor,
                                      border: Border.all(
                                          color: Color.fromRGBO(24, 34, 38, 1)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      controller.selectShoesSize.value = value;
                                    }
                                  },
                                  iconStyleData: IconStyleData(
                                    icon: Obx(() => Icon(
                                          controller.isDropdownOpen.value
                                              ? Icons.arrow_drop_up
                                              : Icons.arrow_drop_down,
                                          color: Colors.white,
                                        )),
                                  ),
                                  onMenuStateChange: (isOpen) {
                                    controller.isDropdownOpen.value =
                                        isOpen; // Update dropdown state
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    decoration: BoxDecoration(
                                        color: AppColors.textfieldcolor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.only(right: 16),
                                    height: 49,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                            )).marginOnly(bottom: 20),
                        Row(
                          children: [
                            Expanded(child: _hips()),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(child: _waist()),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(child: _bust())
                          ],
                        ),
                        Obx(() => MaterialButtonWidget(
                            isloading: controller.isloading.value,
                            buttonBgColor: AppColors.buttonColor,
                            buttonRadius: 8,
                            buttonText: "strContinue".tr,
                            iconWidget: Icon(Icons.arrow_forward_sharp,
                                color: AppColors.backgroundColor),
                            textColor: AppColors.backgroundColor,
                            onPressed: () {
                              Get.closeAllSnackbars();
                              if (controller.isloading.value == false) {
                                controller.isloading.value = true;
                                controller.isloading.refresh();
                                if (controller.birthDate.value.isEmpty ==
                                        true ||
                                    controller.birthDate.value == null) {
                                  controller.isloading.value = false;
                                  controller.isloading.refresh();
                                  Get.snackbar(
                                    'Error',
                                    'pleaseEnterDateOfBirth'.tr,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.5),
                                  );
                                  return;
                                }
                                if (controller.selectGender.value.isEmpty ==
                                        true ||
                                    controller.selectGender.value == null) {
                                  controller.isloading.value = false;
                                  controller.isloading.refresh();
                                  Get.snackbar(
                                    'Error',
                                    'pleaseSelectGender'.tr,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.5),
                                  );
                                  return;
                                }

                                if (controller.hieghtController.text.isEmpty ==
                                        true ||
                                    controller.hieghtController.text == null) {
                                  controller.isloading.value = false;
                                  controller.isloading.refresh();
                                  Get.snackbar(
                                    'Error',
                                    'pleaseEnterHeight'.tr,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.5),
                                  );
                                  return;
                                }

                                if (controller.weightController.text.isEmpty ==
                                        true ||
                                    controller.weightController.text == null) {
                                  controller.isloading.value = false;
                                  controller.isloading.refresh();
                                  Get.snackbar(
                                    'Error',
                                    'pleaseEnterWeight'.tr,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.5),
                                  );
                                  return;
                                }
                                if (controller.selectShoesSize.value.isEmpty ==
                                        true ||
                                    controller.selectShoesSize.value == null) {
                                  controller.isloading.value = false;
                                  controller.isloading.refresh();
                                  Get.snackbar(
                                    'Error',
                                    'pleaseEnterShoeSize'.tr,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.5),
                                  );
                                  return;
                                }
                                if (controller.hipsController.text.isEmpty ==
                                        true ||
                                    controller.hipsController.text == null) {
                                  controller.isloading.value = false;
                                  controller.isloading.refresh();
                                  Get.snackbar(
                                    'Error',
                                    'pleaseEnterHips'.tr,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.5),
                                  );
                                  return;
                                }
                                if (controller.waistController.text.isEmpty ==
                                        true ||
                                    controller.waistController.text == null) {
                                  controller.isloading.value = false;
                                  controller.isloading.refresh();
                                  Get.snackbar(
                                    'Error',
                                    'pleaseEnterWaist'.tr,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.5),
                                  );
                                  return;
                                }
                                if (controller.bustController.text.isEmpty ==
                                        true ||
                                    controller.bustController.text == null) {
                                  controller.isloading.value = false;
                                  controller.isloading.refresh();
                                  Get.snackbar(
                                    'Error',
                                    'pleaseEnterBust'.tr,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.5),
                                  );
                                  return;
                                }

                                Map<String, dynamic> requestModel =
                                    AuthRequestModel.moreInfoRequestModel(
                                  dob: controller.birthDate.value,
                                  gender: controller.selectGender.value ==
                                          "strMale".tr
                                      ? "MALE"
                                      : "FEMALE",
                                  heightCm: double.parse(
                                      controller.hieghtController.text),
                                  weightKg: double.parse(
                                      controller.weightController.text),
                                  hipsCm: double.parse(
                                      controller.hipsController.text),
                                  waistCm: double.parse(
                                      controller.waistController.text),
                                  bustCm: double.parse(
                                      controller.bustController.text),
                                  shoeSizeUK: double.parse(
                                      controller.selectShoesSize.value),
                                );
                                controller.handleSubmit(requestModel);
                              }
                            }).marginSymmetric(vertical: 20)),
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

  Widget _hieght() => TextFieldWidget(
        label: "strHieght".tr,
        hint: "eg: 170cm ",
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textController: controller.hieghtController,
        fillColor: AppColors.textfieldcolor,
        borderColor: AppColors.textfieldBorderColor,
        courserColor: AppColors.textfieldBorderColor,
        maxLength: 3,
        focusNode: controller.hieghtFocusNode,
        inputType: TextInputType.number,
      );

  Widget _weight() => TextFieldWidget(
        label: "strweight".tr,
        hint: "eg: 70kg",
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textController: controller.weightController,
        fillColor: AppColors.textfieldcolor,
        borderColor: AppColors.textfieldBorderColor,
        courserColor: AppColors.textfieldBorderColor,
        maxLength: 3,
        focusNode: controller.weightFocusNode,
        inputType: TextInputType.number,
      );

  Widget _hips() => TextFieldWidget(
        label: "strhips".tr,
        hint: "eg: 30cm",
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textController: controller.hipsController,
        fillColor: AppColors.textfieldcolor,
        borderColor: AppColors.textfieldBorderColor,
        courserColor: AppColors.textfieldBorderColor,
        maxLength: 3,
        focusNode: controller.hipsFocusNode,
        inputType: TextInputType.number,
      );

  Widget _bust() => TextFieldWidget(
        label: "strbust".tr,
        hint: "eg: 30cm",
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textController: controller.bustController,
        fillColor: AppColors.textfieldcolor,
        borderColor: AppColors.textfieldBorderColor,
        courserColor: AppColors.textfieldBorderColor,
        maxLength: 3,
        focusNode: controller.bustFocusNode,
        inputType: TextInputType.number,
      );

  Widget _waist() => TextFieldWidget(
        label: "strWaist".tr,
        hint: "eg: 30cm",
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textController: controller.waistController,
        fillColor: AppColors.textfieldcolor,
        borderColor: AppColors.textfieldBorderColor,
        courserColor: AppColors.textfieldBorderColor,
        maxLength: 3,
        focusNode: controller.waistFocusNode,
        inputType: TextInputType.number,
      );
}

import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/utils/localization_service.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_text_styles.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../core/widget/asset_image_widget.dart';
import '../../../core/widget/custom_text_field.dart';
import '../../../core/widget/intl_phone_field/country_picker_text_field.dart';
import '../../../core/widget/network_image_widget.dart';
import '../../../core/widget/text_view.dart';
import '../../../core/widget/material_button_widget.dart';
import '../../../core/widget/validator.dart';
import '../../../data/repository/endpoint.dart';
import '../../auth/models/requestmodels/RequestModel.dart';
import '../Controller/EditProfileController.dart';
import '../Controller/StaticController.dart';

class Editprofile extends StatelessWidget {
  const Editprofile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Editprofilecontroller>(
      init: Editprofilecontroller(),
      builder: (controller) {
        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.buttonColor,
          child: Scaffold(
              backgroundColor: AppColors.buttonColor.withOpacity(0.3),
              body: SingleChildScrollView(
                child: Obx(() => Skeletonizer(
                      enabled: controller.isloading.value,
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
                                    text: "strProfile".tr,
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
                          Column(
                            children: [
                              Obx(() => Align(
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      onTap: () => _showImageSourceDialog(
                                          context, controller),
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(90)),
                                            ),
                                            height: 130,
                                            width: 130,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(90)),
                                              child: Obx(
                                                () {
                                                  if (controller
                                                          .pickedImage.value !=
                                                      null) {
                                                    return Image.file(
                                                      controller
                                                          .pickedImage.value!,
                                                      fit: BoxFit.cover,
                                                    );
                                                  } else if (controller
                                                          .profilePicUrl
                                                          .value
                                                          .isNotEmpty ==
                                                      true) {
                                                    return NetworkImageWidget(
                                                      imageUrl: controller
                                                              .userResponseModel
                                                              ?.data
                                                              ?.image ??
                                                          "",
                                                      imageHeight: 100,
                                                      imageWidth: 100,
                                                      radiusAll: 100,
                                                    );
                                                  }
                                                  // Display locally picked image if available
                                                  // Fallback to person icon with light grey background
                                                  else {
                                                    return Container(
                                                      color:
                                                          AppColors.buttonColor,
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 80,
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 15,
                                            right: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: AppColors.whiteColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                controller.profilePicUrl.value
                                                            .isNotEmpty ||
                                                        controller.pickedImage
                                                                .value !=
                                                            null
                                                    ? Icons.edit
                                                    : Icons.camera_alt,
                                                size: 20,
                                                color: AppColors.blackColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ).marginSymmetric(vertical: 20)),
                              _fullName(controller),
                              _EmailAddress(controller),
                              CountryPickerTextField(
                                filledColors: Colors.white,
                                controller:
                                    controller.mobileNumberTextController!,
                                focusNode: controller.mobileNumberFocusNode!,
                                hintText: 'strPhoneNumber'.tr,
                                showBorder: true,
                                labelText: 'strPhoneNumber'.tr,
                                readOnly: true,
                                showCountryFlag: true,
                                borderColor: AppColors.buttonColor,
                                textInputAction: TextInputAction.done,
                                inputTextStyle: textStyleTitleMedium().copyWith(
                                    color: AppColors.blackColor,
                                    fontFamily: "Kodchasan",
                                    fontSize: 13),
                                selectedCountry: controller.selectedCountry,
                                onCountryChanged: (value) {
                                  controller.selectedCountry.value = value;
                                },
                                borderRadius: 10,
                              ).marginSymmetric(horizontal: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextView(
                                          text: 'strDateofBirth'.tr,
                                          textStyle: const TextStyle(
                                              color: AppColors.greyshadetext,
                                              fontFamily: "Kodchasan",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          maxLines: 1,
                                        ).marginOnly(bottom: 10),
                                        Obx(
                                          () => InkWell(
                                            onTap: () async {
                                              final today = DateTime.now();
                                              final eighteenYearsAgo = DateTime(
                                                  today.year,
                                                  today.month,
                                                  today.day);
                                              final date = await showDatePicker(
                                                context: context,
                                                initialDate: eighteenYearsAgo,
                                                firstDate: DateTime(1900),
                                                lastDate: eighteenYearsAgo,
                                              );
                                              if (date != null) {
                                                controller.birthDate.value =
                                                    date
                                                        .toLocal()
                                                        .toString()
                                                        .split(' ')[0];
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: AppColors.whiteColor,
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        AppColors.buttonColor),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: TextView(
                                                      text: controller.birthDate
                                                              .value.isEmpty
                                                          ? 'strDateofBirth'.tr
                                                          : controller
                                                              .birthDate.value,
                                                      textStyle: TextStyle(
                                                          color: controller
                                                                  .birthDate
                                                                  .value
                                                                  .isEmpty
                                                              ? AppColors
                                                                  .smalltextColor
                                                              : AppColors
                                                                  .blackColor,
                                                          fontFamily:
                                                              "Kodchasan",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: AppColors
                                                        .smalltextColor,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextView(
                                          text: 'strGender'.tr,
                                          textStyle: const TextStyle(
                                              color: AppColors.greyshadetext,
                                              fontFamily: "Kodchasan",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          maxLines: 1,
                                        ).marginOnly(bottom: 10),
                                        Obx(() => Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppColors
                                                          .buttonColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton2<String>(
                                                  isExpanded: true,
                                                  hint: Text(
                                                    "strSelect".tr,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: "Mulish",
                                                      color: AppColors
                                                          .smalltextColor,
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  items: controller.genders
                                                      .map((String country) =>
                                                          DropdownMenuItem<
                                                              String>(
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
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black,
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
                                                  value: controller.selectGender
                                                          .value.isEmpty
                                                      ? null
                                                      : controller
                                                          .selectGender.value,
                                                  dropdownStyleData:
                                                      DropdownStyleData(
                                                    maxHeight: 200,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.whiteColor,
                                                      border: Border.all(
                                                          color: Color.fromRGBO(
                                                              24, 34, 38, 1)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  onChanged: (String? value) {
                                                    if (value != null) {
                                                      controller.selectGender
                                                          .value = value;
                                                    }
                                                  },
                                                  iconStyleData: IconStyleData(
                                                    icon: Obx(() => Icon(
                                                          controller
                                                                  .isSecondDropdownOpen
                                                                  .value
                                                              ? Icons
                                                                  .arrow_drop_up
                                                              : Icons
                                                                  .arrow_drop_down,
                                                          color: AppColors
                                                              .greyshadetext,
                                                        )),
                                                  ),
                                                  onMenuStateChange: (isOpen) {
                                                    controller
                                                            .isSecondDropdownOpen
                                                            .value =
                                                        isOpen; // Update dropdown state
                                                  },
                                                  buttonStyleData:
                                                      ButtonStyleData(
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .whiteColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    padding: EdgeInsets.only(
                                                        right: 16),
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
                              ).marginSymmetric(horizontal: 20, vertical: 10),
                              Row(
                                children: [
                                  Expanded(child: _hieght(controller)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: _weight(controller))
                                ],
                              )
                                  .marginSymmetric(horizontal: 20)
                                  .marginOnly(bottom: 10),
                              Align(
                                alignment: Alignment.topLeft,
                                child: TextView(
                                  text: 'strShoes'.tr,
                                  textStyle: const TextStyle(
                                      color: AppColors.smalltextColor,
                                      fontFamily: "Kodchasan",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),
                                  maxLines: 1,
                                ).marginOnly(bottom: 10),
                              ).marginSymmetric(horizontal: 20),
                              Obx(() => Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.textfieldcolor,
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
                                            items: controller.ShoesSize.map(
                                                (String country) =>
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
                                                                color: AppColors
                                                                    .greyshadetext,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )).toList(),
                                            value: controller.selectShoesSize
                                                    .value.isEmpty
                                                ? null
                                                : controller
                                                    .selectShoesSize.value,
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              maxHeight: 200,
                                              decoration: BoxDecoration(
                                                color: AppColors.whiteColor,
                                                border: Border.all(
                                                    color: Color.fromRGBO(
                                                        24, 34, 38, 1)),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            onChanged: (String? value) {
                                              if (value != null) {
                                                controller.selectShoesSize
                                                    .value = value;
                                              }
                                            },
                                            iconStyleData: IconStyleData(
                                              icon: Obx(() => Icon(
                                                    controller.isDropdownOpen
                                                            .value
                                                        ? Icons.arrow_drop_up
                                                        : Icons.arrow_drop_down,
                                                    color:
                                                        AppColors.greyshadetext,
                                                  )),
                                            ),
                                            onMenuStateChange: (isOpen) {
                                              controller.isDropdownOpen.value =
                                                  isOpen; // Update dropdown state
                                            },
                                            buttonStyleData: ButtonStyleData(
                                              decoration: BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  border: Border.all(
                                                      color: AppColors
                                                          .buttonColor),
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
                                      ))
                                  .marginOnly(bottom: 20)
                                  .marginSymmetric(horizontal: 20),
                              Row(
                                children: [
                                  Expanded(child: _hips(controller)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: _waist(controller)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: _bust(controller))
                                ],
                              ).marginSymmetric(horizontal: 20),
                              Obx(() => MaterialButtonWidget(
                                      isloading: controller.isloading.value,
                                      buttonBgColor: AppColors.buttonColor,
                                      buttonRadius: 8,
                                      buttonText: "strupdate".tr,
                                      iconWidget: Icon(
                                          Icons.arrow_forward_sharp,
                                          color: AppColors.backgroundColor),
                                      textColor: AppColors.backgroundColor,
                                      onPressed: () {
                                        Get.closeAllSnackbars();
                                        if (controller.isloading.value ==
                                            false) {
                                          controller.isloading.value = true;
                                          controller.isloading.refresh();
                                          if (controller.fullNameController.text
                                                      .isEmpty ==
                                                  true ||
                                              controller.fullNameController
                                                      .text ==
                                                  null) {
                                            controller.isloading.value = false;
                                            controller.isloading.refresh();
                                            Get.snackbar(
                                              'Error',
                                              'strPleaseEnterName'.tr,
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.5),
                                            );
                                            return;
                                          }
                                          if (controller.birthDate.value
                                                      .isEmpty ==
                                                  true ||
                                              controller.birthDate.value ==
                                                  null) {
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
                                          if (controller.selectGender.value
                                                      .isEmpty ==
                                                  true ||
                                              controller.selectGender.value ==
                                                  null) {
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

                                          if (controller.hieghtController.text
                                                      .isEmpty ==
                                                  true ||
                                              controller
                                                      .hieghtController.text ==
                                                  null) {
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

                                          if (controller.weightController.text
                                                      .isEmpty ==
                                                  true ||
                                              controller
                                                      .weightController.text ==
                                                  null) {
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
                                          if (controller.selectShoesSize.value
                                                      .isEmpty ==
                                                  true ||
                                              controller
                                                      .selectShoesSize.value ==
                                                  null) {
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
                                          if (controller.hipsController.text
                                                      .isEmpty ==
                                                  true ||
                                              controller.hipsController.text ==
                                                  null) {
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
                                          if (controller.waistController.text
                                                      .isEmpty ==
                                                  true ||
                                              controller.waistController.text ==
                                                  null) {
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
                                          if (controller.bustController.text
                                                      .isEmpty ==
                                                  true ||
                                              controller.bustController.text ==
                                                  null) {
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
                                              AuthRequestModel
                                                  .moreInfoRequestModel(
                                            dob: controller.birthDate.value,
                                            gender:
                                                controller.selectGender.value,
                                            // heightCm: double.parse(
                                            //     controller.hieghtController.text),
                                            // weightKg: double.parse(
                                            //     controller.weightController.text),
                                            hipsCm: double.parse(
                                                controller.hipsController.text),
                                            waistCm: double.parse(controller
                                                .waistController.text),
                                            bustCm: double.parse(
                                                controller.bustController.text),
                                            shoeSizeUK: double.parse(controller
                                                .selectShoesSize.value),
                                          );
                                          if (controller.pickedImage.value !=
                                              null) {
                                            controller.callUploadMedia(
                                                controller.pickedImage.value!);
                                          } else {
                                            Map<String, dynamic> requestModel = AuthRequestModel.EditProfileRequestModel(
                                                image: controller
                                                    .userResponseModel
                                                    ?.data
                                                    ?.image,
                                                fullName: controller
                                                    .fullNameController.text,
                                                dob: controller.birthDate.value,
                                                gender: controller
                                                    .selectGender.value
                                                    ?.toUpperCase(),
                                                hipsCm: controller.hipsController.text.isNotEmpty
                                                    ? double.parse(controller
                                                        .hipsController.text)
                                                    : null,
                                                waistCm: controller
                                                        .waistController
                                                        .text
                                                        .isNotEmpty
                                                    ? double.parse(controller.waistController.text)
                                                    : null,
                                                bustCm: controller.bustController.text.isNotEmpty ? double.parse(controller.bustController.text) : null,
                                                weightKg: controller.weightController.text.isNotEmpty ? double.parse(controller.weightController.text) : null,
                                                heightCm: controller.hieghtController.text.isNotEmpty ? double.parse(controller.hieghtController.text) : null,
                                                shoeSizeUK: controller.selectShoesSize.value.isNotEmpty ? double.parse(controller.selectShoesSize.value) : null);
                                            controller.updateProfileDetail(
                                                requestModel);
                                          }
                                        }
                                      })
                                  .marginSymmetric(
                                      vertical: 20, horizontal: 20)),
                            ],
                          )
                        ],
                      ).marginOnly(bottom: Get.height * 0.02),
                    )),
              )),
        );
      },
    );
  }

  Widget _hieght(controller) => TextFieldWidget(
        label: "strHieght".tr,
        hint: "eg: 170cm ",
        lableColor: AppColors.greyshadetext,
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textController: controller.hieghtController,
        fillColor: AppColors.whiteColor,
        borderColor: AppColors.buttonColor,
        textColors: AppColors.blackColor,
        courserColor: AppColors.textfieldBorderColor,
        maxLength: 3,
        focusNode: controller.hieghtFocusNode,
        inputType: TextInputType.number,
      );

  Widget _weight(controller) => TextFieldWidget(
        label: "strweight".tr,
        hint: "eg: 70kg",
        lableColor: AppColors.greyshadetext,
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textController: controller.weightController,
        fillColor: AppColors.whiteColor,
        borderColor: AppColors.buttonColor,
        textColors: AppColors.blackColor,
        courserColor: AppColors.textfieldBorderColor,
        maxLength: 3,
        focusNode: controller.weightFocusNode,
        inputType: TextInputType.number,
      );

  Widget _hips(controller) => TextFieldWidget(
        label: "strhips".tr,
        hint: "eg: 30cm",
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textController: controller.hipsController,
        fillColor: AppColors.whiteColor,
        borderColor: AppColors.buttonColor,
        courserColor: AppColors.textfieldBorderColor,
        maxLength: 3,
        textColors: AppColors.blackColor,
        focusNode: controller.hipsFocusNode,
        inputType: TextInputType.number,
      );

  Widget _bust(controller) => TextFieldWidget(
        label: "strbust".tr,
        hint: "eg: 30cm",
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textController: controller.bustController,
        fillColor: AppColors.whiteColor,
        borderColor: AppColors.buttonColor,
        courserColor: AppColors.textfieldBorderColor,
        maxLength: 3,
        textColors: AppColors.blackColor,
        focusNode: controller.bustFocusNode,
        inputType: TextInputType.number,
      );

  Widget _waist(controller) => TextFieldWidget(
        label: "strWaist".tr,
        hint: "eg: 30cm",
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textColors: AppColors.blackColor,
        textController: controller.waistController,
        fillColor: AppColors.whiteColor,
        borderColor: AppColors.buttonColor,
        courserColor: AppColors.textfieldBorderColor,
        maxLength: 3,
        focusNode: controller.waistFocusNode,
        inputType: TextInputType.number,
      );
  Widget _fullName(controller) => TextFieldWidget(
        hint: "strFullName".tr,
        textColors: Colors.black,
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        label: "strFullName".tr,
        lableColor: AppColors.greyshadetext,
        textController: controller.fullNameController,
        fillColor: AppColors.whiteColor,
        borderColor: AppColors.buttonColor,
        courserColor: AppColors.textfieldBorderColor,
        maxLength: 30,
        focusNode: controller.fullNameFocusNode,
        inputType: TextInputType.text,
        validate: (value) => NameValidator.validateName(
          title: "strFullName".tr,
          value: value?.trim() ?? '',
        ),
      ).marginSymmetric(horizontal: 20);
  Widget _EmailAddress(controller) => TextFieldWidget(
        hint: "strEmailAddress".tr,
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textColors: Colors.black,
        textController: controller.emailAddressController,
        fillColor: Colors.white,
        readOnly: true,
        label: "strEmailAddress".tr,
        lableColor: AppColors.greyshadetext,
        borderColor: AppColors.buttonColor,
        courserColor: AppColors.textfieldBorderColor,
        inputType: TextInputType.emailAddress,
        validate: (value) => EmailValidator.validateEmail(value?.trim() ?? ""),
        maxLength: 30,
        focusNode: controller.emailAddressFocusNode,
      ).marginSymmetric(horizontal: 20, vertical: 10);

  void _showImageSourceDialog(BuildContext context, controller) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  controller.pickImage(ImageSource.gallery);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  controller.pickImage(ImageSource.camera);
                  Get.back();
                },
              ),
            ],
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
}

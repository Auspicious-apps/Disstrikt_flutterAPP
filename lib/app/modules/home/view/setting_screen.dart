import 'package:disstrikt/app/core/widget/network_image_widget.dart';
import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../core/widget/asset_image_widget.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/text_view.dart';
import '../comonWidget.dart';
import '../controller/Setting_Screen_Controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingScreenController>(
      init: SettingScreenController(),
      builder: (controller) {
        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.buttonColor,
          child: Scaffold(
            backgroundColor: AppColors.buttonColor.withOpacity(0.3),
            body: SafeArea(
              child: Obx(() => Column(
                    children: [
                      _buildHeader(),
                      Expanded(
                        child: Skeletonizer(
                          enabled: controller.isLoading.value,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTopProfileSection(controller),
                                _buildStatRow(controller),
                                _sectionTitle("strApplicationSettings".tr),
                                _settingsGroup([
                                  controller.userResponseModel.value.data
                                              ?.authType ==
                                          "EMAIL"
                                      ? buildCommonRow(
                                          icon: iconsPasswordChanges,
                                          name: "strChangePassword".tr,
                                          isDivider: true,
                                          onTap: () {
                                            Get.toNamed(
                                                AppRoutes.ChangePassword);
                                          })
                                      : SizedBox(),
                                  buildCommonRow(
                                      icon: iconsLanguageChange,
                                      name: "strLanguage".tr,
                                      isDivider: true,
                                      onTap: () {
                                        Get.toNamed(AppRoutes.ChangeLanguage);
                                      }),
                                  buildCommonRow(
                                      icon: iconsCountryChange,
                                      name: "strTabCountry".tr,
                                      isDivider: true,
                                      onTap: () {
                                        Get.toNamed(AppRoutes.ChangeCountry);
                                      }),
                                  buildCommonRow(
                                      icon: iconsNotificationSetting,
                                      name: "strNotificationSettings".tr,
                                      isDivider: true,
                                      onTap: () {
                                        Get.toNamed(
                                            AppRoutes.NotificationSettting);
                                      }),
                                  buildCommonRow(
                                      icon: iconsSubscription,
                                      name: "strSubscription".tr,
                                      isDivider: false,
                                      onTap: () {
                                        Get.toNamed(
                                            AppRoutes.ChangeSubscription);
                                      }),
                                ]),
                                _sectionTitle("strLegalSupport".tr),
                                _settingsGroup([
                                  buildCommonRow(
                                      icon: iconsSupport,
                                      name: "strSupport".tr,
                                      isDivider: true,
                                      onTap: () {
                                        Get.toNamed(AppRoutes.SupportPage,
                                            arguments: {
                                              "title": "strSupport".tr,
                                            });
                                      }),
                                  buildCommonRow(
                                      icon: iconsTermsCondition,
                                      name: "strTermsofService".tr,
                                      isDivider: true,
                                      onTap: () {
                                        Get.toNamed(AppRoutes.StaticPage,
                                            arguments: {
                                              "title": "strTermsofService".tr,
                                              "from": "Terms"
                                            });
                                      }),
                                  buildCommonRow(
                                      icon: iconsPrivacy,
                                      name: "strPrivacyPolicy".tr,
                                      isDivider: true,
                                      onTap: () {
                                        Get.toNamed(AppRoutes.StaticPage,
                                            arguments: {
                                              "title": "strPrivacyPolicy".tr,
                                              "from": "Privacy"
                                            });
                                      }),
                                  buildCommonRow(
                                      icon: deleteAccount,
                                      name: "strDeleteAccount".tr,
                                      isDivider: true,
                                      onTap: () {
                                        showDialog(
                                          context: Get.context!,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              elevation: 0,
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: _buildDeleteModalContent(
                                                  context, controller),
                                            );
                                          },
                                        );
                                      }),
                                  buildCommonRow(
                                      icon: iconsLogOut,
                                      name: "strLogout".tr,
                                      isDivider: false,
                                      onTap: () {
                                        showDialog(
                                          context: Get.context!,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              elevation: 0,
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: _buildOtpModalContent(
                                                  context, controller),
                                            );
                                          },
                                        );
                                        // =>
                                        //     controller.logout()
                                      }),
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOtpModalContent(BuildContext context, controller) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.35,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imagemodalbackground), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            LogoutModal,
            height: 80,
            width: 80,
          ),
          TextView(
            text: "strLogoutModal".tr,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "minorksans",
                fontSize: 18,
                fontWeight: FontWeight.w800),
            maxLines: 4,
          ).marginOnly(top: 10, left: 10, right: 10),
          SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: MaterialButtonWidget(
                    buttonBgColor: Colors.transparent,
                    buttonRadius: 8,
                    isOutlined: true,
                    borderColor: Colors.black,
                    buttonText: "strNoCancel".tr,
                    buttonTextStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontFamily: "Kodchasan",
                        fontWeight: FontWeight.w600),
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: Obx(
                    () => MaterialButtonWidget(
                      isloading: controller.isLoading.value,
                      buttonBgColor: AppColors.clickTextColor,
                      buttonRadius: 8,
                      buttonText: "strYesLogout".tr,
                      buttonTextStyle: TextStyle(
                          fontSize: 12,
                          color: AppColors.whiteColor,
                          fontFamily: "Kodchasan",
                          fontWeight: FontWeight.w600),
                      textColor: AppColors.whiteColor,
                      onPressed: () {
                        controller.logout();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 15),
        ],
      ),
    );
  }

  Widget _buildDeleteModalContent(BuildContext context, controller) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.35,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imagemodalbackground), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            deleteModal,
            height: 80,
            width: 80,
          ),
          TextView(
            text: "strDeleteModal".tr,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "minorksans",
                fontSize: 18,
                fontWeight: FontWeight.w800),
            maxLines: 4,
          ).marginOnly(top: 10, left: 10, right: 10),
          SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: MaterialButtonWidget(
                    buttonBgColor: Colors.transparent,
                    buttonRadius: 8,
                    isOutlined: true,
                    borderColor: Colors.black,
                    buttonText: "strNoCancel".tr,
                    buttonTextStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontFamily: "Kodchasan",
                        fontWeight: FontWeight.w600),
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: Obx(
                    () => MaterialButtonWidget(
                      isloading: controller.isLoading.value,
                      buttonBgColor: AppColors.clickTextColor,
                      buttonRadius: 8,
                      buttonText: "strYesDelete".tr,
                      buttonTextStyle: TextStyle(
                          fontSize: 12,
                          color: AppColors.whiteColor,
                          fontFamily: "Kodchasan",
                          fontWeight: FontWeight.w600),
                      textColor: AppColors.whiteColor,
                      onPressed: () {
                        controller.deleteUser();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 15),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: Get.width,
      height: Get.height * 0.08,
      decoration: BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: TextView(
        text: "strProfile".tr,
        textStyle: const TextStyle(
          color: AppColors.blackColor,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ).marginSymmetric(horizontal: 20, vertical: 10),
    );
  }

  Widget _buildTopProfileSection(SettingScreenController controller) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Skeletonizer(
        enabled: controller.isLoading.value,
        child: Row(
          children: [
            controller.userResponseModel.value.data?.image == null ||
                    controller.userResponseModel.value.data?.image?.isEmpty ==
                        true
                ? Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.circular(80)),
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: AppColors.whiteColor,
                    ),
                  )
                : NetworkImageWidget(
                    imageUrl:
                        controller.userResponseModel.value.data?.image ?? "",
                    imageHeight: 100,
                    imageWidth: 100,
                    radiusAll: 100,
                  ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: controller.userResponseModel.value.data?.fullName ??
                        "Unknown",
                    textStyle: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                      fontFamily: "minorksans",
                    ),
                  ),
                  Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: AppColors.clickTextColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: TextView(
                                text:
                                    "${controller.userResponseModel.value.data?.milestone ?? 0}",
                                textStyle: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            top: -13,
                            right: -3,
                            child: AssetImageWidget(
                              iconWinner,
                              imageWidth: 20,
                              imageHeight: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: Get.width * 0.4,
                        child: RoundedProgressBar(
                          style: RoundedProgressBarStyle(
                              colorBackgroundIcon: Colors.transparent,
                              colorProgress: AppColors.clickTextColor,
                              colorProgressDark: AppColors.whiteColor,
                              colorBorder: Colors.grey.shade100,
                              backgroundProgress: AppColors.whiteColor,
                              borderWidth: 4,
                              widthShadow: 6),
                          margin: EdgeInsets.symmetric(vertical: 16),
                          borderRadius: BorderRadius.circular(30),
                          percent: controller
                                  .userResponseModel.value.data?.percentage
                                  ?.toDouble() ??
                              0.0,
                          height: 10,
                        ),
                      ).marginSymmetric(horizontal: 10),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Get.toNamed(AppRoutes.EditProfile);
                      controller.GetUserProfile();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.buttonColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.edit_outlined,
                              color: Colors.black, size: 15),
                          const SizedBox(width: 10),
                          TextView(
                            text: "strEditProfile".tr,
                            textStyle: const TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ).marginOnly(top: 8, right: 50),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(controller) {
    return Container(
      width: Get.width,
      height: Get.height * 0.1,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.buttonColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _statColumn("strTabTask".tr,
              "${controller.userResponseModel?.value.data?.taskCount}"),
          _statColumn("strTabApplyJobs".tr,
              "${controller.userResponseModel?.value.data?.appliedJobs}"),
          _statColumn("strSelected".tr,
              "${controller.userResponseModel?.value.data?.selectedJobs}"),
        ],
      ),
    );
  }

  Widget _statColumn(String title, String value) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextView(
            text: title,
            textStyle: const TextStyle(
              color: AppColors.blackColor,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextView(
            text: value,
            textStyle: const TextStyle(
              color: AppColors.clickTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: TextView(
        text: title,
        textStyle: const TextStyle(
          color: AppColors.greyshadetext,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _settingsGroup(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: children),
    );
  }
}

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
import '../../../core/widget/text_view.dart';
import '../controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (controller) {
        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.buttonColor,
          child: Scaffold(
            body: Obx(() => Skeletonizer(
                  enabled: controller.isLoading.value &&
                      controller.notifications.isEmpty,
                  child: RefreshIndicator(
                    onRefresh: controller.refreshNotifications,
                    child: Column(
                      children: [
                        _buildHeader(controller),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: controller.scrollController,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildNotificationList(controller),
                                if (controller.isLoadingMore.value)
                                  const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                if (!controller.hasMore.value &&
                                    controller.notifications.isNotEmpty)
                                  const SizedBox()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }

  Widget _buildHeader(controller) {
    return Container(
      width: Get.width,
      height: Get.height * 0.08,
      decoration: const BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: Get.back,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  size: 20,
                ),
              ),
            ).marginOnly(left: margin_10),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextView(
                    text: "strNotifications".tr,
                    textStyle: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 1, // Ensure text doesn't wrap
                    overflow: TextOverflow.ellipsis, // Handle text overflow
                  ).marginSymmetric(vertical: 10),
                ),
                GestureDetector(
                  onTap: () {
                    controller.markAllAsRead();
                  },
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.max, // Minimize the size of this Row
                    children: [
                      SizedBox(
                        width: 110,
                        child: TextView(
                          maxLines: 1,
                          text: "strMarkAllRead".tr,
                          textStyle: const TextStyle(
                            color: AppColors.greyshadetext,
                            fontFamily: "Kodchasan",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Already present, kept for clarity
                        ).marginSymmetric(vertical: 10, horizontal: 5),
                      ),
                      const Icon(
                        Icons.check_circle_outline_rounded,
                        size: 20,
                      ),
                    ],
                  ).marginSymmetric(horizontal: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(NotificationController controller) {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return Column(
              children: [
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: controller.notifications[index]?.isRead == true
                        ? Colors.transparent
                        : AppColors.buttonColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.buttonColor, // Adjust color as needed
                        width: 2.0, // Adjust thickness as needed
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(70),
                            ),
                            child: Center(
                              child: AssetImageWidget(
                                controller.notifications[index].type ==
                                        "TASK_COMPLETED"
                                    ? JobModal
                                    : controller.notifications[index].type ==
                                                "TASK_REJECTED" ||
                                            controller.notifications[index]
                                                    .type ==
                                                "JOB_REJECTED"
                                        ? CancelRed
                                        : controller.notifications[index]
                                                    .type ==
                                                "JOB_SHORTLISTED"
                                            ? JobShortlisted
                                            : controller.notifications[index]
                                                        .type ==
                                                    "JOB_ALERT"
                                                ? jobAlert
                                                : controller
                                                            .notifications[
                                                                index]
                                                            .type ==
                                                        "MILESTONE_UNLOCKED"
                                                    ? unlocked
                                                    : controller
                                                                .notifications[
                                                                    index]
                                                                .type ==
                                                            "SUBSCRIPTION_STARTED"
                                                        ? subscriptionStarted
                                                        : controller
                                                                    .notifications[
                                                                        index]
                                                                    .type ==
                                                                "SUBSCRIPTION_RENEWED"
                                                            ? subscriptionRenewed
                                                            : controller
                                                                        .notifications[
                                                                            index]
                                                                        .type ==
                                                                    "SUBSCRIPTION_FAILED"
                                                                ? CancelRed
                                                                : controller.notifications[index]
                                                                            .type ==
                                                                        "SUBSCRIPTION_CANCELLED"
                                                                    ? subscriptionCancelled
                                                                    : subscriptionStarted,
                                imageWidth: 25,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  maxLines: 10,
                                  text: notification.title ?? '',
                                  textStyle: const TextStyle(
                                    color: AppColors.blackColor,
                                    fontFamily: "Kodchasan",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ).marginSymmetric(horizontal: 10),
                                TextView(
                                  maxLines: 2,
                                  text: notification.description ?? '',
                                  textStyle: const TextStyle(
                                    color: AppColors.greyshadetext,
                                    fontFamily: "Kodchasan",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ).marginSymmetric(horizontal: 10),
                              ],
                            ),
                          ),
                        ],
                      )
                          .marginSymmetric(
                            horizontal: 10,
                          )
                          .paddingSymmetric(vertical: 10),
                    ],
                  ).marginSymmetric(vertical: 5),
                ).marginSymmetric(horizontal: 10).marginOnly(top: 5),
              ],
            );
          },
        )).marginSymmetric(vertical: 20);
  }
}

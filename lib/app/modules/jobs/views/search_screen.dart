import 'dart:async';
import 'package:disstrikt/app/modules/jobs/controllers/search_controller.dart';
import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../core/widget/custom_text_field.dart';
import '../../../core/widget/network_image_widget.dart';
import '../../../core/widget/text_view.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ModelSearchController>(
      init: ModelSearchController(),
      builder: (controller) {
        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.light,
          statusBarColor: AppColors.buttonColor,
          child: Scaffold(
            backgroundColor: AppColors.buttonColor.withOpacity(0.3),
            body: SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
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
                        text: "bottomSearch".tr,
                        textAlign: TextAlign.start,
                        textStyle: const TextStyle(
                          color: AppColors.blackColor,
                          fontFamily: "minorksans",
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 4,
                      ).marginSymmetric(horizontal: 20, vertical: 10),
                    ),
                    TextFieldWidget(
                      hint: "strSearch".tr,
                      hintStyle: TextStyle(
                        color: AppColors.greyshadetext,
                        fontFamily: "Kodchasan",
                      ),
                      textColors: Colors.black,
                      textController: controller.searchController,
                      fillColor: Colors.white,
                      color: Colors.black,
                      borderColor: AppColors.ModalDivider,
                      courserColor: AppColors.buttonColor,
                      inputType: TextInputType.text,
                    ).marginSymmetric(horizontal: 20, vertical: 10),
                    TextView(
                      text: "strTopSearches".tr,
                      textAlign: TextAlign.start,
                      textStyle: const TextStyle(
                        color: AppColors.blackColor,
                        fontFamily: "minorksans",
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 4,
                    ).marginSymmetric(horizontal: 20),
                    Expanded(
                      child: Obx(
                        () => RefreshIndicator(
                          onRefresh: () =>
                              controller.getSearchUsers(isLoadMore: false),
                          child: controller.isLoading.value &&
                                  controller.users.isEmpty
                              ? Skeletonizer(
                                  enabled: true,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    controller: controller.scrollController,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: 10,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12,
                                      childAspectRatio: 0.9,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Skeleton.leaf(
                                        child: Container(
                                          height: Get.height * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : GridView.builder(
                                  key: const ValueKey('grid_view'),
                                  controller: controller.scrollController,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: _getItemCount(controller),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 0.85,
                                  ),
                                  itemBuilder: (context, index) {
                                    if (index >= controller.users.length) {
                                      return Skeleton.leaf(
                                        child: Container(
                                          height: Get.height * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      );
                                    }
                                    final image = controller.users[index];
                                    return Skeleton.keep(
                                      child: GestureDetector(
                                        onTap: () async {
                                          Get.toNamed(AppRoutes.publicPortfolio,
                                              arguments: {"id": image.sId});
                                        },
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              image.image == null ||
                                                      image.image == ""
                                                  ? Container(
                                                      height: Get.height * 0.2,
                                                      width: Get.width / 2,
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .buttonColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 120,
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                    )
                                                  : NetworkImageWidget(
                                                      imageUrl:
                                                          image?.image ?? '',
                                                      radiusAll: 8,
                                                      imageHeight:
                                                          Get.height * 0.2,
                                                      imageWidth: Get.width / 2,
                                                      imageFitType:
                                                          BoxFit.cover,
                                                    ),
                                              const SizedBox(height: 5),
                                              TextView(
                                                text: image?.fullName ?? '',
                                                textStyle: const TextStyle(
                                                  color: AppColors.blackColor,
                                                  fontFamily: "Kodchasan",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ),
                    Obx(
                      () => controller.isLoadingMore.value
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  int _getItemCount(ModelSearchController controller) {
    if (controller.isLoading.value && controller.users.isEmpty) {
      return 10; // Show skeleton placeholders during initial load
    }
    return controller.users.length +
        (controller.isLoadingMore.value
            ? 2
            : 0); // Add placeholders for load more
  }
}

import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../core/widget/asset_image_widget.dart';
import '../../../core/widget/text_view.dart';
import '../../../core/widget/material_button_widget.dart';
import '../controller/plans_controller.dart';

class ChoosePlanScreen extends GetView<ChoosePalnController> {
  const ChoosePlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegionWidget(
      statusBarBrightness: Brightness.light,
      statusBarColor: Color.fromRGBO(37, 33, 34, 1),
      child: Scaffold(
        body: Stack(
          children: [
            AssetImageWidget(
              onBoardingimage,
              imageHeight: Get.height,
              imageWidth: Get.width,
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: SizedBox(
                width: Get.width,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: height_40,
                      width: width_40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)),
                      child: Center(
                          child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 18,
                      )).marginOnly(right: 2),
                    ).marginSymmetric(
                        horizontal: margin_13, vertical: margin_13),
                    AssetImageWidget(
                      plansImage,
                      imageHeight: Get.height * 0.3,
                      imageWidth: Get.width,
                      fit: BoxFit.fill,
                    ).marginSymmetric(horizontal: 20),
                    Align(
                      alignment: Alignment.center,
                      child: TextView(
                        text: "strChooseYour".tr,
                        textStyle: const TextStyle(
                            color: AppColors.whiteColor,
                            fontFamily: "minorksans",
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                        maxLines: 4,
                      ).marginSymmetric(vertical: margin_20),
                    ),
                    MaterialButtonWidget(
                      buttonBgColor: AppColors.buttonColor,
                      buttonRadius: 8,
                      buttonText: "strNext".tr,
                      iconWidget: Icon(Icons.arrow_forward_sharp,
                          color: AppColors.backgroundColor),
                      textColor: AppColors.backgroundColor,
                      onPressed: () {
                        // controller.next();
                      },
                    ).marginSymmetric(horizontal: 20, vertical: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

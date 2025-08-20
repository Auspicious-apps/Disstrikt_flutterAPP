import 'package:disstrikt/app/modules/taskModule/controllers/taskdetail_controller.dart';
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

class TaskDetail extends StatelessWidget {
  const TaskDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskdetailController>(
      init: TaskdetailController(),
      builder: (controller) {
        return AnnotatedRegionWidget(
          statusBarBrightness: Brightness.dark,
          statusBarColor: AppColors.buttonColor.withOpacity(0.2),
          child: Scaffold(
            backgroundColor: AppColors.buttonColor.withOpacity(0.4),
            body: Obx(() => Skeletonizer(
                  enabled: controller.isLoading.value,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
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
                                    color:
                                        AppColors.buttonColor.withOpacity(0.0),
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
                                        text:
                                            "${"strTabTask".tr} ${controller.taskDetailModel?.value.data?.taskNumber ?? ""}",
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
                              if (controller.taskDetailModel?.value?.data
                                      ?.answerType ==
                                  "DONE")
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: Get.height * 0.7,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: TextView(
                                            text:
                                                "${controller.taskDetailModel?.value.data?.title}",
                                            textStyle: const TextStyle(
                                              color: AppColors.blackColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ).marginOnly(bottom: 5),
                                        TextView(
                                          maxLines: 10000000,
                                          textAlign: TextAlign.center,
                                          text:
                                              "${controller.taskDetailModel?.value.data?.description}",
                                          textStyle: const TextStyle(
                                            color: AppColors.greyshadetext,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ).marginSymmetric(horizontal: 20),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      MaterialButtonWidget(
                        buttonBgColor: AppColors.buttonColor,
                        buttonRadius: 8,
                        buttonText: "strDone".tr,
                        textColor: AppColors.backgroundColor,
                        onPressed: () {
                          Map<String, dynamic> requestModel =
                              AuthRequestModel.SubmitTaskRequestModel(
                            writeSection:
                                controller.doneWriteSectionTextController.text,
                          );
                          controller.submitTaskDetail(
                              controller.taskDetailModel?.value.data?.sId,
                              requestModel);
                        },
                      ).marginSymmetric(vertical: 10, horizontal: 20),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  Widget _writeSectionField(controller) => TextFieldWidget(
        hint: "strConfirmPassword".tr,
        hintStyle: TextStyle(
          color: AppColors.smalltextColor,
          fontFamily: "Kodchasan",
        ),
        textColors: Colors.black,
        maxline: 7,
        minLine: 7,
        textController: controller.doneWriteSectionTextController,
        fillColor: AppColors.whiteColor,
        borderColor: AppColors.buttonColor,
        courserColor: AppColors.buttonColor,
        focusNode: controller.doneWriteSectionFocusNode,
        inputType: TextInputType.text,
      );
}

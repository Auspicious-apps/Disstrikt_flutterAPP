import 'package:better_player_plus/better_player_plus.dart';
import 'package:disstrikt/app/modules/taskModule/controllers/taskdetail_controller.dart';
import 'package:disstrikt/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/custom_text_field.dart';
import '../../../core/widget/text_view.dart';
import '../../auth/models/requestmodels/RequestModel.dart';
import '../models/ResponseModels/QuizRequest.dart';

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
                                      "DONE" &&
                                  controller.taskDetailModel?.value?.data
                                          ?.taskType !=
                                      "WATCH_VIDEO")
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
                                ),
                              if (controller.taskDetailModel?.value?.data
                                      ?.answerType ==
                                  "QUIZ")
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
                                        Image.asset(
                                          QuizTaskModel,
                                          height: 100,
                                          width: 100,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
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
                                              "${controller.taskDetailModel?.value.data?.description?.isNotEmpty == true ? controller.taskDetailModel?.value.data?.description : "Please answer the following questions. Note that this quiz would also affect the overall level of your profile."}",
                                          textStyle: const TextStyle(
                                            color: AppColors.greyshadetext,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ).marginSymmetric(horizontal: 20),
                                  ),
                                ),
                              if (controller.taskDetailModel?.value?.data
                                          ?.answerType ==
                                      "DONE" &&
                                  controller.taskDetailModel?.value?.data
                                          ?.taskType ==
                                      "WATCH_VIDEO")
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    if (controller.videoWatch.value == false &&
                                        controller.isControllerValid.value)
                                      Container(
                                        width: Get.width,
                                        child: AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: BetterPlayer(
                                            controller: controller
                                                .betterPlayerController!,
                                          ),
                                        ),
                                      ).marginOnly(top: 20, bottom: 20)
                                  ],
                                ).marginSymmetric(horizontal: 20),
                              if (controller.taskDetailModel?.value?.data
                                          ?.answerType ==
                                      "UPLOAD_FILE" &&
                                  controller.taskDetailModel?.value?.data
                                          ?.taskType ==
                                      "TEXT")
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    TextView(
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                      text: "strUploadFile".tr,
                                      textStyle: const TextStyle(
                                        color: AppColors.greyshadetext,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      width: Get.width,
                                      height: Get.height * 0.2,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.whiteColor),
                                    ).marginSymmetric(vertical: 10)
                                  ],
                                ).marginSymmetric(horizontal: 20),
                            ],
                          ),
                        ),
                      ),
                      if (controller.taskDetailModel?.value?.data?.answerType ==
                          "QUIZ")
                        MaterialButtonWidget(
                          buttonBgColor: AppColors.buttonColor,
                          buttonRadius: 8,
                          buttonText: "strStartQuiz".tr,
                          textColor: AppColors.backgroundColor,
                          onPressed: () {
                            showDialog(
                              context: Get.context!,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  child: _buildOtpModalContent(
                                      context, controller),
                                );
                              },
                            );
                          },
                        ).marginSymmetric(vertical: 10, horizontal: 20),
                      if (controller.taskDetailModel?.value?.data?.answerType !=
                          "QUIZ")
                        MaterialButtonWidget(
                          buttonBgColor: AppColors.buttonColor,
                          buttonRadius: 8,
                          buttonText: "strDone".tr,
                          textColor: AppColors.backgroundColor,
                          onPressed: () {
                            controller.videoWatch.value = true;
                            Map<String, dynamic> requestModel =
                                AuthRequestModel.SubmitTaskRequestModel(
                              writeSection: controller
                                  .doneWriteSectionTextController.text,
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

  Widget _buildOtpModalContent(BuildContext context, controller) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.62,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 238, 240, 1),
        borderRadius: BorderRadius.circular(20.0),
        border: Border(
          bottom: BorderSide(
            color: AppColors.clickTextColor,
            width: 5.0,
          ),
          right: BorderSide(
            color: AppColors.clickTextColor,
            width: 5.0,
          ),
        ),
      ),
      child: Obx(() => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: TextView(
                    text:
                        "Question ${controller.currentQues.value + 1} of ${controller.taskDetailModel?.value?.data.quiz.length ?? 0}",
                    textStyle: const TextStyle(
                      color: AppColors.greyshadetext,
                      fontSize: 12,
                      fontFamily: "kodchasan",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ).marginOnly(bottom: 10),
                Align(
                  alignment: Alignment.center,
                  child: TextView(
                    maxLines: 100,
                    textAlign: TextAlign.center,
                    text:
                        "${controller.taskDetailModel?.value?.data.quiz[controller.currentQues.value].question}",
                    textStyle: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                      fontFamily: "minorksans",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ).marginOnly(bottom: 20),
                GestureDetector(
                  onTap: () {
                    controller.selectedAnswer.value = "option_A";
                    controller.selectedAnswer.refresh();
                  },
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: controller.selectedAnswer.value == "option_A"
                            ? AppColors.greenColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextView(
                        maxLines: 100,
                        textAlign: TextAlign.center,
                        text:
                            "${controller.taskDetailModel?.value?.data.quiz[controller.currentQues.value].optionA}",
                        textStyle: TextStyle(
                          color: controller.selectedAnswer.value == "option_A"
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                          fontSize: 14,
                          fontFamily: "kodchasan",
                          fontWeight: FontWeight.w400,
                        ),
                      ).marginSymmetric(horizontal: 10, vertical: 15),
                    ),
                  ),
                ).marginSymmetric(horizontal: 10),
                GestureDetector(
                  onTap: () {
                    controller.selectedAnswer.value = "option_B";
                    controller.selectedAnswer.refresh();
                  },
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: controller.selectedAnswer.value == "option_B"
                            ? AppColors.greenColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextView(
                        maxLines: 100,
                        textAlign: TextAlign.center,
                        text:
                            "${controller.taskDetailModel?.value?.data.quiz[controller.currentQues.value].optionB}",
                        textStyle: TextStyle(
                          color: controller.selectedAnswer.value == "option_B"
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                          fontSize: 14,
                          fontFamily: "kodchasan",
                          fontWeight: FontWeight.w400,
                        ),
                      ).marginSymmetric(horizontal: 10, vertical: 15),
                    ),
                  ),
                ).marginSymmetric(horizontal: 10, vertical: 20),
                GestureDetector(
                  onTap: () {
                    controller.selectedAnswer.value = "option_C";
                    controller.selectedAnswer.refresh();
                  },
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: controller.selectedAnswer.value == "option_C"
                            ? AppColors.greenColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextView(
                        maxLines: 100,
                        textAlign: TextAlign.center,
                        text:
                            "${controller.taskDetailModel?.value?.data.quiz[controller.currentQues.value].optionC}",
                        textStyle: TextStyle(
                          color: controller.selectedAnswer.value == "option_C"
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                          fontSize: 14,
                          fontFamily: "kodchasan",
                          fontWeight: FontWeight.w400,
                        ),
                      ).marginSymmetric(horizontal: 10, vertical: 15),
                    ),
                  ),
                ).marginSymmetric(horizontal: 10),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    controller.selectedAnswer.value = "option_D";
                    controller.selectedAnswer.refresh();
                  },
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: controller.selectedAnswer.value == "option_D"
                            ? AppColors.greenColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextView(
                        maxLines: 100,
                        textAlign: TextAlign.center,
                        text:
                            "${controller.taskDetailModel?.value?.data.quiz[controller.currentQues.value].optionD}",
                        textStyle: TextStyle(
                          color: controller.selectedAnswer.value == "option_D"
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                          fontSize: 14,
                          fontFamily: "kodchasan",
                          fontWeight: FontWeight.w400,
                        ),
                      ).marginSymmetric(horizontal: 10, vertical: 15),
                    ),
                  ),
                ).marginSymmetric(horizontal: 10),
                SizedBox(
                  height: 20,
                ),
                MaterialButtonWidget(
                  buttonBgColor: AppColors.buttonColor,
                  buttonRadius: 8,
                  borderColor: AppColors.clickTextColor,
                  isOutlined: true,
                  buttonText: "strSubmit".tr,
                  textColor: AppColors.backgroundColor,
                  onPressed: () {
                    if (controller.selectedAnswer.value.isNotEmpty) {
                      controller.quizAnswers.add(QuizAnswer(
                          quizId: controller.taskDetailModel?.value?.data
                                  .quiz[controller.currentQues.value].sId ??
                              "",
                          answer: controller.selectedAnswer.value));

                      controller.selectedAnswer.value = "";
                      if (controller.currentQues.value ==
                          (controller.taskDetailModel?.value?.data.quiz.length -
                              1)) {
                        Get.back();
                        Map<String, dynamic> requestModel =
                            AuthRequestModel.SubmitTaskRequestModel(
                          quiz: controller.quizAnswers,
                        );
                        controller.submitTaskDetail(
                            controller.taskDetailModel?.value.data?.sId,
                            requestModel);
                      } else {
                        controller.currentQues.value++;
                      }
                    }
                  },
                ).marginSymmetric(vertical: 10, horizontal: 20),
              ],
            ).paddingAll(10),
          )),
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

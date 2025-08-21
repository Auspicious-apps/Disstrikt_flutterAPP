/*
<!--
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
-->
*/
import 'package:better_player_plus/better_player_plus.dart';
import 'package:disstrikt/app/data/repository/endpoint.dart';
import 'package:disstrikt/app/export.dart';
import 'package:disstrikt/app/modules/auth/models/responseModels/userResponseModel.dart';
import 'package:get/get.dart';
import '../../../data/local/preferences/preference.dart';
import '../models/ResponseModels/Message.dart';
import '../models/ResponseModels/QuizRequest.dart';
import '../models/ResponseModels/TaskDetailResponseModel.dart';

class TaskdetailController extends GetxController {
  final LocalStorage _localStorage = LocalStorage();
  final doneWriteSectionTextController = TextEditingController();
  final doneWriteSectionFocusNode = FocusNode();
  List<QuizAnswer> quizAnswers = [];
  BetterPlayerController? betterPlayerController;
  RxBool isLoading = true.obs;
  var type = "".obs;
  var selectedAnswer = "".obs;
  var currentQues = 0.obs;
  var isInitialized = false.obs;
  var isPlaying = false.obs;
  var videoWatch = false.obs;
  var isControllerValid = false.obs;
  final signupFormKey = GlobalKey<FormState>();

  Rx<TaskDetailModel>? taskDetailModel = TaskDetailModel().obs;
  Rx<Message>? message = Message().obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      var id = Get.arguments["id"];
      type.value = Get.arguments["type"];
      type.refresh();
      GetTaskDetail(id);
    }
    super.onInit();
  }

  GetTaskDetail(String? id) {
    try {
      isLoading.value = true;
      Get.closeAllSnackbars();
      repository.getTaskDetailApiCall(ID: id).then((value) async {
        if (value != null) {
          taskDetailModel?.value = value;
          if (taskDetailModel?.value.data?.taskType == "WATCH_VIDEO" &&
              isInitialized.value == false &&
              betterPlayerController == null) {
            if (taskDetailModel?.value.data?.link?.isNotEmpty ?? false) {
              BetterPlayerDataSource dataSource = BetterPlayerDataSource(
                BetterPlayerDataSourceType.network,
                "${imageBaseUrl}${taskDetailModel?.value.data?.link?.first}",
              );

              betterPlayerController = BetterPlayerController(
                const BetterPlayerConfiguration(
                  autoPlay: false,
                  aspectRatio: 16 / 9,
                  fit: BoxFit.contain,
                  controlsConfiguration: BetterPlayerControlsConfiguration(
                    enableFullscreen: true,
                    enablePlayPause: true,
                    enableMute: true,
                    enableProgressBarDrag: true,
                    enableProgressBar: true,
                    enableSkips: true,
                  ),
                ),
                betterPlayerDataSource: dataSource,
              );

              isControllerValid.value = true;

              betterPlayerController!.addEventsListener((event) {
                print("BetterPlayer Event: ${event.betterPlayerEventType}");
                if (event.betterPlayerEventType ==
                    BetterPlayerEventType.initialized) {
                  isInitialized.value = true;
                  isPlaying.value =
                      betterPlayerController!.isPlaying() ?? false;
                } else if (event.betterPlayerEventType ==
                        BetterPlayerEventType.play ||
                    event.betterPlayerEventType ==
                        BetterPlayerEventType.pause) {
                  isPlaying.value =
                      betterPlayerController!.isPlaying() ?? false;
                } else if (event.betterPlayerEventType ==
                    BetterPlayerEventType.finished) {
                  videoWatch.value = true;
                  print("Video playback completed");
                }
              });

              betterPlayerController!.addEventsListener((event) {
                if (event.betterPlayerEventType ==
                    BetterPlayerEventType.exception) {
                  print("Video player error: ${event.parameters}");
                  isControllerValid.value = false;
                  Get.snackbar('Error', 'Failed to load video');
                }
              });
            } else {
              print("Invalid video URL");
              isLoading.value = false;
              Get.snackbar('Error', 'Invalid video URL');
            }
          }
          isLoading.value = false;
        } else {
          isLoading.value = false;
          Get.closeAllSnackbars();
        }
      }).onError((er, stackTrace) {
        print("$er");
        isLoading.value = false;
        Get.closeAllSnackbars();
        Get.snackbar('Error', '$er');
      });
    } catch (er) {
      isLoading.value = false;
      print("$er");
    }
  }

  submitTaskDetail(String? id, data) {
    try {
      isLoading.value = true;
      Get.closeAllSnackbars();
      repository.TaskSubmitApiCall(ID: id, dataBody: data).then((value) async {
        if (value != null) {
          message?.value = value;
          isLoading.value = false;
          if (taskDetailModel?.value.data?.taskType == "WATCH_VIDEO") {
            isControllerValid.value = false;
          }
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: taskDetailModel?.value.data?.answerType == "QUIZ"
                    ? _buildQuizModalContent(context)
                    : _buildOtpModalContent(context),
              );
            },
          );
        } else {
          isLoading.value = false;
          Get.closeAllSnackbars();
        }
      }).onError((er, stackTrace) {
        print("$er");
        isLoading.value = false;
        Get.closeAllSnackbars();
        Get.snackbar('Error', '$er');
      });
    } catch (er) {
      isLoading.value = false;
      print("$er");
    }
  }

  Widget _buildQuizModalContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.37,
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
            JobModal,
            height: 80,
            width: 80,
          ),
          TextView(
            text: "strQuizCompleted".tr,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "Kodchasan",
                fontSize: 12,
                fontWeight: FontWeight.w400),
            maxLines: 1,
          ).marginOnly(top: 10),
          SizedBox(height: 10.0),
          TextView(
            text:
                " ${message?.value.data?.correctCount}/${message?.value.data?.totalCount} ${"strCorrectAnswers".tr}",
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "minorksans",
                fontSize: 16,
                fontWeight: FontWeight.w400),
            maxLines: 4,
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: MaterialButtonWidget(
                    buttonBgColor: Colors.transparent,
                    buttonRadius: 8,
                    isOutlined: true,
                    borderColor: AppColors.clickTextColor,
                    buttonText: "strOkay".tr,
                    iconWidget: Icon(Icons.arrow_forward_sharp,
                        size: 15, color: AppColors.backgroundColor),
                    buttonTextStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontFamily: "Kodchasan",
                        fontWeight: FontWeight.w600),
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      Get.back();
                      Get.back();
                    },
                  ),
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 15),
        ],
      ),
    );
  }

  Widget _buildOtpModalContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.37,
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
            TaskSubmited,
            height: 80,
            width: 80,
          ),
          TextView(
            text: "strTaskSubmitted".tr,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "minorksans",
                fontSize: 18,
                fontWeight: FontWeight.w800),
            maxLines: 4,
          ).marginOnly(top: 10),
          SizedBox(height: 10.0),
          TextView(
            text: "strTaskModalSubHeading".tr,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "Kodchasan",
                fontSize: 12,
                fontWeight: FontWeight.w400),
            maxLines: 4,
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: MaterialButtonWidget(
                    buttonBgColor: Colors.transparent,
                    buttonRadius: 8,
                    isOutlined: true,
                    borderColor: AppColors.clickTextColor,
                    buttonText: "strContinue".tr,
                    iconWidget: Icon(Icons.arrow_forward_sharp,
                        size: 15, color: AppColors.backgroundColor),
                    buttonTextStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontFamily: "Kodchasan",
                        fontWeight: FontWeight.w600),
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      Get.back();
                      Get.back();
                    },
                  ),
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 15),
        ],
      ),
    );
  }

  @override
  void onClose() {
    betterPlayerController?.dispose();
    doneWriteSectionTextController.dispose();
    doneWriteSectionFocusNode.dispose();
    quizAnswers.clear();
    isControllerValid.value = false;
    super.onClose();
  }
}

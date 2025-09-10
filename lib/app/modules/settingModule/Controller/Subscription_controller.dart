/*
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
*/

import 'package:disstrikt/app/export.dart';
import 'package:disstrikt/app/modules/auth/models/responseModels/userResponseModel.dart';
import 'package:get/get.dart';

import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';

import '../../home/controller/start_journey_controller.dart';
import '../../home/models/responseModels /plansResponseModel.dart';
import '../../home/models/responseModels /setupIntentResponseModel.dart';
import '../Models/ReponseModel/StaticModel.dart';
import '../Models/ReponseModel/active_plan_responseModel.dart';

class SubscriptionController extends GetxController {
  StatiResponseModel? staticdatamodel;
  final LocalStorage _localStorage = LocalStorage();
  Rx<PlansResponseModel> planResponseModel = PlansResponseModel().obs;
  Rx<ActivePlanResponsemodel> setupIntent = ActivePlanResponsemodel().obs;
  RxInt selectIndex = 10.obs;
  Rx<PlanData?> newFacePlan =
      Rx<PlanData?>(null); // Observable for New Face Plan
  RxList<PlanData> otherPlans = RxList<PlanData>([]);
  RxList<PlanData> queuePlans =
      RxList<PlanData>([]); // Observable for other plans
  RxBool isloading = false.obs;
  var titile = "".obs;
  UserResponseModel? userResponseModel;

  @override
  void onInit() {
    super.onInit();

    GetModelPlans();
  }

  IntialSetupIntentPlans() {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.getActivePlanApiCall().then((value) async {
        if (value != null) {
          setupIntent.value = value;

          setupIntent.refresh();
          _splitPlans(setupIntent.value.data?.planId,
              setupIntent.value.data?.nextPlanId);
          isloading.refresh();
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value = false;
        isloading.refresh();
        Get.closeAllSnackbars();
        Get.snackbar(
          'Error',
          '$er',
          backgroundColor: Colors.white.withOpacity(0.5),
        );
      });
    } catch (er) {
      isloading.value = false;
      isloading.refresh();
      print("$er");
    }
  }

  void GetModelPlans() {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.getPlansApiCall().then((value) async {
        if (value != null) {
          planResponseModel.value = value;
          planResponseModel.refresh();
          // Split plans into New Face Plan and other plans
          IntialSetupIntentPlans();
        }

        isloading.refresh();
      }).onError((error, stackTrace) {
        print("Error fetching plans: $error");
        isloading.value = false;
        isloading.refresh();

        Get.closeAllSnackbars();
        Get.snackbar(
          'Error',
          '$error',
          backgroundColor: Colors.white.withOpacity(0.5),
        );
      });
    } catch (er) {
      print("Exception in GetModelPlans: $er");
      isloading.value = false;
      isloading.refresh();
      Get.snackbar(
        'Error',
        '$er',
        backgroundColor: Colors.white.withOpacity(0.5),
      );
    }
  }

  // Method to split plans into New Face Plan and other plans
  void _splitPlans(String? planName, String? nextPlanId) {
    if (planResponseModel.value.data != null) {
      // Find New Face Plan
      final newFace = planResponseModel.value.data!.firstWhere(
        (plan) => plan.sId == planName,
        orElse: () => PlanData(), // Return empty Plan if not found
      );
      if (newFace.name != null) {
        newFacePlan.value = newFace;
      } else {
        newFacePlan.value = null;
        print("New Face Plan not found in the response");
      }
      newFacePlan.refresh();
      queuePlans.value = planResponseModel.value.data!
          .where((plan) => plan.sId == nextPlanId)
          .toList();

      // Filter other plans (exclude New Face Plan)
      otherPlans.value = planResponseModel.value.data!
          .where((plan) => plan.sId != planName && plan.sId != nextPlanId)
          .toList();
      print("Other Plans: ${queuePlans.map((p) => p.sId).toList()}");

      otherPlans.refresh();
      print("New Face Plan: ${newFacePlan.value?.name}");
      print("Other Plans: ${otherPlans.map((p) => p.sId).toList()}");
      isloading.value = false;
      isloading.refresh();
    }
  }

  handleSubmit(var data) {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.ChangeSubscriptionApiCall(dataBody: data).then((value) async {
        if (value != null) {
          userResponseModel = value;
          isloading.value = false;
          isloading.refresh();

          Get.closeAllSnackbars();
          GetModelPlans();

          Get.back();
          Get.snackbar(
            'Success',
            '${userResponseModel?.message}',
            backgroundColor: Colors.white.withOpacity(0.5),
          );
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value = false;
        isloading.refresh();
        Get.closeAllSnackbars();
        Get.snackbar(
          'Error',
          '${er}',
          backgroundColor: Colors.white.withOpacity(0.5),
        );
      });
    } catch (er) {
      isloading.value = false;
      isloading.refresh();
      print("$er");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}

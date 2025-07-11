/*
<!--
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
-->
*/

import 'package:disstrikt/app/data/repository/endpoint.dart';
import 'package:disstrikt/app/modules/auth/models/responseModels/userResponseModel.dart';
import 'package:disstrikt/app/modules/home/models/responseModels%20/setupIntentResponseModel.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../../main.dart';
import '../../../core/utils/localization_service.dart';
import '../../../data/local/preferences/preference.dart';
import '../../../export.dart';
import '../../../routes/app_routes.dart';
import '../models/requestModels/buyplanRequestModel.dart';
import '../models/responseModels /plansResponseModel.dart';

class ChoosePalnController extends GetxController {
  // Available countries
  final List<String> countries = LocalizationService.countries;
  final LocalStorage localStorage = LocalStorage();
  RxBool isloading = false.obs;
  Rx<PlansResponseModel> planResponseModel = PlansResponseModel().obs;
  Rx<SetupIntentResponseModel> setupIntent = SetupIntentResponseModel().obs;
  Rx<UserResponseModel> userResponseModel = UserResponseModel().obs;
  final List<String> languages = LocalizationService.languageNames;

  // Selected values
  var selectedCountry = "".obs;
  var selectedLanguage = "".obs;
  RxInt selectIndex = 0.obs;
  RxInt currencyselectIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    GetModelPlans();
    // Set initial values from storage or defaults
    selectedLanguage.value =
        LocalizationService.getLanguageName(LocalizationService.currentLocale);
    selectedCountry.value = LocalizationService.currentCountry;

    // If country is not set but language is, try to set a default country
    if (selectedCountry.value.isEmpty && selectedLanguage.value.isNotEmpty) {
      for (var entry in LocalizationService.countryToLanguage.entries) {
        if (entry.value == selectedLanguage.value) {
          selectedCountry.value = entry.key;
          break;
        }
      }
    }
  }

  Future<void> openCardInputSheet() async {
    try {
      // Show loading indicator
      isloading.value = true;
      isloading.refresh();

      // Initialize payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Disstrikt',
          customerId: setupIntent
              .value.data?.customerId, // Replace with actual customer ID
          setupIntentClientSecret: setupIntent
              .value.data?.clientSecret, // Replace with actual client secret,
          allowsDelayedPaymentMethods: false,
          style: ThemeMode.system,
        ),
      );

      // Present payment sheet
      await Stripe.instance.presentPaymentSheet();

      isloading.value = false;
      isloading.refresh();
      SetupIntentPlans();
    } catch (e) {
      // Handle errors and show feedback to the user
      isloading.value = false;
      isloading.refresh();
      Get.snackbar(
        'Error',
        'Failed to save card details: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error opening payment sheet: $e');
    }
  }

  GetModelPlans() {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.getPlansApiCall().then((value) async {
        if (value != null) {
          planResponseModel.value = value;
          planResponseModel.refresh();

          IntialSetupIntentPlans();
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value = false;
        isloading.refresh();
        Get.closeAllSnackbars();
        Get.snackbar('Error', '$er');
      });
    } catch (er) {
      isloading.value = false;
      isloading.refresh();
      print("$er");
    }
  }

  IntialSetupIntentPlans() {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.getSetupIntentApiCall().then((value) async {
        if (value != null) {
          isloading.value = false;
          setupIntent.value = value;
          setupIntent.refresh();
          isloading.refresh();
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value = false;
        isloading.refresh();
        Get.closeAllSnackbars();
        Get.snackbar('Error', '$er');
      });
    } catch (er) {
      isloading.value = false;
      isloading.refresh();
      print("$er");
    }
  }

  SetupIntentPlans() {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.getSetupIntentApiCall().then((value) async {
        if (value != null) {
          isloading.value = false;
          setupIntent.value = value;
          if (setupIntent.value.data?.alreadySetup == true) {
            showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: _buildOtpModalContent(context),
                );
              },
            );
          }
          setupIntent.refresh();
          isloading.refresh();
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value = false;
        isloading.refresh();
        Get.closeAllSnackbars();
        Get.snackbar('Error', '$er');
      });
    } catch (er) {
      isloading.value = false;
      isloading.refresh();
      print("$er");
    }
  }

  Widget _buildOtpModalContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.89,
      height: MediaQuery.of(context).size.height * 0.44,
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
            iconCurrency,
            height: 80,
            width: 80,
          ),
          TextView(
            text: "strSelectCurrency".tr,
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "minorksans",
                fontSize: 18,
                fontWeight: FontWeight.w800),
            maxLines: 4,
          ).marginOnly(top: 10),
          SizedBox(height: 14.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                planResponseModel.value.data?.first.currency?.length ?? 0,
            itemBuilder: (context, index) {
              return Obx(() => GestureDetector(
                        onTap: () {
                          currencyselectIndex.value = index;
                          currencyselectIndex.refresh();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isloading.value
                                ? Colors.grey.shade400
                                : currencyselectIndex.value == index
                                    ? AppColors.clickTextColor
                                    : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text:
                                      "${planResponseModel.value.data?.first.currency?[index].toUpperCase()} (${planResponseModel.value.data?.first.currency?[index] == "eur" ? "€" : "£"})",
                                  textStyle: const TextStyle(
                                    color: AppColors.blackColor,
                                    fontFamily: "Kodchasan",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ).marginSymmetric(horizontal: 16, vertical: 10),
                          ).marginOnly(top: 0, right: 3, bottom: 4, left: 0),
                        ),
                      ))
                  .marginSymmetric(horizontal: 20)
                  .marginOnly(top: index != 0 ? 10 : 0);
            },
          ),
          SizedBox(
            height: height_20,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(239, 71, 111, 1)),
                borderRadius: BorderRadius.circular(8)),
            child: MaterialButtonWidget(
              buttonBgColor: AppColors.buttonColor,
              buttonRadius: 8,
              buttonText: "strConfirm".tr,
              iconWidget: Icon(Icons.arrow_forward_sharp,
                  color: AppColors.backgroundColor),
              textColor: AppColors.backgroundColor,
              onPressed: () {
                Map<String, dynamic> requestModel =
                    BuyPlanRequestModel.planRequestModel(
                  planId: planResponseModel.value.data?[selectIndex.value].sId,
                  currency: planResponseModel.value.data?[selectIndex.value]
                      .currency?[currencyselectIndex.value],
                  paymentMethodId: setupIntent.value.data?.paymentMethodId,
                );
                BuyPlansApicall(requestModel);
              },
            ),
          ).marginSymmetric(horizontal: 20),
        ],
      ),
    );
  }

  BuyPlansApicall(var data) {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.buyPlanApiCall(dataBody: data).then((value) async {
        if (value != null) {
          isloading.value = false;
          userResponseModel.value = value;
          userResponseModel.refresh();
          Get.offNamed(AppRoutes.StartJourney);
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value = false;
        isloading.refresh();
        Get.closeAllSnackbars();
        Get.snackbar('Error', '$er');
      });
    } catch (er) {
      isloading.value = false;
      isloading.refresh();
      print("$er");
    }
  }

  // Change app language
  void changeLanguage(String languageName) {
    if (languageName.isNotEmpty) {
      selectedLanguage.value = languageName;
      LocalizationService.changeLocale(languageName);
    }
  }

  // Change country
  void changeCountry(String country) {
    if (country.isNotEmpty) {
      selectedCountry.value = country;

      // Optionally update language based on country
      final defaultLanguage = LocalizationService.countryToLanguage[country];
      if (defaultLanguage != null) {
        selectedLanguage.value = defaultLanguage;
        LocalizationService.changeLocale(defaultLanguage);
      }
    }
  }

  // Save preferences and continue
  void savePreferences() {
    if (selectedLanguage.value.isNotEmpty && selectedCountry.value.isNotEmpty) {
      LocalizationService.setCountry(selectedCountry.value);
      Get.offNamed(AppRoutes.splashRoute);
    } else {
      Get.snackbar(
        "strApplicationName".tr,
        "strPleaseSelectBoth".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

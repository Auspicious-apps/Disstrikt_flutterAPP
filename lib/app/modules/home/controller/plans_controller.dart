/*
<!--

  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains

  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->z
 */

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../main.dart';
import '../../../core/utils/localization_service.dart';
import '../../../data/local/preferences/preference.dart';
import '../../../routes/app_routes.dart';
import '../models/responseModels /plansResponseModel.dart';

class ChoosePalnController extends GetxController {
  // Available countries
  final List<String> countries = LocalizationService.countries;
  final LocalStorage localStorage = LocalStorage();
  RxBool isloading = false.obs;
  Rx<PlansResponseModel> planResponseModel = PlansResponseModel().obs;
  final List<String> languages = LocalizationService.languageNames;

  // Selected values
  var selectedCountry = "".obs;
  var selectedLanguage = "".obs;
  RxInt selectIndex = 0.obs;
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

  GetModelPlans() {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.getPlansApiCall().then((value) async {
        if (value != null) {
          isloading.value = false;

          planResponseModel.value = value;
          planResponseModel.refresh();
          isloading.refresh();
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value = false;
        isloading.refresh();
        Get.closeAllSnackbars();
        Get.snackbar('Error', '${er}');
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

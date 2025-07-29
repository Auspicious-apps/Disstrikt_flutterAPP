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
import '../../../core/utils/localization_service.dart';
import '../../../data/local/preferences/preference.dart';
import '../../../routes/app_routes.dart';

class ChooseLanguageController extends GetxController {
  // Available countries
  final List<String> countries = LocalizationService.countries;
  final LocalStorage localStorage = LocalStorage();
  var isDropdownOpen = false.obs;
  var isSecondDropdownOpen = false.obs;
  // Available languages
  final List<String> languages = LocalizationService.languageNames;

  // Selected values
  var selectedCountry = "".obs;
  var selectedLanguage = "".obs;

  @override
  void onInit() {
    super.onInit();
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

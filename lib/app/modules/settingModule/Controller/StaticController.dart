/*
<!--

  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains

  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->z
 */

import 'package:disstrikt/app/export.dart';
import 'package:disstrikt/app/modules/auth/models/responseModels/userResponseModel.dart';
import 'package:get/get.dart';

import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';
import '../Models/ReponseModel/StaticModel.dart';

class Staticcontroller extends GetxController {
  StatiResponseModel? staticdatamodel;
  final LocalStorage _localStorage = LocalStorage();
  final String htmlContent = '''
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Terms and Privacy</title>
    </head>
    <body>
        <h2>Terms of Service</h2>
        <p>Welcome to our application. By using our services, you agree to these Terms of Service. Please read them carefully.</p>
        <p><strong>1. Acceptance of Terms</strong><br>
        By accessing or using our app, you agree to be bound by these terms, including any updates posted within the app.</p>
        <p><strong>2. Use of Services</strong><br>
        You agree to use the app only for lawful purposes and in accordance with these terms. Prohibited activities include, but are not limited to, violating any applicable laws, harming others, or interfering with the app’s functionality.</p>
        <p><strong>3. Account Responsibility</strong><br>
        You are responsible for maintaining the confidentiality of your account information and for all activities under your account.</p>
        <p><strong>4. Termination</strong><br>
        We reserve the right to suspend or terminate your access to the app at our discretion, without notice, for conduct that violates these terms.</p>
        <p><strong>5. Limitation of Liability</strong><br>
        Our app is provided “as is” without warranties of any kind. We are not liable for any damages arising from your use of the app.</p>
        <p><strong>6. Contact Us</strong><br>
        For questions about these Terms, contact us at support@example.com.</p>

        <h2>Privacy Policy</h2>
        <p>Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information.</p>
        <p><strong>1. Information We Collect</strong><br>
        We may collect personal information such as your name, email address, and usage data when you interact with our app.</p>
        <p><strong>2. How We Use Your Information</strong><br>
        Your information is used to provide and improve our services, personalize your experience, and communicate with you.</p>
        <p><strong>3. Data Sharing</strong><br>
        We do not share your personal information with third parties except as required by law or to provide our services (e.g., with trusted service providers).</p>
        <p><strong>4. Data Security</strong><br>
        We implement reasonable security measures to protect your data, but no system is completely secure.</p>
        <p><strong>5. Your Rights</strong><br>
        You may have rights to access, correct, or delete your personal information. Contact us to exercise these rights.</p>
        <p><strong>6. Changes to This Policy</strong><br>
        We may update this Privacy Policy periodically. Changes will be posted within the app.</p>
        <p><strong>7. Contact Us</strong><br>
        For privacy-related inquiries, reach out to privacy@example.com.</p>
    </body>
    </html>
  ''';
  RxBool isLoading = false.obs;
  var titile = "".obs;
  var from = "".obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      titile.value = Get.arguments["title"];
      from.value = Get.arguments["from"];
      GetStaticData();
    }
    super.onInit();
  }

  GetStaticData() {
    try {
      isLoading.value = true;
      repository.GetStaticAPi(query: {
        "key": from.value == "Terms" ? "termAndCondition" : "privacyPolicy"
      }).then((value) async {
        if (value != null) {
          staticdatamodel = value;
          isLoading.value = false;
        }
      }).onError((er, stackTrace) {
        print("$er");
        isLoading.value = false;
        Get.closeAllSnackbars();
        Get.snackbar(
          'Error',
          '$er',
          backgroundColor: Colors.white.withOpacity(0.5),
        );
      });
    } catch (er) {
      isLoading.value = false;
      print("$er");
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

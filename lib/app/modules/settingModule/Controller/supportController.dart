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
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';
import '../Models/ReponseModel/StaticModel.dart';

class Supportcontroller extends GetxController {
  StatiResponseModel? staticdatamodel;
  final LocalStorage _localStorage = LocalStorage();

  RxBool isLoading = false.obs;
  var titile = "".obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      GetStaticData();
    }
    super.onInit();
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final cleanedNumber = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]+'), '');
    print('Attempting to call: $cleanedNumber');
    if (!RegExp(r'^\+?\d{10,15}$').hasMatch(cleanedNumber)) {
      print('Invalid phone number format: $cleanedNumber');
      Get.snackbar('Error', 'Invalid phone number format',
          snackPosition: SnackPosition.TOP);
      return;
    }
    final phoneUrl = 'tel:$cleanedNumber';
    try {
      if (await canLaunchUrlString(phoneUrl)) {
        print('Launching dial pad with URL: $phoneUrl');
        await launchUrlString(phoneUrl);
      } else {
        print('Cannot launch URL: $phoneUrl');
        Get.snackbar('Error', 'Could not launch dial pad',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print('Error launching dial pad: $e');
      Get.snackbar('Error', 'Could not launch dial pad: $e',
          snackPosition: SnackPosition.TOP);
      final phoneUri = Uri(scheme: 'tel', path: cleanedNumber);
      if (await canLaunchUrl(phoneUri)) {
        print('Fallback: Launching dial pad with Uri: $phoneUri');
        await launchUrl(phoneUri);
      } else {
        print('Fallback failed: Cannot launch Uri: $phoneUri');
        Get.snackbar('Error', 'Could not launch dial pad (fallback)',
            snackPosition: SnackPosition.TOP);
      }
    }
  }

  Future<void> openEmailClient(String emailAddress) async {
    // Clean the email address
    final cleanedEmail = emailAddress.trim().replaceAll(RegExp(r'\s+'), '');
    print('Attempting to open Gmail for: $cleanedEmail');

    // Validate email format
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(cleanedEmail)) {
      print('Invalid email format: $cleanedEmail');
      Get.snackbar(
        'Error',
        'Invalid email format',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 8,
      );
      return;
    }

    // Try Gmail-specific URI first (Android)
    final gmailUri = Uri.parse('googlegmail:///co?to=$cleanedEmail');
    print('Constructed Gmail URI: $gmailUri');

    try {
      // Check if Gmail URI can be launched
      bool canLaunchGmail = await canLaunchUrl(gmailUri);
      print('Can launch Gmail URI: $canLaunchGmail');
      if (canLaunchGmail) {
        print('Opening Gmail with URI: $gmailUri');
        await launchUrl(
          gmailUri,
          mode: LaunchMode.externalApplication,
        );
        return; // Exit if Gmail opens successfully
      } else {
        print('Gmail app not found, falling back to mailto');
      }
    } catch (e) {
      print('Error opening Gmail: $e');
    }

    // Fallback to mailto URI
    final mailtoUri = Uri(scheme: 'mailto', path: cleanedEmail);
    print('Constructed mailto URI: $mailtoUri');

    try {
      bool canLaunchMailto = await canLaunchUrl(mailtoUri);
      print('Can launch mailto: $canLaunchMailto');
      if (canLaunchMailto) {
        print('Opening email client with URI: $mailtoUri');
        await launchUrl(
          mailtoUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        print('No email client found to handle: $mailtoUri');
        // Fallback: Copy email to clipboard
        await Clipboard.setData(ClipboardData(text: cleanedEmail));
        Get.snackbar(
          'Info',
          'No Gmail or email client found. Email copied to clipboard: $cleanedEmail. Please install the Gmail app.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          borderRadius: 8,
          duration: Duration(seconds: 5),
        );
      }
    } catch (e) {
      print('Error opening email client: $e');
      Get.snackbar(
        'Error',
        'Could not open email client: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 8,
      );
      // Fallback: Copy email to clipboard
      await Clipboard.setData(ClipboardData(text: cleanedEmail));
      Get.snackbar(
        'Info',
        'Email copied to clipboard: $cleanedEmail',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 8,
      );
    }
  }

  GetStaticData() {
    try {
      isLoading.value = true;
      repository.GetStaticAPi(query: {"key": "support"}).then((value) async {
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

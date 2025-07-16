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
import 'package:get/get.dart';

import '../../../core/utils/localization_service.dart';
import '../../../core/widget/intl_phone_field/countries.dart';
import '../models/responseModels/userResponseModel.dart';

class ForgetPasswordController extends GetxController {
  final PasswordTextController = TextEditingController();
  final PasswordFocusNode = FocusNode();
  final ConfirmPasswordTextController = TextEditingController();
  final ConfirmPasswordFocusNode = FocusNode();
  final signupFormKey = GlobalKey<FormState>();

  UserResponseModel? userResponseModel;
  RxBool isloading = false.obs;
  RxBool ShowPassword = false.obs;
  RxBool ShowConfirmPassword = false.obs;

  Widget _buildOtpModalContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.4,
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
            updatepassword,
            height: 100,
            width: 100,
          ),
          TextView(
            text: "strupadteModalheading".tr,
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "minorksans",
                fontSize: 20,
                fontWeight: FontWeight.w800),
            maxLines: 4,
          ).marginOnly(top: 10),
          TextView(
            textAlign: TextAlign.center,
            text: "strupadteModalsubheading".tr,
            textStyle: const TextStyle(
              color: Color.fromRGBO(68, 68, 68, 1),
              fontFamily: "Kodchasan",
              fontSize: 12,
            ),
            maxLines: 4,
          ).marginSymmetric(vertical: 5),
          SizedBox(height: 14.0),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(239, 71, 111, 1)),
                borderRadius: BorderRadius.circular(8)),
            child: MaterialButtonWidget(
              buttonBgColor: AppColors.buttonColor,
              buttonRadius: 8,
              buttonText: "strLogin".tr,
              iconWidget: Icon(Icons.arrow_forward_sharp,
                  color: AppColors.backgroundColor),
              textColor: AppColors.backgroundColor,
              onPressed: () {
                Get.back();
                Get.offAllNamed(AppRoutes.loginRoute);
              },
            ),
          ).marginSymmetric(horizontal: 20),
        ],
      ),
    );
  }

  handleSubmit(var data) {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.ResetPasswordOtpApiCall(dataBody: data).then((value) async {
        if (value != null) {
          userResponseModel = value;
          isloading.value = false;
          isloading.refresh();
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
}

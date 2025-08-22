import 'package:disstrikt/app/export.dart';
import 'package:disstrikt/app/modules/auth/models/responseModels/userResponseModel.dart';
import 'package:get/get.dart';
import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';
import '../models/responseModels /HomePageResponseModel.dart'
    show HomeResponseModel;

class StartJourneyController extends GetxController {
  Rx<HomeResponseModel>? userResponseModel = HomeResponseModel().obs;
  final LocalStorage localStorage = LocalStorage();
  var currentpage = 1.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    GetHomeDetail();
    super.onInit();
  }

  Future<void> GetHomeDetail() async {
    try {
      isLoading.value = true;
      final response = await repository.gethomeApiCall();

      if (response != null) {
        var token = localStorage.getAuthToken();
        print(token);
        userResponseModel?.value = response;
      }
    } catch (er) {
      print("$er");
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error',
        '$er',
        backgroundColor: Colors.white.withOpacity(0.5),
      );
    } finally {
      isLoading.value = false;
    }
  }

  logout() async {
    try {
      final response = await repository.logoutApi();

      if (response != null) {
        localStorage.clearLoginData();
        userResponseModel?.value = response;
        Get.snackbar(
          "Success",
          "${userResponseModel?.value.message}",
          backgroundColor: Colors.white.withOpacity(0.5),
        );
        Get.offAllNamed(AppRoutes.loginRoute);
      }
    } catch (e) {
      print(">>>>>>>>>>>$e");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}

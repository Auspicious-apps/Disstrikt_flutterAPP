import 'package:disstrikt/app/modules/auth/models/responseModels/userResponseModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:otp_autofill/otp_autofill.dart';

import '../../../data/local/preferences/preference.dart';
import '../../../export.dart';

class OtpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late OTPTextEditController otpController;
  late OTPInteractor _otpInteractor;

  late FocusNode pinFocusNode;
  var timerSeconds = 120.obs;
  bool isEdit = false;
  bool isForEmail = false;
  UserResponseModel? userResponseModel;
  RxBool forceErrorState = false.obs;

  String? phoneNumber;

  String? email;
  String? from;
  final LocalStorage _localStorage = LocalStorage();
  Timer? _timer;
  RxInt leftDuration = 30.obs;
  RxBool isTimerStarted = true.obs;
  RxBool isLoading = false.obs;
  RxBool isResendingOtp = false.obs;
  var language = "";

  @override
  void onInit() {
    _getArgs();
    _initOtpReader();
    startOtpTimer();
    _initControllers();
    super.onInit();
  }

  void _getArgs() {
    if (Get.arguments != null) {
      email = Get.arguments["email"];
      language = Get.arguments["language"];
    }
  }

  ResendOtpApi(var data) {
    try {
      Get.closeAllSnackbars();
      repository.ResendApiCall(dataBody: data).then((value) async {
        if (value != null) {
          userResponseModel = value;
          Get.snackbar('Success', '${userResponseModel?.message}');
          startOtpTimer();
        }
      }).onError((er, stackTrace) {
        print("$er");
        Get.closeAllSnackbars();
        Get.snackbar('Error', '${er}');
      });
    } catch (er) {
      print("$er");
    }
  }

  VerifyOtpApi(var data) {
    try {
      isLoading.value = true;
      isLoading.refresh();
      Get.closeAllSnackbars();
      repository.VerifyOtpApiCall(dataBody: data).then((value) async {
        if (value != null) {
          userResponseModel = value;
          if (userResponseModel?.data?.token != null) {
            _localStorage.saveAuthToken(userResponseModel?.data?.token);
          }
          Get.toNamed(AppRoutes.UserInfo);
          isLoading.value = false;
          isLoading.refresh();
          Get.snackbar('Success', '${userResponseModel?.message}');
        }
      }).onError((er, stackTrace) {
        print("$er");
        isLoading.value = false;
        isLoading.refresh();
        Get.closeAllSnackbars();
        Get.snackbar('Error', '${er}');
      });
    } catch (er) {
      isLoading.value = false;
      isLoading.refresh();
      print("$er");
    }
  }

  void startOtpTimer() {
    timerSeconds.value = 120; // Reset timer

    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  void _initOtpReader() async {
    _initInteractor();
    _initOtpController();
  }

  Future<void> _initInteractor() async {
    _otpInteractor = OTPInteractor();
    // final appSignature = await _otpInteractor.getAppSignature();
  }

  void _initOtpController() {
    otpController = OTPTextEditController(
      codeLength: 6,
      // onCodeReceive: (code) => _autoValidate(),
      autoStop: true,
      otpInteractor: _otpInteractor,
    );

    // ..startListenUserConsent(
    //   (code) {
    //     final exp = RegExp(r'(\d{4})');
    //     return exp.stringMatch(code ?? '') ?? '';
    //   },
    // );
  }

  void resendOtp() {
    otpController.clear();
  }

  @override
  void onClose() {
    otpController.dispose();
    pinFocusNode.dispose();

    super.onClose();
  }

  void _initControllers() {
    otpController.clear();
    pinFocusNode = FocusNode();
  }

  void _disposeControllers() {
    otpController.dispose();
    pinFocusNode.dispose();
  }
}

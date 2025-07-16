/*
<!--

  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains

  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

/*========================Email Validator==============================================*/

import '../../export.dart';

class EmailValidator {
  static String? validateEmail(String value, {FocusNode? focusNode}) {
    if (value.isEmpty) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return "strPleaseEnteremail".tr;
    } else if (!GetUtils.isEmail(value.trim())) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return "strInvalidEmail".tr;
    }
    return null;
  }

  static String? validateEmptyEmail(String value) {
    if (!GetUtils.isEmail(value.trim()) && value.isNotEmpty) {
      return "invalid email address";
    }
    return null;
  }
}

/*================================================== Password Validator ===================================================*/

class PasswordFormValidator {
  static String? validatePassword(String value) {
    var pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "strPleaseEnterPassword".tr;
    } else if (value.length < 8) {
      return "strInvalidPassword".tr;
    } else if (!regExp.hasMatch(value)) {
      return "strPasswordNotSecure".tr;
    }
    return null;
  }

  static String? validateConfirmPasswordMatch(
      {String? value, String? password}) {
    var pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "strConfirmPassword".tr;
    } else if (value.length < 8) {
      return "strConfirmInvalidPassword".tr;
    } else if (!regExp.hasMatch(value)) {
      return "strPasswordNotSecure".tr;
    } else if (value != password) {
      return "strPasswordMatch".tr;
    }
    return null;
  }
}

/*================================================== Phone Number Validator ===================================================*/

class PhoneNumberValidate {
  static String? validateMobile(String value, {FocusNode? focusNode}) {
    if (value.isEmpty) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return "invalid";
    } else if (value.length < 8 || value.length > 15) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return 'invalid';
    } else if (!validateNumber(value)) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return "invalid";
    }
    return null;
  }
}

bool validateNumber(String value) {
  var pattern = r'^[0-9]+$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}

/*===============================Field Checker=================================================*/
class FieldChecker {
  static String? fieldChecker(String? value, message, {FocusNode? focusNode}) {
    if (value == null || value.toString().trim().isEmpty) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return "$message ${"StrCannotEmpty".tr}";
    }
    return null;
  }

  static String? otpValidator({String? value}) {
    if (value == null || value.toString().trim().isEmpty) {
      return "strPleaseEnterOtp".tr;
    } else if (value.length < 4) {
      return "strInvalidOtp".tr;
    } else {
      return null;
    }
  }
}

class NameValidator {
  static String? validateName({required String title, required String value}) {
    if (value.isEmpty) {
      return '$title ${"StrCannotEmpty".tr}';
    }
    if (value.length < 2) {
      return '$title must be at least 2 characters long';
    }
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value)) {
      return '$title can only contain letters';
    }
    return null;
  }
}

class PriceFieldChecker {
  static String? fieldChecker(String? value, message, {FocusNode? focusNode}) {
    if (value == null || value.toString().trim().isEmpty) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return '$message cannot be empty';
    } else if (value.toString().trim().startsWith('0')) {
      if (focusNode != null) {
        focusNode.unfocus();
        focusNode.requestFocus();
      }
      return '$message cannot start with 0';
    }
    return null;
  }
}

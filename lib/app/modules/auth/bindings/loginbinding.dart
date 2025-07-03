
/*
<!--

  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains

  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

import 'package:disstrikt/app/export.dart';
import 'package:disstrikt/app/modules/auth/controllers/login_controller.dart';
import 'package:disstrikt/app/modules/auth/controllers/signupcontroller.dart';

class Loginbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
          () => LoginController(),
    );


  }
}

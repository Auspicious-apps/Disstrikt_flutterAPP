import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/data/repository/api_repository.dart';
import 'app/export.dart';
import 'app/routes/app_pages.dart';
import 'app/core/values/app_translations.dart';
import 'app/core/utils/localization_service.dart';
import 'firebase_options.dart';

GetStorage localStorage = GetStorage();
RxBool isDarkModeTheme = false.obs;
Repository repository = Get.put(Repository());

init() async {
  await GetStorage.init();
  repository = Get.put(Repository());
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Stripe.publishableKey =
      'pk_test_51RRy9rRsy5fydSQ8ZOq6ZDbAAKhYiuDVrNgUnBrz2DJ158HkXx0h50hLteKt7BCrWTwo54nnO2pUVumcMhJMup3k005L9fCm8o'; // Replace with your key
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Disstrikt',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      initialBinding: InitialBinding(),
      getPages: AppPages.routes,
      locale: LocalizationService.currentLocale,
      translations: AppTranslation(),
      fallbackLocale: LocalizationService.defaultLanguage,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

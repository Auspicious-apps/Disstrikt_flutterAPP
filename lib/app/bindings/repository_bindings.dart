import 'package:disstrikt/app/export.dart';

import '../data/repository/api_repository.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Repository>(
      () => Repository(),
      fenix: true,
    );
  }
}

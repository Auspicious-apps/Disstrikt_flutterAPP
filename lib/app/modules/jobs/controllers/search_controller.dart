import 'dart:async';
import 'package:disstrikt/app/export.dart';
import 'package:disstrikt/app/modules/auth/models/responseModels/userResponseModel.dart';
import 'package:get/get.dart';
import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';
import '../Models/SearchResponseModel.dart';

class ModelSearchController extends GetxController {
  SearchResponseModel? userResponseModel;
  List<dynamic> users =
      []; // Adjust type to match your SearchResponseModel.data.data item type
  int page = 1;
  int limit = 10;
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs; // Separate loading state for load more
  bool hasMore = true;
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  Timer? _debounce;
  final LocalStorage localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    getSearchUsers();
    searchController.addListener(_onSearchChanged);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoading.value &&
          !isLoadingMore.value &&
          hasMore) {
        getSearchUsers(isLoadMore: true);
      }
    });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      getSearchUsers();
    });
  }

  Future<void> getSearchUsers({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      page = 1;
      users.clear();
      hasMore = true;
      isLoading.value = true; // Show loading for initial fetch
    } else {
      isLoadingMore.value = true; // Show loading for load more
    }
    if (isLoading.value && isLoadMore || (!hasMore && isLoadMore)) {
      isLoadingMore.value = false;
      return;
    }

    update();

    Get.closeAllSnackbars();
    try {
      final query = {
        "page": page,
        "limit": limit,
        if (searchController.text.trim().isNotEmpty)
          "search": searchController.text.trim(),
      };
      final value = await repository.searchUserApiCall(query: query);
      if (value != null) {
        users.addAll(value.data?.data ?? []);
        userResponseModel = value;
        if ((value.data?.data?.length ?? 0) < limit) {
          hasMore = false;
        } else {
          page++;
        }
      }
    } catch (er) {
      print("$er");
      Get.snackbar('Error', '$er');
    }

    isLoading.value = false;
    isLoadingMore.value = false;
    update();
  }

  @override
  void onClose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    scrollController.dispose();
    _debounce?.cancel();
    super.onClose();
  }
}

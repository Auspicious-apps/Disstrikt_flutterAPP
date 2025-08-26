import 'package:disstrikt/app/export.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/NotificationModel.dart'
    show NotificationData, NotificationModel, NotificationsListItem;

class NotificationController extends GetxController {
  final RxBool isLoading = false.obs; // For initial loading
  final RxBool isLoadingMore = false.obs; // For loading more items
  final RxBool hasMore = true.obs; // Whether more data is available
  final RxList<NotificationsListItem> notifications =
      <NotificationsListItem>[].obs;
  final ScrollController scrollController = ScrollController();
  int page = 1;
  final int pageSize = 10;
  bool _isFetching = false; // Prevent duplicate API calls

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
    setupScrollListener();
  }

  void setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100 &&
          !isLoading.value &&
          !isLoadingMore.value &&
          hasMore.value &&
          !_isFetching) {
        loadMoreNotifications();
      }
    });
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      _isFetching = true;
      Get.closeAllSnackbars();
      final value = await repository.getAllNotificationApiCall(
        query: {
          "type": "VIEW",
          "page": "1",
          "per_page": pageSize.toString(),
        },
      );
      if (value != null && value.data?.notifications != null) {
        notifications.value = value.data!.notifications!;
        page = 1;
        hasMore.value = value.data!.notifications!.length == pageSize;
      } else {
        notifications.clear();
        hasMore.value = false;
      }
      isLoading.value = false;
      _isFetching = false;
    } catch (er) {
      isLoading.value = false;
      _isFetching = false;
      hasMore.value = false;
      Get.snackbar('Error', '$er');
    }
  }

  Future<void> loadMoreNotifications() async {
    if (_isFetching || !hasMore.value) return;

    try {
      isLoadingMore.value = true;
      _isFetching = true;
      final nextPage = page + 1;
      final value = await repository.getAllNotificationApiCall(
        query: {
          "type": "VIEW",
          "page": nextPage.toString(),
          "per_page": pageSize.toString(),
        },
      );
      if (value != null && value.data?.notifications != null) {
        notifications.addAll(value.data!.notifications!);
        page = nextPage;
        hasMore.value = value.data!.notifications!.length == pageSize;
      } else {
        hasMore.value = false;
      }
      isLoadingMore.value = false;
      _isFetching = false;
    } catch (er) {
      isLoadingMore.value = false;
      _isFetching = false;
      hasMore.value = false;
      Get.snackbar('Error', '$er');
    }
  }

  Future<void> markAllAsRead() async {
    try {
      notifications.clear();
      isLoading.value = true;
      isLoading.refresh();
      Get.closeAllSnackbars();
      final value = await repository.getAllNotificationApiCall(
        query: {
          "type": "READ",
        },
      );
      if (value != null) {
        isLoading.value = false;

        Get.snackbar('Success', '${value.message}');

        fetchNotifications();
      }
    } catch (er) {
      isLoading.value = false;
      _isFetching = false;
      hasMore.value = false;
      Get.snackbar('Error', '$er');
    }
  }

  Future<void> refreshNotifications() async {
    page = 1;
    hasMore.value = true;
    notifications.clear();
    await fetchNotifications();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

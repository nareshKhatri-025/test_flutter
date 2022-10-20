import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tekzee_test/app/data/user_response.dart';
import 'package:tekzee_test/app/services/user/user.service.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  int currentPage = 1;
  int totalPages = 1;
  bool isPageLoading = false;
  bool isLoading = true;
  final UserService _userService = UserService();
  List<Datum> userList = List.empty(growable: true);
  var seletedUser = Datum().obs;
  @override
  void onInit() {
    getUserList(true);
    super.onInit();
  }

  getUserList(bool isInitLoading) async {
    print("Getting user List=========================");
    try {
      if (isInitLoading) {
        isLoading = true;
        update();
      }
      final response = await _userService.getUserList(currentPage);
      if (response != null) {
        UserListResponse userListResponse = UserListResponse.fromJson(response);
        print(userListResponse.data);
        userList = userListResponse.data ?? [];
        totalPages = userListResponse.totalPages!;
        if (currentPage < totalPages) {
          currentPage = currentPage + 1;
        }
        if (isInitLoading) {
          isLoading = false;
        }
        isPageLoading = false;
        update();
      }
    } catch (e) {
      isPageLoading = false;
      if (isInitLoading) {
        isLoading = false;
      }
      update();
    }
  }

  onNotificationScroll(ScrollNotification sn, bool mounted) {
    if (!isPageLoading &&
        sn is ScrollUpdateNotification &&
        sn.metrics.pixels == sn.metrics.maxScrollExtent) {
      if (mounted) {
        isPageLoading = true;
      }
      _userService.getUserList(currentPage);
    }
    return true;
  }
}

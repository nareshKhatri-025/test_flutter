import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tekzee_test/app/modules/home/tabs/user_detail.tab.dart';
import 'package:tekzee_test/app/modules/home/tabs/user_list.tab.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
        centerTitle: true,
        bottom: TabBar(
          controller: controller.tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.person),
            ),
            Tab(
              icon: Icon(Icons.details_outlined),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: const [
          UserListTab(),
          UserDetailTab(),
        ],
      ),
    );
  }
}

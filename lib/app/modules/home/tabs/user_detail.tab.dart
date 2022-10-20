import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tekzee_test/app/modules/home/controllers/home_controller.dart';

class UserDetailTab extends GetView<HomeController> {
  const UserDetailTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.tabController.animateTo(0);
        return false;
      },
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() => controller.seletedUser.value.firstName != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          placeholder: const AssetImage("assets/1.png"),
                          image: NetworkImage(
                              controller.seletedUser.value.avatar.toString()),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _getItem("Name",
                          "${controller.seletedUser.value.firstName} ${controller.seletedUser.value.lastName}"),
                      _getItem("Email",
                          controller.seletedUser.value.email.toString()),
                    ],
                  )
                : const Center(child: Text("No User Selected"))),
          ),
        ),
      )),
    );
  }

  _getItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            value.toString(),
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

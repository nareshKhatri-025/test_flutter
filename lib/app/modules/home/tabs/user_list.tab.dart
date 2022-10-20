import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tekzee_test/app/modules/home/controllers/home_controller.dart';
import 'package:tekzee_test/app/widgets/user_list_item.widget.dart';

class UserListTab extends StatefulWidget {
  const UserListTab({Key? key}) : super(key: key);

  @override
  State<UserListTab> createState() => _UserListTabState();
}

class _UserListTabState extends State<UserListTab> {
  bool isLoading = false;

  final notificationListner = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (con) {
          return NotificationListener<ScrollNotification>(
            key: notificationListner,
            onNotification: (sn) => con.onNotificationScroll(sn, mounted),
            child: !con.isLoading
                ? con.userList.isNotEmpty
                    ? CupertinoScrollbar(
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: con.userList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return UserListItemWidget(
                                    onTap: () {
                                      con.tabController.animateTo(1);
                                      con.seletedUser.value =
                                          con.userList[index];
                                    },
                                    fName: con.userList[index].firstName
                                        .toString(),
                                    lName:
                                        con.userList[index].lastName.toString(),
                                    email: con.userList[index].email.toString(),
                                    avatar:
                                        con.userList[index].avatar.toString(),
                                  );
                                },
                              ),
                            ),
                            if (isLoading)
                              SliverToBoxAdapter(
                                child: _defaultLoading(),
                              )
                          ],
                        ),
                      )
                    : Center(
                        child: Text("No Data found"),
                      )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        });
  }

  Widget _defaultLoading() {
    return Container(
      padding: const EdgeInsets.all(15),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tekzee_test/app/utils/themes/style.dart';

class UserListItemWidget extends StatelessWidget {
  const UserListItemWidget(
      {Key? key,
      required this.fName,
      required this.lName,
      required this.email,
      required this.onTap,
      required this.avatar})
      : super(key: key);
  final String lName;
  final String fName;
  final String email;
  final String avatar;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          avatar,
        ),
      ),
      title: Text(
        "$fName $lName",
        style: kNameTextStyle,
      ),
      subtitle: Text(email),
    );
  }
}

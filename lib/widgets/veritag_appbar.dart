import 'package:flutter/material.dart';

import '../utils/constants.dart';

class VeritagAppbar extends StatelessWidget implements PreferredSizeWidget {
  const VeritagAppbar({super.key, required this.appbarTitle});
  final String appbarTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(0, 124, 130, 1.0),
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: colorBg,
          )),
      title:  Text(
        appbarTitle,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorBg,
        ),
      ),
      toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))),
    );
  }

  @override
  Size get preferredSize =>  const Size.fromHeight(80);
}

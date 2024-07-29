import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String appBarTitle;
  final Widget appBarIcon;

  const CustomAppBar({
    super.key,
    required this.appBarTitle,
    required this.appBarIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 124, 130, 1.0),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(onPressed: () {}, icon: appBarIcon),
          SizedBox(width: MediaQuery.sizeOf(context).width * 0.125),
          Text(
            appBarTitle,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )
        ],
      ),
    );
  }
}
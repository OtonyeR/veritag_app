import 'package:flutter/material.dart';
import 'package:veritag_app/widgets/primary_button.dart';

class ScanBottomSheet extends StatelessWidget {
  final String title;
  String? subText;
  final Widget icon;
  final String buttonText;
  final void Function()? buttonPressed;

  ScanBottomSheet(
      {super.key,
      required this.title,
      required this.icon,
      required this.buttonText,
      this.buttonPressed, this.subText,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 30.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(0, 124, 130, 1),
            ),
          ),
          const SizedBox(height: 36.0),
          icon,
          const SizedBox(height: 24.0),
          subText!.isNotEmpty ? Text(
            subText!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              color: Color.fromRGBO(34, 34, 34, 1.0),
            ),
          ) : Container(),
          const SizedBox(height: 18.0),
          PrimaryButton(
              buttonText: buttonText,
              buttonFunction: () {},
              buttonWidth: MediaQuery.sizeOf(context).width)
        ],
      ),
    );
  }
}

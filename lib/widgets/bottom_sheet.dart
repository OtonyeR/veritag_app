import 'package:flutter/material.dart';
import 'package:veritag_app/widgets/primary_button.dart';

class ScanBottomSheet extends StatelessWidget {
  final String title;
  final String subText;
  final Widget icon;
  final String buttonText;
  final void Function()? buttonPressed;

  const ScanBottomSheet(
      {super.key,
      required this.title,
      required this.subText,
      required this.icon,
      required this.buttonText,
      this.buttonPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
              color: Color.fromRGBO(143, 142, 148, 1),
            ),
          ),
          const SizedBox(height: 16.0),
          icon,
          const SizedBox(height: 16.0),
          Text(
            subText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24.0),
          PrimaryButton(
              buttonText: buttonText,
              buttonFunction: () {},
              buttonWidth: MediaQuery.sizeOf(context).width)
        ],
      ),
    );
  }
}

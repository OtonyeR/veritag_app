import 'package:flutter/material.dart';

import 'primary_button.dart';

class ScanBottomSheet extends StatelessWidget {
  final String title;
  final String? subText;
  final Widget icon;
  final String buttonText;
  final void Function()? buttonPressed;
  final Color? buttonColor;
  const ScanBottomSheet(
      {super.key,
      required this.title,
      required this.icon,
      required this.buttonText,
      required this.buttonPressed,
      this.subText = "",
      this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 30.0),
      decoration: const BoxDecoration(
        color: Colors.white,
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
          subText!.isNotEmpty
              ? Text(
                  subText!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(34, 34, 34, 1.0),
                  ),
                )
              : Container(),
          const SizedBox(height: 18.0),
          PrimaryButton(
              buttonColor: buttonColor,
              buttonText: buttonText,
              buttonFunction: buttonPressed,
              buttonWidth: MediaQuery.sizeOf(context).width)
        ],
      ),
    );
  }
}

//The actual usage sheets

showScanModal(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return ScanBottomSheet(
        title: 'Ready to scan',
        icon: SizedBox(
            height: 108,
            width: 108,
            child: Image.asset(
              'assets/scan_icon.png',
              fit: BoxFit.cover,
            )),
        buttonText: 'Continue',
        buttonPressed: () {},
        subText: 'Put your device near the NFC Tag you want to read',
      );
    },
  );
}

showDoneModal(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return ScanBottomSheet(
        title: 'Done',
        icon: SizedBox(
            height: 108,
            width: 108,
            child: Image.asset(
              'assets/done_icon.png',
              fit: BoxFit.cover,
            )),
        buttonPressed: () {},
        buttonText: 'See Result',
      );
    },
  );
}

import 'package:flutter/material.dart';

import 'primary_button.dart';

class ScanBottomSheet extends StatefulWidget {
  final String title;
  final String? subText;
  final Widget icon;
  final String buttonText;
  final void Function()? buttonPressed;

  const ScanBottomSheet({
    super.key,
    required this.title,
    required this.icon,
    required this.buttonText,
    required this.buttonPressed,
    this.subText = "",
  });

  @override
  State<ScanBottomSheet> createState() => _ScanBottomSheetState();
}

class _ScanBottomSheetState extends State<ScanBottomSheet> {
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
            widget.title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(0, 124, 130, 1),
            ),
          ),
          const SizedBox(height: 36.0),
          widget.icon,
          const SizedBox(height: 24.0),
          widget.subText!.isNotEmpty
              ? Text(
                  widget.subText!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(34, 34, 34, 1.0),
                  ),
                )
              : Container(),
          const SizedBox(height: 18.0),
          PrimaryButton(
              buttonText: widget.buttonText,
              buttonFunction: widget.buttonPressed,
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

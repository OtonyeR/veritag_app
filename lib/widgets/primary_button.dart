import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final void Function()? buttonFunction;
  final double buttonWidth;

  const PrimaryButton({
    super.key,
    required this.buttonText,
    required this.buttonFunction,
    required this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: 50,
      child: ElevatedButton(
        onPressed: buttonFunction,
        style: ElevatedButton.styleFrom(
            elevation: 0.0,
            backgroundColor: const Color.fromRGBO(0, 124, 130, 1.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(235, 238, 242, 1.0),
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

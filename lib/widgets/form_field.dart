import 'package:flutter/material.dart';


class CustomFormField extends StatelessWidget {
  final String fieldTitle;
  final String hintText;
  final TextEditingController controller;
  final bool readOnly;
  final TextInputType textInputType;
  String? Function(String?)? validator;
  int? maxLines;
  String? initialText;

  CustomFormField({
    super.key,
    required this.fieldTitle,
    required this.hintText,
    required this.controller,
    required this.readOnly,
    required this.textInputType,
    this.validator,
    this.maxLines,
    this.initialText
  });

  // final TextEditingController _manufacturerLocationController;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        fieldTitle,
        style: const TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(95, 99, 119, 1),
            fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        keyboardType: textInputType,
        maxLines: maxLines,
        initialValue: initialText,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(26, 32, 61, 0.3),
                fontWeight: FontWeight.w400),
            contentPadding: const EdgeInsets.all(12.0),
            fillColor: const Color.fromRGBO(252, 252, 253, 1),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(95, 99, 119, 0.5),
                )),
            focusColor: const Color.fromRGBO(232, 255, 247, 1),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(0, 124, 130, 1.0),
                ))),
        readOnly: readOnly,
        validator: validator,
      ),
      const SizedBox(height: 24),
    ]);
  }
}

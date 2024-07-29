// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:veritag_app/widgets/veritag_appbar.dart';

class ScanNfcResultPage extends StatefulWidget {
  const ScanNfcResultPage({super.key, required this.isProductAuthentic});
  final bool isProductAuthentic;

  @override
  State<ScanNfcResultPage> createState() => _ScanNfcResultPageState();
}

class _ScanNfcResultPageState extends State<ScanNfcResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VeritagAppbar(appbarTitle: 'Scan Nfc'),
      body: SafeArea(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
        Center(
          child: Text(widget.isProductAuthentic
              ? 'Product is Authentic'
              : 'Product is Not Authentic', style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),),
        ),
        const SizedBox(
          height: 50,
        ),
        widget.isProductAuthentic
            ? Image.asset(
                './assets/done_icon.png',
                height: 100,
                width: 100,
              )
            : Image.asset(
                './assets/error.png',
                height: 100,
                width: 100,
              ),
        const SizedBox(
          height: 50,
        ),
        Text(widget.isProductAuthentic
            ? 'This product is Authentic everything matches'
            : 'This product is not Authentic the UID doesn\'t match',style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              )),
                ],
              ),
      ),
    );
  }
}

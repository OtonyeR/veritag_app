import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veritag_app/utils/color.dart';
import 'package:veritag_app/services/local_db.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:veritag_app/services/controller.dart';
import 'package:veritag_app/widgets/bottom_sheet.dart';
import 'package:veritag_app/views/product_details_screen.dart';
import 'package:veritag_app/views/manufacture_home/components/nfc_row_box.dart';

import '../../models/product.dart';
import '../../services/remote_db.dart';

class ConsumerHomePage extends StatefulWidget {
  const ConsumerHomePage({super.key});

  @override
  State<ConsumerHomePage> createState() => _ConsumerHomePageState();
}

class _ConsumerHomePageState extends State<ConsumerHomePage> {
  final ProductService _productService = ProductService();
  final ScannedProductService _scannedProductService = ScannedProductService();

  String nfcData = '';
  final controller = Get.put(ConsumerHomeController());

  Future<void> _readNfc() async {
    try {
      NFCTag tag = await FlutterNfcKit.poll();
      if (tag.ndefAvailable != null) {
        var ndef = await FlutterNfcKit.readNDEFRecords();
        if (ndef.isNotEmpty) {
          String extractedText = ndef.map((record) {
            if (record.payload!.isNotEmpty && record.type == 'T') {
              // Assuming it's a text record
              int languageCodeLength = record.payload![0];
              return utf8.decode(record.payload!.sublist(1 + languageCodeLength));
            }
            return '';
          }).join(', ');

          setState(() {
            controller.isScanned.value = true;
            controller.resultMsg.value = 'Successfully read tag';
            nfcData = extractedText;
          });
        } else {
          _showErrorMessage('Tag is Empty');
        }
      } else {
        _showErrorMessage('NDEF not available');
      }
    } on PlatformException catch (e) {
      _showErrorMessage('${e.message}');
    } catch (e) {
      _showErrorMessage('Error: $e');
    } finally {
      await FlutterNfcKit.finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const HomeHeaderBoxWidget(
            isManufacturer: false,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 300,
                ),
                Image.asset(
                  'assets/vgroup.png',
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 100)
              ],
            ),
          ),
          Positioned(
            top: 200,
            left: 20,
            right: 20,
            child: Card(
              color: Colors.white,
              shape: const BeveledRectangleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NfcRowBox(
                      image: 'assets/scan_nfc.png',
                      title: 'Verify Product',
                      color: colorsClass.pinkColor,
                      onTap: () async {
                        controller.isScanned.value = false;
                        controller.resultMsg.value =
                            'Put your device near the Product Tag you want to read';
                        _showScanModal(context);
                        await Future.delayed(const Duration(seconds: 2));
                        _readNfc();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showScanModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Obx(
          () => ScanBottomSheet(
            title: 'Ready to scan',
            icon: SizedBox(
                height: 108,
                width: 108,
                child: Image.asset('assets/scan_icon.png', fit: BoxFit.cover)),
            buttonPressed: !controller.isScanned.value
                ? () => Navigator.of(context).pop()
                : () => _showDoneModal(context),
            buttonColor:
                !controller.isScanned.value ? const Color(0xffD5D4DB) : null,
            buttonText:
                !controller.isScanned.value ? 'Reading to tag....' : 'Continue',
            subText: controller.resultMsg.value,
          ),
        );
      },
    );
  }

  _showDoneModal(BuildContext context) {
    Navigator.of(context).pop();
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
          buttonText: 'Show result',
          buttonPressed: () async {
            final authentic = await _productService.isProductInDb(nfcData);
            if (authentic == true) {
              print(nfcData);
              final product =
                  await _productService.getSpecificProductByUid(nfcData);
              _scannedProductService.addScannedProduct(product!);
              _showVerifyModal(context, product: product, authentic: true);
            } else {
              if (!context.mounted) return;
              _showVerifyModal(context, authentic: false);
            }
          },
        );
      },
    );
  }

  _showVerifyModal(BuildContext context,
      {Product? product, required bool authentic}) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ScanBottomSheet(
          title: authentic
              ? 'Your Product is Authentic'
              : 'Your Product is not Authentic',
          icon: SizedBox(
            height: 108,
            width: 108,
            child: Image.asset(
              authentic ? 'assets/done_icon.png' : 'assets/error.png',
              fit: BoxFit.cover,
            ),
          ),
          buttonText: authentic ? 'View Details' : 'Back To Home',
          buttonPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => authentic
                      ? ProductDetailsScreen(
                          productInfo: product!,
                        )
                      : _showScanModal(context)),
            );
          },
        );
      },
    );
  }

  void _showErrorMessage(String message) {
    setState(() {
      controller.isScanned.value = false;
      controller.resultMsg.value = message;
    });
    FlutterNfcKit.finish();
  }
}
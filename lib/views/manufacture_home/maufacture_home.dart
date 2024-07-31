import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:veritag_app/models/product.dart';
import 'package:veritag_app/services/controller.dart';
import 'package:veritag_app/services/remote_db.dart';
import 'package:veritag_app/utils/color.dart';
import 'package:veritag_app/views/manufacturer_form_screen.dart';
import 'package:veritag_app/views/product_details_screen.dart';
import 'package:veritag_app/widgets/bottom_sheet.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:veritag_app/views/manufacture_home/components/nfc_row_box.dart';

class ManufactureHome extends StatefulWidget {
  const ManufactureHome({super.key});

  @override
  State<ManufactureHome> createState() => _ManufactureHomeState();
}

class _ManufactureHomeState extends State<ManufactureHome> {
  String nfcData = '';
  final controller = Get.put(ManufaturerHomeController());
  final ProductService _productService = ProductService();
  Future<void> _readNfc() async {
    try {
      NFCTag tag = await FlutterNfcKit.poll();
      if (tag.ndefAvailable != null) {
        var ndef = await FlutterNfcKit.readNDEFRecords();
        if (ndef.isNotEmpty) {
          setState(() {
            controller.isScanned.value = true;
            controller.resultMsg.value = 'Succesfully read tag';
            nfcData = ndef.map((e) => e).join(', ');
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const HomeHeaderBoxWidget(
            isManufacturer: true,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NfcRowBox(
                      image: 'assets/scan_nfc.png',
                      title: 'Verify tag',
                      color: colorsClass.pinkColor,
                      onTap: () async {
                        controller.isScanned.value = false;
                        controller.resultMsg.value =
                            'Put your device near the NFC Tag you want to read';
                        _showScanModal(context);
                        await Future.delayed(const Duration(seconds: 2));
                        _readNfc();
                      },
                    ),
                    NfcRowBox(
                      image: 'assets/add.png',
                      title: 'Add product',
                      color: colorsClass.greenColor,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ManufacturerFormScreen();
                          },
                        ));
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
              final product =
                  await _productService.getSpecificProductByUid(nfcData);
              _showVerifyModal(context, product: product, authentic: true);
            } else {
              _showVerifyModal(context, authentic: false);
            }
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

  _showVerifyModal(BuildContext context,
      {Product? product, required bool authentic}) {
    Navigator.of(context).pop();
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
            if (authentic) {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(
                          productInfo: product!,
                        )),
              );
            } else {
              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }
}

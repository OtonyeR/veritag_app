import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:get/get.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:veritag_app/models/product.dart';
import 'package:veritag_app/services/controller.dart';
import 'package:veritag_app/services/remote_db.dart';
import 'package:veritag_app/views/manufacture_home/history_page.dart';
import 'package:veritag_app/views/manufacture_home/maufacture_home.dart';
import 'package:veritag_app/views/product_details_screen.dart';
import 'package:veritag_app/widgets/bottom_sheet.dart';
import '../ohome_icons.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:veritag_app/utils/constants.dart';
import 'package:veritag_app/views/router_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  String nfcData = '';
  final controller = Get.put(BottomNavHomeController());
  final ProductService _productService = ProductService();

  @override
  void initState() {
    controller.isScanned.value = false;
    controller.resultMsg.value =
        'Put your device near the NFC Tag you want to read';

    super.initState();
  }

  Future<void> _readNfc() async {
    try {
      NFCTag tag = await FlutterNfcKit.poll();

      if (tag.ndefAvailable != null) {
        var ndefRecords = await FlutterNfcKit.readNDEFRecords();

        for (var record in ndefRecords) {
          if (record is ndef.TextRecord) {
            setState(() {
              nfcData = record.text!;
              controller.isScanned.value = true;
              controller.resultMsg.value = 'Successfully read tag';
            });
            return;
          }
        }

        if (ndefRecords.isEmpty) {
          _showErrorMessage('Tag is Empty');
        }
      } else {
        _showErrorMessage('NDEF not available');
      }
    } on PlatformException catch (e) {
      _showErrorMessage('  ${e.message}');
    } catch (e) {
      _showErrorMessage('Error: $e');
    } finally {
      await FlutterNfcKit.finish();
    }
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
    showModalBottomSheet(
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

            if (!context.mounted) return;

            if (authentic) {
              final product =
                  await _productService.getSpecificProductByUid(nfcData);

              if (product != null) {
                _showVerifyModal(context, product: product, authentic: true);
              } else {
                _showVerifyModal(context, authentic: false);
              }
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
          title: authentic == true
              ? 'Your Product is Authentic'
              : 'Your Product is not Authentic',
          icon: SizedBox(
            height: 108,
            width: 108,
            child: Image.asset(
              authentic == true ? 'assets/done_icon.png' : 'assets/error.png',
              fit: BoxFit.cover,
            ),
          ),
          buttonText: authentic == true ? 'View Details' : 'Back To Home',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        child: _getCurrentScreen(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            _buildNavItem(
              icon: Ohome.oc_home,
              label: 'Home',
              index: 0,
            ),
            const Spacer(),
            _buildNavItem(
              icon: IconsaxPlusLinear.clock_1,
              label: 'History',
              index: 1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        foregroundColor: colorBgW,
        onPressed: () async {
          controller.isScanned.value = false;
          controller.resultMsg.value =
              'Put your device near the NFC Tag you want to read';
          _showScanModal(context);
          await Future.delayed(const Duration(seconds: 2));
          _readNfc();
        },
        backgroundColor: colorPrimary,
        child: const Icon(IconsaxPlusBold.scan),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(
      {required IconData icon, required String label, required int index}) {
    return Expanded(
      child: InkWell(
        onTap: () => _handleNavigationChange(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _selectedIndex == index ? colorPrimary : colorBl,
            ),
            Text(
              label,
              style: TextStyle(
                color: _selectedIndex == index ? colorPrimary : colorBl,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getCurrentScreen() {
    switch (_selectedIndex) {
      case 0:
        return const ManufactureHome();
      case 1:
        return const ProductListScreen();
      default:
        return const RouterScreen();
    }
  }
}

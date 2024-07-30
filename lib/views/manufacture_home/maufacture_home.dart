import 'package:flutter/material.dart';
import 'package:veritag_app/utils/color.dart';
import 'package:veritag_app/views/manufacturer_form_screen.dart';
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
  Future<void> _readNfc() async {
    try {
      NFCTag tag = await FlutterNfcKit.poll();
      if (tag.ndefAvailable != null) {
        var ndef = await FlutterNfcKit.readNDEFRecords();
        if (ndef.isNotEmpty) {
          setState(() {
            nfcData = ndef.map((e) => e).join(', ');
          });
          showDoneModal(context);
        }
      } else {
        _showErrorMessage('NDEF not available');
      }
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
                      onTap: () {
                        _showScanModal(context);
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
          subText: 'Put your device near the NFC Tag you want to read',
          buttonPressed: () {},
        );
      },
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
    setState(() {
      nfcData = message;
    });
    FlutterNfcKit.finish();
  }
}

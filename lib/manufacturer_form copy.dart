import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import 'package:veritag_app/services/location.dart';
import 'package:veritag_app/models/product.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;

class ManufacturerFormNfc extends StatefulWidget {
  const ManufacturerFormNfc({super.key});

  @override
  State<ManufacturerFormNfc> createState() => _ManufacturerFormNfcState();
}

class _ManufacturerFormNfcState extends State<ManufacturerFormNfc> {
  final _formKey = GlobalKey<FormState>();
  final LocationService locationService = LocationService();
  String currentAddress = '';
  Position? currentPosition;
  String uuid = const Uuid().v4();
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _generateNewUuid() {
    setState(() {
      uuid = const Uuid().v4();
    });
  }

  void _addDataToDb(Product product) {
    FirebaseFirestore.instance.collection("testproducts").add(product.toMap());
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await locationService.getCurrentLocation();
      String address = await locationService.getAddressFromLatLng(position);
      setState(() {
        currentAddress = address;
      });
    } catch (e) {
      setState(() {
        currentAddress = 'Failed to get address';
      });
    }
  }

  Future<void> _writeNfc(String uuid) async {
    try {
      NFCTag tag = await FlutterNfcKit.poll();

      if (tag.ndefWritable != null) {
        print('availablea-$uuid');
        await FlutterNfcKit.writeNDEFRecords([
          ndef.TextRecord(text: uuid, language: 'en'),
          ndef.MimeRecord(
              decodedType: 'Content-type',
              payload: Uint8List.fromList('com.example.veritag_app'.codeUnits)),
        ]);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Message written to tag!')));
      } else {
        print('availableabbbb-$uuid');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to write message to tag')));
      }
    } catch (e) {
      print('ablea-$uuid');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to write message to tag:$e')));
    } finally {
      try {
        await FlutterNfcKit.finish();
      } catch (e) {
        try {
          await FlutterNfcKit.finish();
        } on PlatformException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Error finishing NFC session: ${e.message}')),
          );
        }
      }
    }
  }

  Future<void> _submitForm() async {
    await _writeNfc(uuid);
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => const NFCReadPage()));

    // if (_formKey.currentState!.validate()) {
    //   Product product = Product(
    //     uid: uuid,
    //     productName: _productNameController.text,
    //     isSentOut: true,
    //     manufactureDate: DateTime.now(),
    //     manufactureLocation: currentAddress,
    //     manufacturerName: _manufacturerNameController.text,
    //     productDescription: _productDescriptionController.text,
    //     productImage: imagePath ?? '',
    //   );
    //   _addDataToDb(product);
    //   _writeNfcTag(uuid);
    //    Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context) => const NFCReadPage()));
    //   // Navigator.of(context)
    //   //     .push(MaterialPageRoute(builder: (context) => const ConsumerPage()));
    // }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manufacturer Form'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: uuid,
                      border: const OutlineInputBorder(),
                      hintText: uuid,
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: currentAddress.isNotEmpty
                          ? currentAddress
                          : 'fetching location...',
                      border: const OutlineInputBorder(),
                      hintText: currentAddress,
                    ),
                    readOnly: true,
                    validator: (value) {
                      if (currentAddress.isEmpty) {
                        return 'Please enable location permissions';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: DateTime.now().toString(),
                      border: const OutlineInputBorder(),
                      hintText: DateTime.now().toString(),
                    ),
                    readOnly: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _submitForm();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const BeveledRectangleBorder()),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

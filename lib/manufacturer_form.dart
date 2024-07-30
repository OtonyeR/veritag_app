import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:veritag_app/models/product.dart';
import 'package:veritag_app/services/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManufacturerForm extends StatefulWidget {
  const ManufacturerForm({super.key});

  @override
  State<ManufacturerForm> createState() => _ManufacturerFormState();
}

class _ManufacturerFormState extends State<ManufacturerForm> {
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

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
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

  Future<void> _writeNfcTag(String uuid) async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable) {
      try {
        NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('NFC Tag Detected: ${tag.data}')));
          var ndef = Ndef.from(tag);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('NDEF Detected: ${ndef}')));
          if (ndef == null || !ndef.isWritable) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tag is not writable')));
            NfcManager.instance.stopSession();
            return;
          }
          NdefRecord ndefRecord = NdefRecord.createText(uuid);
          NdefMessage ndefMessage = NdefMessage([ndefRecord]);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('NFC Message: ${ndefMessage}')));
          await Ndef.from(tag)?.write(ndefMessage);
          final payload = ndefMessage.records.first.payload;
          String textMsg = String.fromCharCodes(payload);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(textMsg)));
          //  await ndef.write(ndefMessage);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Message written to tag!')));
          NfcManager.instance.stopSession();
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to write message to tag:$e')));
      } finally {
        NfcManager.instance.stopSession();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Device not availabe for tagging')));
    }
  } 

  Future<void> _submitForm() async {
    _writeNfcTag(uuid);
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
                    onPressed: _submitForm,
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

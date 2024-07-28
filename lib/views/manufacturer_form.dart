import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import 'package:veritag_app/consumer_page.dart';
import 'package:veritag_app/test_read_page.dart';
import 'package:veritag_app/utils/location.dart';
import 'package:veritag_app/models/product.dart';
import 'package:veritag_app/utils/image_picker.dart';
import 'package:nfc_manager/nfc_manager.dart';

class ManufacturerForm extends StatefulWidget {
  const ManufacturerForm({super.key});

  @override
  State<ManufacturerForm> createState() => _ManufacturerFormState();
}

class _ManufacturerFormState extends State<ManufacturerForm> {
  final _formKey = GlobalKey<FormState>();
  final LocationService locationService = LocationService();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _manufacturerNameController =
      TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();

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
    _productNameController.dispose();
    _manufacturerNameController.dispose();
    _productDescriptionController.dispose();
    _additionalInfoController.dispose();
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
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Tag is not writable')));
        return;
      }

      NdefMessage ndefMessage = NdefMessage([NdefRecord.createText(uuid)]);
      try {
        await ndef.write(ndefMessage);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Message written to tag!')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to write message to tag')));
      }
    });
  }

  Future<void> _submitForm() async {
    await _writeNfcTag(uuid);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const NFCReadPage()));

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

  Future<void> _pickImage() async {
    final path = await getImagePath();
    setState(() {
      imagePath = path;
    });
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
                    controller: _productNameController,
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the product name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _manufacturerNameController,
                    decoration: const InputDecoration(
                      labelText: 'Manufacturer Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the manufacturer name';
                      }
                      if (value.length < 10) {
                        return 'Please enter a valid name';
                      }
                      return null;
                    },
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
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _productDescriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Product Description (Optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _additionalInfoController,
                    decoration: const InputDecoration(
                      labelText:
                          'Additional Product Information (e.g., batch number, certifications)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 20),
                  imagePath == null
                      ? IconButton(
                          onPressed: _pickImage,
                          icon: const Icon(
                            Icons.file_upload_outlined,
                            size: 32,
                          ),
                        )
                      : GestureDetector(
                          onTap: _pickImage,
                          child: SizedBox(
                            height: 100,
                            width: 200,
                            child: Image.file(
                              File(imagePath!),
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
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

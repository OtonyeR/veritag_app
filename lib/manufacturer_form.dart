import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import 'package:veritag_app/location.dart';
import 'package:veritag_app/utils/image_picker.dart';

class ManufacturerForm extends StatefulWidget {
  const ManufacturerForm({super.key});

  @override
  State<ManufacturerForm> createState() => _ManufacturerFormState();
}

class _ManufacturerFormState extends State<ManufacturerForm> {
  final _formKey = GlobalKey<FormState>();
  String currentAddress = '';
  Position? currentPosition;
  final LocationService locationService = LocationService();
  String uuid = const Uuid().v4();
  String? imagePath;

  // Form fields controllers
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _manufacturerNameController =
      TextEditingController();
  // final TextEditingController _manufacturerLocationController =
  //     TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void generateNewUuid() {
    setState(() {
      uuid = const Uuid().v4();
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'UID',
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
                          labelText: 'Manufacturer Location',
                          border: const OutlineInputBorder(),
                          hintText: currentAddress),
                      readOnly: true,
                      validator: (value) {
                        value = currentAddress;
                        if (value.isEmpty) {
                          return 'Please enable location permissions';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Manufacture Date',
                          border: const OutlineInputBorder(),
                          hintText: DateTime.now().toString()),
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
                            onPressed: () async {
                              final path = await getImagePath();
                              setState(() {
                                imagePath = path;
                              });
                              if (imagePath != null) {}
                            },
                            icon: const Icon(
                              Icons.file_upload_outlined,
                              size: 32,
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              final path = await getImagePath();
                              setState(() {
                                imagePath = path;
                              });
                              if (imagePath != null) {}
                            },
                            child: SizedBox(
                              height: 100,
                              width: 200,
                              child: Image.file(
                                File(imagePath!),
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Process the data
                          _submitForm();
                        }
                      },
                      child: const Text('Submit'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _submitForm() {
    // Handle form submission
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await locationService.getCurrentLocation();
      String address = await locationService.getAddressFromLatLng(position);
      setState(() {
        currentAddress = address;
      });
    } catch (e) {
      print(e);
      setState(() {
        currentAddress = 'Failed to get address';
      });
    }
  }
}

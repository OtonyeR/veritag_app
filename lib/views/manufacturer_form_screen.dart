import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../utils/constants.dart';
import '../services/location.dart';
import '../utils/image_picker.dart';
import '../widgets/form_field.dart';
import '../widgets/image_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:ndef/ndef.dart' as ndef;
import '../widgets/primary_button.dart';
import '../widgets/veritag_appbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:veritag_app/models/product.dart';
import 'package:veritag_app/services/remote_db.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:veritag_app/services/controller.dart';
import 'package:veritag_app/widgets/bottom_sheet.dart';

class ManufacturerFormScreen extends StatefulWidget {
  const ManufacturerFormScreen({super.key});

  @override
  State<ManufacturerFormScreen> createState() => _ManufacturerFormScreenState();
}

class _ManufacturerFormScreenState extends State<ManufacturerFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final LocationService _locationService = LocationService();

  // Form fields controllers
  final TextEditingController _uuidController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();

  final TextEditingController _manufacturerNameController =
      TextEditingController();
  final TextEditingController _manufacturerLocationController =
      TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  List? imageDetailsList;
  final controller = Get.put(VeriTagController());
  @override
  void initState() {
    final DateTime date = DateTime.now();
    _dateController.text =
        '${date.day} - ${date.month} - ${date.year} ${date.hour}:${date.minute} ${date.timeZoneName}';
    _uuidController.text = const Uuid().v4();
    controller.isScanned.value = false;
    controller.resultMsg.value =
        'Put your device near the NFC Tag you want to write to';

    _setAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VeritagAppbar(
        appbarTitle: 'Product Details',
        arrowBackRequired: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        CustomFormField(
                          controller: _uuidController,
                          fieldTitle: 'Unique ID',
                          hintText: 'Product unique ID',
                          readOnly: true,
                          textInputType: TextInputType.text,
                        ),
                        CustomFormField(
                          controller: _productNameController,
                          fieldTitle: 'Enter Product Name',
                          hintText: 'Eg. Broli Lotion',
                          readOnly: false,
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the product name';
                            }
                            return null;
                          },
                        ),
                        ImageField(
                            onPressedCam: () async {
                              final path =
                                  await getImagePath(ImageSource.camera);
                              setState(() {
                                imageDetailsList = path;
                              });
                            },
                            onPressedGallery: () async {
                              final imageDetails =
                                  await getImagePath(ImageSource.gallery);
                              setState(() {
                                imageDetailsList = imageDetails;
                              });
                            },
                            imageDetail: imageDetailsList != null &&
                                    imageDetailsList!.first != null
                                ? Center(
                                    child: Text(
                                    'Image Selected: ${imageDetailsList![0]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ))
                                : Container()),
                        const SizedBox(height: 28),
                        CustomFormField(
                          controller: _productPriceController,
                          fieldTitle: 'Enter Standard Price',
                          hintText: 'Eg. 15,000',
                          readOnly: false,
                          textInputType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the product price';
                            }
                            if (value.length < 3) {
                              return 'Please enter a valid price';
                            }
                            return null;
                          },
                        ),
                        CustomFormField(
                          fieldTitle: 'Manufacturer Name',
                          hintText: 'Eg. Your Company Name',
                          controller: _manufacturerNameController,
                          textInputType: TextInputType.text,
                          readOnly: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the manufacturer name';
                            }
                            return null;
                          },
                        ),
                        CustomFormField(
                          fieldTitle: 'Manufacturer Location',
                          hintText: 'Your Location',
                          controller: _manufacturerLocationController,
                          readOnly: true,
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enable location permissions';
                            }
                            return null;
                          },
                        ),
                        CustomFormField(
                          fieldTitle: 'Manufacture Date',
                          hintText: 'hintText',
                          controller: _dateController,
                          textInputType: TextInputType.text,
                          readOnly: true,
                        ),
                        CustomFormField(
                          fieldTitle: 'Product Description (Optional)',
                          hintText: 'Tell consumers about your product',
                          controller: _productDescriptionController,
                          textInputType: TextInputType.text,
                          readOnly: false,
                          maxLines: 2,
                        ),
                        CustomFormField(
                          fieldTitle: 'Additional Product Information',
                          hintText: 'E.g., batch number, certifications',
                          controller: _additionalInfoController,
                          textInputType: TextInputType.text,
                          readOnly: false,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 44.0, horizontal: 24.0),
              child: PrimaryButton(
                  buttonText: 'Submit',
                  buttonFunction: () {
                    if (_formKey.currentState!.validate() &&
                        imageDetailsList != null) {
                      _showScanModal(context);
                      _submitForm();
                    }
                  },
                  buttonWidth: MediaQuery.sizeOf(context).width),
            ),
          ],
        ),
      ),
    );
  }

  _submitForm() async {
    // Handle form submission

    _showScanModal(context);

    await Future.delayed(const Duration(seconds: 2));

    _writeNfc(_uuidController.text);
  }

  Future<void> _setAddress() async {
    try {
      Position position = await _locationService.getCurrentLocation();
      String address = await _locationService.getAddressFromLatLng(position);
      setState(() {
        _manufacturerLocationController.text = address;
      });
    } catch (e) {
      print('Failed to get address: $e');
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
        var productservice = ProductService();
        var imageUrl = await productservice.uploadProductImage(
            imageDetailsList?[0], imageDetailsList?[1]);
        setState(() {
          productservice.addProductToDb(Product(
            uid: _uuidController.text.trim(),
            manufacturerName: _manufacturerNameController.text.trim(),
            productName: _productNameController.text.trim(),
            productPrice: _productPriceController.text.trim(),
            productImage: imageUrl,
            manufactureDate: _dateController.text.trim(),
            manufactureLocation: _manufacturerLocationController.text.trim(),
          ));
          controller.isScanned.value = true;
          controller.resultMsg.value = 'Message succesfully written to tag!';
        });
      } else {
        print('availableabbbb-$uuid');
        setState(() {
          controller.isScanned.value = false;
          controller.resultMsg.value =
              'Writing to tag failed, please try again!';
        });
      }
    } on PlatformException catch (e) {
      print('abbbb-$uuid');
      setState(() {
        controller.isScanned.value = false;
        controller.resultMsg.value = '${e.message}';
      });
    } catch (e) {
      print('ablea-$e');
      setState(() {
        controller.isScanned.value = false;
        controller.resultMsg.value = 'Failed to write message to tag';
      });
    } finally {
      try {
        await FlutterNfcKit.finish();
      } catch (e) {
        try {
          await FlutterNfcKit.finish();
        } on PlatformException catch (e) {
          setState(() {
            controller.isScanned.value = false;
            controller.resultMsg.value = '${e.message}';
          });
        }
      }
    }
  }

  _showScanModal(BuildContext context) {
    return showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Obx(
            () => ScanBottomSheet(
              title: 'Ready to scan',
              icon: SizedBox(
                  height: 108,
                  width: 108,
                  child:
                      Image.asset('assets/scan_icon.png', fit: BoxFit.cover)),
              buttonPressed: !controller.isScanned.value
                  ? () {}
                  : () => _showDoneModal(context),
              buttonText: !controller.isScanned.value
                  ? 'Writing to tag....'
                  : 'Continue',
              subText: controller.resultMsg.value,
            ),
          );
        });
      },
    );
  }

  _showDoneModal(BuildContext context) {
    Navigator.of(context).pop();
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
          buttonText: 'done',
          buttonPressed: () => Navigator.of(context).pop(),
        );
      },
    );
  }
}

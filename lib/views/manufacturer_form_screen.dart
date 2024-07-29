import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/image_picker.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/primary_button.dart';
import '../widgets/form_field.dart';
import '../widgets/appbar.dart';
import '../widgets/image_field.dart';

class ManufacturerForm extends StatefulWidget {
  const ManufacturerForm({super.key});

  @override
  State<ManufacturerForm> createState() => _ManufacturerFormState();
}

class _ManufacturerFormState extends State<ManufacturerForm> {
  final _formKey = GlobalKey<FormState>();

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

  @override
  void initState() {
    // TODO: implement initState
    final DateTime date = DateTime.now();
    _dateController.text =
        '${date.day} - ${date.month} - ${date.year} ${date.hour}:${date.minute} ${date.timeZoneName}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              appBarTitle: 'Product Details',
              appBarIcon: Icon(
                CupertinoIcons.back,
                color: Colors.white,
                size: 24,
              ),
            ),
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
                            final path = await getImagePath(ImageSource.camera);
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
                          imageDetail: imageDetailsList![0] == null
                              ? Container()
                              : Center(
                                  child: Text(
                                  'Image Selected: ${imageDetailsList![0]}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                )),
                        ),
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
                            if (value.length < 10) {
                              return 'Please enter a valid name';
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
                          readOnly: true,
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
                        imageDetailsList != null) {}
                  },
                  buttonWidth: MediaQuery.sizeOf(context).width),
            ),
          ],
        ),
      ),
    );
  }

  _submitForm() {
    // Handle form submission
  }
}

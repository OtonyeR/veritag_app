import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:veritag_app/utils/image_picker.dart';
import 'package:veritag_app/widgets/bottom_sheet.dart';
import 'package:veritag_app/widgets/primary_button.dart';

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
        '${date.day} / ${date.month} / ${date.year} ${date.hour}:${date.minute} ${date.timeZoneName}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.1,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 124, 130, 1.0),
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(50)),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.125),
                  const Text(
                    'Product Details',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
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
                        FormField(
                          controller: _uuidController,
                          fieldTitle: 'Unique ID',
                          hintText: 'Product unique ID',
                          readOnly: true,
                          textInputType: TextInputType.text,
                        ),
                        FormField(
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
                        FormField(
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
                        FormField(
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
                        FormField(
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
                        FormField(
                          fieldTitle: 'Manufacture Date',
                          hintText: 'hintText',
                          controller: _dateController,
                          textInputType: TextInputType.text,
                          readOnly: true,
                        ),
                        FormField(
                          fieldTitle: 'Product Description (Optional)',
                          hintText: 'Tell consumers about your product',
                          controller: _productDescriptionController,
                          textInputType: TextInputType.text,
                          readOnly: false,
                          maxLines: 2,
                        ),
                        FormField(
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
                        imageDetailsList != null) {
                      showModalBottomSheet(
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
                            subText:
                                'Put your device near the NFC Tag you want to read',
                          );
                        },
                      );
                    }
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

class FormField extends StatelessWidget {
  final String fieldTitle;
  final String hintText;
  final TextEditingController controller;
  final bool readOnly;
  final TextInputType textInputType;
  String? Function(String?)? validator;
  int? maxLines;

  FormField({
    super.key,
    required this.fieldTitle,
    required this.hintText,
    required this.controller,
    required this.readOnly,
    required this.textInputType,
    this.validator,
    this.maxLines
  });

  // final TextEditingController _manufacturerLocationController;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        fieldTitle,
        style: const TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(95, 99, 119, 1),
            fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        keyboardType: textInputType,
        maxLines: maxLines,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(26, 32, 61, 0.3),
                fontWeight: FontWeight.w400),
            contentPadding: const EdgeInsets.all(12.0),
            fillColor: const Color.fromRGBO(252, 252, 253, 1),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(95, 99, 119, 0.5),
                )),
            focusColor: const Color.fromRGBO(232, 255, 247, 1),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(0, 124, 130, 1.0),
                ))),
        readOnly: readOnly,
        validator: validator,
      ),
      const SizedBox(height: 24),
    ]);
  }
}

class ImageField extends StatelessWidget {
  final void Function()? onPressedCam;
  final void Function()? onPressedGallery;
  final Widget imageDetail;

  const ImageField(
      {super.key,
      required this.onPressedCam,
      required this.onPressedGallery,
      required this.imageDetail});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        'Enter Product Image',
        style: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(95, 99, 119, 1),
            fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 12),
      Container(
        // height: MediaQuery.sizeOf(context).height * 0.14,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromRGBO(232, 255, 247, 0.3),
          border: const Border.fromBorderSide(BorderSide(
            color: Color.fromRGBO(0, 124, 130, 1.0),
          )),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onPressedCam,
              icon: Image.asset('assets/camera_icon.png'),
            ),
            const SizedBox(height: 6),
            const Text(
              'Take Photo',
              style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(0, 124, 130, 1)
                ,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            const Text(
              'Or',
              style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(95, 99, 119, 1),
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              buttonText: 'Choose from gallery',
              buttonWidth: 209,
              buttonFunction: onPressedGallery,
            ),
            const SizedBox(height: 20),
            imageDetail
          ],
        ),
      )
    ]);
  }
}

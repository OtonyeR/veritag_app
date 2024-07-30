import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:veritag_app/utils/constants.dart';
import 'package:veritag_app/utils/image_picker.dart';
import 'package:veritag_app/widgets/primary_button.dart';
import 'package:veritag_app/widgets/veritag_appbar.dart';

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
   _uuidController.text = const Uuid().v4();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VeritagAppbar(appbarTitle: 'Product Details', arrowBackRequired: true,),
      body: SafeArea(
        child: Column(
          children: [
            //const SizedBox(height: 52),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
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
                        ),
                        const SizedBox(height: 20),
                        FormField(
                          controller: _productNameController,
                          fieldTitle: 'Enter Product Name',
                          hintText: 'Eg. Broli Lotion',
                          readOnly: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the product name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        FormField(
                          fieldTitle: 'Manufacturer Name',
                          hintText: 'Eg. Your Company Name',
                          controller: _manufacturerNameController,
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
                        const SizedBox(height: 20),
                        FormField(
                          fieldTitle: 'Manufacturer Location',
                          hintText: 'Your Location',
                          controller: _manufacturerLocationController,
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enable location permissions';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        FormField(
                          fieldTitle: 'Manufacture Date',
                          hintText: 'hintText',
                          controller: _dateController,
                          readOnly: true,
                        ),
                        TextFormField(
                          controller: _manufacturerLocationController,
                          decoration: const InputDecoration(
                            labelText: 'Manufacture Date',
                            border: OutlineInputBorder(),
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
                        ImageField(
                          onPressedCam: () async {
                            final path = await getImagePath(ImageSource.camera);
                            setState(() {
                              imageDetailsList = path;
                            });
                          },
                          onPressedGallery: () async {
                            final path =
                                await getImagePath(ImageSource.gallery);
                            setState(() {
                              imageDetailsList = path;
                            });
                          },
                        ),
                       imageDetailsList?[0] == null
                            ? Container()
                            : Text('Image Selected: ${imageDetailsList?[0]}'),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.maxFinite,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                backgroundColor: const WidgetStatePropertyAll(
                                    Color.fromRGBO(0, 124, 130, 1.0))),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _submitForm();
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                color: colorBg,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
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
  String? Function(String?)? validator;

  FormField({
    super.key,
    required this.fieldTitle,
    required this.hintText,
    required this.controller,
    required this.readOnly,
    this.validator,
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
      const SizedBox(height: 12),
      TextFormField(
        controller: controller,
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
    ]);
  }
}

class ImageField extends StatelessWidget {
  final void Function()? onPressedCam;
  final void Function()? onPressedGallery;

  const ImageField(
      {super.key, required this.onPressedCam, required this.onPressedGallery});

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
        height: MediaQuery.sizeOf(context).height * 0.3,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 68),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromRGBO(232, 255, 247, 1),
          border: const Border.fromBorderSide(BorderSide(
            color: Color.fromRGBO(0, 124, 130, 1.0),
          )),
        ),
        child: Column(
          children: [
            IconButton(
              onPressed: onPressedCam,
              icon: Image.asset('assets/camera_icon.png'),
            ),
            const SizedBox(height: 12),
            const Text('Take Photo'),
            const SizedBox(height: 20),
            const Text(
              'Or',
              style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(95, 99, 119, 1),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              buttonText: 'Choose from gallery',
              buttonWidth: 209,
              buttonFunction: onPressedGallery,
            )
          ],
        ),
      ),
      //PrimaryButton(buttonText: 'buttonText', buttonFunction: buttonFunction, buttonWidth: buttonWidth)
    ]);
  }
}
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery); // or ImageSource.camera
  return pickedFile;
}

Future<String?> getImagePath() async {
  final imageFile = await pickImage(); // Await the Future
  return imageFile?.path; // Handle the possibility of imageFile being null
}

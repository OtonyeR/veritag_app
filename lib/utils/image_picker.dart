import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage(ImageSource source) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source); // or ImageSource.camera
  return pickedFile;
}

Future<String?> getImagePath(ImageSource source) async {
  final imageFile = await pickImage(source); // Await the Future
  return imageFile?.path; // Handle the possibility of imageFile being null
}

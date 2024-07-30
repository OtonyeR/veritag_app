import 'package:get/get.dart';

class VeriTagController extends GetxController {
  Rx<bool> isScanned = false.obs;
  Rx<String> resultMsg =
      'Put your device near the NFC Tag you want to write to'.obs;

      
}

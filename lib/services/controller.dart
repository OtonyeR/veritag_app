import 'package:get/get.dart';

class VeriTagController extends GetxController {
  Rx<bool> isScanned = false.obs;
  Rx<String> resultMsg =
      'Put your device near the NFC Tag you want to write to'.obs;
}

///CPNTROLLER FOR MANUFACTUE HOME SCREEN
class ManufaturerHomeController extends GetxController {
  Rx<bool> isScanned = false.obs;
  Rx<String> resultMsg =
      'Put your device near the NFC Tag you want to read'.obs;
}

///CPNTROLLER FOR MANUFACTUE HOME SCREEN
class ConsumerHomeController extends GetxController {
  Rx<bool> isScanned = false.obs;
  Rx<String> resultMsg =
      'Put your device near the NFC Tag you want to read'.obs;
}

///CPNTROLLER FOR MANUFACTUE HOME SCREEN
class BottomNavHomeController extends GetxController {
  Rx<bool> isScanned = false.obs;
  Rx<String> resultMsg =
      'Put your device near the NFC Tag you want to read'.obs;
}

///CPNTROLLER FOR MANUFACTUE HOME SCREEN
class BottomNavConsumerController extends GetxController {
  Rx<bool> isScanned = false.obs;
  Rx<String> resultMsg =
      'Put your device near the NFC Tag you want to read'.obs;
}

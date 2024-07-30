import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AppState {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;

  AppState._internal();

  bool onboardingCompleted = false;

  static AppState get instance => _instance;

  Future<void> loadAppState() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/onboarding_status.txt');

    if (await file.exists()) {
      onboardingCompleted = true;
    }
  }

  Future<void> completeOnboarding() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/onboarding_status.txt');
    await file.writeAsString('onboarding completed');
    onboardingCompleted = true;
  }
}

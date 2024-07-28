import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'views/onboarding_page.dart';
import 'package:provider/provider.dart';
import 'utils/onboarding_controller.dart';
import 'package:veritag_app/utils/bottom_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OnboardingController(),
        ),
      ],
      child: MaterialApp(
        title: 'VeriTag',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          }),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'onboarding',
        routes: {
          'onboarding': (context) => OnboardingScreen(),
          'bnav': (context) => const BottomNav(),
        },
      ),
    );
  }
}

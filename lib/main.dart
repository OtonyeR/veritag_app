import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veritag_app/utils/constants.dart';
import 'utils/app_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:veritag_app/firebase_options.dart';
import 'package:veritag_app/widgets/bottom_nav.dart';
import 'package:veritag_app/views/splashscreen.dart';
import 'package:veritag_app/views/router_screen.dart';
import 'package:veritag_app/views/onboarding_page.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppState.instance.loadAppState();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'VeriTag',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: colorPrimary),
            textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.light().textTheme.apply()),
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
            }),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: 'splashscreen',
          routes: {
            'splashscreen': (context) => const Splashscreen(),
            'onboarding': (context) => const OnboardingScreen(),
            'routing': (context) => const RouterScreen(),
            'bnav': (context) => const BottomNav(),
          },
        );
      },
    );
  }
}

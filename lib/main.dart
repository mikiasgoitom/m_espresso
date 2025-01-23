import 'dart:io';
import 'dart:ui';

import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:m_espresso_v1/ui/screens/auth_page.dart';
import 'package:m_espresso_v1/ui/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      tools: [
        ...DevicePreview.defaultTools,
        DevicePreviewScreenshot(
          onScreenshot: screenshotAsFiles(Directory('/home/mikia/Pictures/')),
        ),
      ],
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior()
          .copyWith(dragDevices: {PointerDeviceKind.mouse}),
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(useMaterial3: false),
      // home: const HomeScreen(),
      home: const AuthPage(),
    );
  }
}

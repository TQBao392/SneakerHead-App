import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';


Future<void> main() async {

  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  runApp(const App());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Responsive Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: DevicePreview.appBuilder,
      home: ResponsiveWrapper.builder(
        MyHomePage(title: 'Flutter Responsive Tutorial'),
        maxWidth: 1200,
        minWidth: 480,
        breakpoints: [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(480, name: TABLET),
        ],
      ),
    );
  }

import 'package:get/get.dart';
import 'package:quran_app/home.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/theme/theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/controller/constant.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await initialization(null);
  await GetStorage.init();
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  // await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await readJson();
      await getSettings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quran',
      theme: ThemeApp.Theme_App,
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        centered: true,
        duration: 2500,
        splashIconSize: 300,
        curve: Curves.easeInQuad,
        nextScreen: const Home(),
        splash: 'assets/logo_drawer.png',
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Color.fromRGBO(6, 87, 96, 1),
        splashTransition: SplashTransition.fadeTransition,
        animationDuration: const Duration(milliseconds: 3000),
      ),
    );
  }
}

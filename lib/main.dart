import 'package:background_fetch/background_fetch.dart';
import 'package:diabetes_care_taker/dashboard/medicationReminder/medicationReminderPage.dart';
import 'package:diabetes_care_taker/dashboard/insulinDose/insulinDosePageController.dart';
import 'package:diabetes_care_taker/dashboard/insulinDose/mealDoseCalulationPageController.dart';
import 'package:diabetes_care_taker/Home/homePage.dart';
import 'package:diabetes_care_taker/connection/ConnectionClass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:diabetes_care_taker/auth/loginScreen.dart';
import 'package:diabetes_care_taker/auth/signupScreen.dart';
import 'package:diabetes_care_taker/auth/splashScreen.dart';

void backgroundFetchHeadlessTask() async {
  showScheduleNotification();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  initPlatformState();
}

void initPlatformState() {
  BackgroundFetch.configure(
          BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: false,
            enableHeadless: true,
            startOnBoot: true,
          ),
          backgroundFetchHeadlessTask)
      .then((int status) {
    debugPrint('[Background Fetch] configure success: $status');
  }).catchError((e) {
    debugPrint('[Background Fetch] configure ERROR: $e');
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    super.initState();
    ConnectionClass().connection_function();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => insulinDosePageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => mealDoseCalculationPageController(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Diabetes Care Taker',
        theme: ThemeData(
          textTheme: const TextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 5, 65, 114),
          ),
          useMaterial3: false,
        ),
        home: user != null ? const homePage() : splashScreen(),
        routes: {
          '/splashscreen': (context) => splashScreen(),
          '/login': (context) => loginScreen(),
          '/signup': (context) => signupScreen(),
          '/home': (context) => const homePage(),
        },
      ),
    );
  }
}

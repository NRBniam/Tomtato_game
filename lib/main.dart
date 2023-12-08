import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/UIs/HomeLogin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

void main() async {
  // Ensure that Flutter is initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase before running the app.
  await Firebase.initializeApp();

  // Run the app within the Riverpod ProviderScope.
  runApp(ProviderScope(child: QuizApp()));
}

// Starting/home page of the program.
class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Set the initial home page to LoginPage.
      home: LoginPage(),
      // Disable the debug banner in release mode.
      debugShowCheckedModeBanner: false,
    );
  }
}

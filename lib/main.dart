// ignore_for_file: non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lib_manage/Homepage/Homepage.dart';
import 'package:lib_manage/User_Access/login.dart';
import 'package:lib_manage/Welcome/Welcome.dart';
import 'package:lib_manage/Widgets/widgets.dart';
import 'package:lib_manage/test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Widgets/boom_menu.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  } catch (e) {
    print('Error during Firebase initialization: $e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: _isLoggedIn ? HomePage() : LogIn(),
      home: WelcomePage(),
    );
  }
}

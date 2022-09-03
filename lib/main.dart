import 'dart:developer';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:megnetoo_live/pages/home.dart';
import 'package:megnetoo_live/pages/new_user.dart';
import 'package:megnetoo_live/providers/app_provider.dart';
import 'package:megnetoo_live/providers/magnitude_provider.dart';
import 'package:megnetoo_live/utils/helpers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isNew = true;

  setup() async {
    log("setting up is first time or not");
    await SharedPreferences.getInstance().then((value) {
      isNew = value.getBool("isFirstTime") ?? true;
      log("value is $isNew");
      setState((){});
    });
  }

  @override
  void initState() {
    setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MagnitudeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppProvider(),
        ),
      ],
      child: ThemeProvider(
        initTheme: lightTheme,
        builder: (context, myTheme) {
          return MaterialApp(
            title: "live emf detection",
            home: isNew ? const NewUser() : const MyHomePage(),
          );
        },
      ),
    );
  }
}

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:megnetoo_live/pages/splash.dart';
import 'package:megnetoo_live/providers/app_provider.dart';
import 'package:megnetoo_live/providers/magnitude_provider.dart';
import 'package:megnetoo_live/utils/helpers.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Live emf detection",
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}

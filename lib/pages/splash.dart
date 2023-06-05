import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'new_user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isNew = true;

  setup() async {
    await SharedPreferences.getInstance().then((value) {
      isNew = value.getBool("isFirstTime") ?? true;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => isNew ? const NewUser() : const MyHomePage()));
    });
  }

  @override
  void initState() {
    setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .brightness == Brightness.dark
          ? const Color(0xff7ca9f2)
          : const Color(0xff1f2a3b),
      body: Center(
        child: Image.asset("assets/logo.png", width: 150, height: 150,),
      ),
    );
  }
}

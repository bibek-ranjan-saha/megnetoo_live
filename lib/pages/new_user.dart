import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:megnetoo_live/widgets/animated_gradient.dart';
import 'package:megnetoo_live/widgets/animated_textt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  List<String> wordList =
      "Welcome to the magnetoo-live ... see and measure emf around you in realtime"
          .split(" ");
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedGradient(),
          AnimatedScale(
            scale: isDone ? 2 : 1,
            duration: const Duration(seconds: 1),
            child: AnimatedText(
              wordList: wordList,
              alignment: Alignment.center,
              speed: const Duration(milliseconds: 1000),
              controller: AnimatedTextController.restart,
              displayTime: const Duration(milliseconds: 1000),
              repeatCount: 0,
              onFinished: () {
                wordList = [" ", "Let's go"];
                isDone = true;
                setState(() {});
              },
              textStyle: const TextStyle(
                  color: Colors.white70,
                  fontSize: 55,
                  fontWeight: FontWeight.w700),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: isDone ? 1 : 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey.shade200.withOpacity(0.2),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          minimumSize: const Size(double.infinity, 50)),
                      onPressed: () async {
                        await SharedPreferences.getInstance().then((value) {
                          value.setBool("isFirstTime", false);
                        });
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) => const MyHomePage()),
                            (route) => false);
                      },
                      child: const Text(
                        "continue",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

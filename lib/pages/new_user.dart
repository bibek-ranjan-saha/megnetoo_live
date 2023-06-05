import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swipe_deck/swipe_deck.dart';

import '../widgets/welcome_card.dart';
import 'home.dart';

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  bool isDone = false;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xff7ca9f2)
          : const Color(0xff1f2a3b),
      appBar: AppBar(
        leading: TextButton(
          onPressed: () async {
            await SharedPreferences.getInstance().then((value) {
              value.setBool("isFirstTime", false);
            });
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const MyHomePage()),
                  (route) => false);
            }
          },
          child: const Text("SKIP"),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Welcome to Magneto live,where you can measure emf near you in real-time",
              style: TextStyle(
                  color: Theme.of(context).brightness != Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          ),
          SwipeDeck(
              widgets: const [
                WelcomeCard(
                  title: 'Quick and easy to use',
                  icon: Icons.double_arrow_rounded,
                ),
                WelcomeCard(
                  title: 'Fully secure no internet usage',
                  icon: Icons.security_rounded,
                ),
                WelcomeCard(
                  title: 'Very small size app and useful',
                  icon: Icons.photo_size_select_small,
                ),
                WelcomeCard(
                  title: 'Supports dark and light theming',
                  icon: Icons.dark_mode_rounded,
                ),
              ],
              onChange: (newIndex) {
                currentIndex = newIndex;
                if (currentIndex == 3) {
                  isDone = true;
                }
                setState(() {
                  currentIndex++;
                });
              }),
          if (!isDone)
            AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: 4,
              effect: const SwapEffect(),
            ),
          if (isDone)
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  minimumSize: Size(size.width * 0.8, 50),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              onPressed: () async {
                await SharedPreferences.getInstance().then((value) {
                  value.setBool("isFirstTime", false);
                });
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const MyHomePage()),
                      (route) => false);
                }
              },
              child: Text(
                isDone ? "continue" : "next",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
    );
  }
}

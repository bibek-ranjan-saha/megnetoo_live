import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/colors.dart';

class WelcomeCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const WelcomeCard({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              colors: gradients.elementAt(Random().nextInt(gradients.length)))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              size: 100,
              color: Colors.white70,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white60),
            )
          ],
        ),
      ),
    );
  }
}
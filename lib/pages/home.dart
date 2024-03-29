import 'dart:ui';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../providers/app_provider.dart';
import '../providers/magnitude_provider.dart';
import '../widgets/dialog.dart';
import 'full_visualizer.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ThemeSwitchingArea(
      child: Builder(
        builder: (themeContext) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  showGeneralDialog(
                    barrierDismissible: true,
                    barrierLabel: '',
                    barrierColor: Colors.black38,
                    transitionDuration: const Duration(milliseconds: 160),
                    pageBuilder: (ctx, anim1, anim2) => const AboutMeDialog(),
                    transitionBuilder: (ctx, anim1, anim2, child) =>
                        BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 10 * anim1.value, sigmaY: 10 * anim1.value),
                      child: ScaleTransition(
                        scale: anim1,
                        child: child,
                      ),
                    ),
                    context: context,
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: const Icon(Icons.account_box_outlined),
                ),
              ),
              actions: [
                Consumer<AppProvider>(builder: (context, model, child) {
                  return ThemeSwitcher(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SizedBox(
                        height: 45,
                        width: 45,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: DayNightSwitcherIcon(
                            isDarkModeEnabled: model.isDarkMode,
                            onStateChanged: (isDarkModeEnabled) {
                              model.changeTheme(context);
                            },
                          ),
                        ),
                      ),
                    );
                  });
                })
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  width: size.height * 0.01,
                ),
                Consumer<MagnitudeProvider>(
                  builder: (context, model, child) => AnimatedFlipCounter(
                    value: model.magnitude,
                    fractionDigits: 2,
                    suffix: " µ Tesla",
                    curve: Curves.bounceInOut,
                    textStyle: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  "Update Interval",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Consumer<MagnitudeProvider>(
                  builder: (context, model, child) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: model.groupValue,
                                onChanged: (value) => model.setUpdateInterval(
                                    1, Duration.microsecondsPerSecond ~/ 1)),
                            const Text(
                              "1 FPS",
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 2,
                                groupValue: model.groupValue,
                                onChanged: (value) => model.setUpdateInterval(
                                    2, Duration.microsecondsPerSecond ~/ 30)),
                            const Text(
                              "30 FPS",
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 3,
                                groupValue: model.groupValue,
                                onChanged: (value) => model.setUpdateInterval(
                                    3, Duration.microsecondsPerSecond ~/ 60)),
                            const Text(
                              "60 FPS",
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<MagnitudeProvider>(
                  builder: (context, model, child) => Tooltip(
                    message: "xyz values from magneto meter sensor",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "X : ${model.x.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Colors.tealAccent.shade700,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Y : ${model.y.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Colors.tealAccent.shade700,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Z : ${model.z.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Colors.tealAccent.shade700,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Consumer<MagnitudeProvider>(
                    builder: (context, model, child) => SfRadialGauge(
                      enableLoadingAnimation: true,
                      axes: <RadialAxis>[
                        RadialAxis(
                            minimum: 0,
                            maximum: 1000,
                            labelOffset: 20,
                            tickOffset: 20,
                            useRangeColorForAxis: true,
                            ranges: <GaugeRange>[
                              GaugeRange(
                                startValue: 0,
                                endValue: 200,
                                color: Colors.green,
                                label: 'SAFE',
                                startWidth: 25,
                                endWidth: 25,
                                labelStyle: const GaugeTextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              GaugeRange(
                                startValue: 200,
                                endValue: 500,
                                color: Colors.orange,
                                label: 'MODERATE',
                                startWidth: 25,
                                endWidth: 25,
                                labelStyle: const GaugeTextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              GaugeRange(
                                startValue: 500,
                                endValue: 1000,
                                color: Colors.red,
                                label: 'DANGER',
                                startWidth: 25,
                                endWidth: 25,
                                labelStyle: const GaugeTextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(
                                lengthUnit: GaugeSizeUnit.factor,
                                value: model.magnitude,
                                animationDuration: 276,
                                enableAnimation: true,
                                enableDragging: false,
                                knobStyle: const KnobStyle(
                                    knobRadius: 0.08,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    color: Colors.black),
                                tailStyle: const TailStyle(
                                  length: 0.2,
                                  width: 8,
                                  gradient: LinearGradient(colors: <Color>[
                                    Color(0xFFFF6B78),
                                    Color(0xFFFF6B78),
                                    Color(0xFFE20A22),
                                    Color(0xFFE20A22)
                                  ], stops: <double>[
                                    0,
                                    0.5,
                                    0.5,
                                    1
                                  ]),
                                ),
                                gradient: const LinearGradient(colors: <Color>[
                                  Color(0xFFFF6B78),
                                  Color(0xFFFF6B78),
                                  Color(0xFFE20A22),
                                  Color(0xFFE20A22)
                                ], stops: <double>[
                                  0,
                                  0.5,
                                  0.5,
                                  1
                                ]),
                                needleColor: const Color(0xFFF67280),
                                needleLength: 0.8,
                                needleEndWidth: 8,
                                animationType: AnimationType.elasticOut,
                              )
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  widget: Text(
                                      model.magnitude.toStringAsFixed(2),
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  angle: 90,
                                  positionFactor: 0.5)
                            ])
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Consumer<MagnitudeProvider>(
                  builder: (context, model, child) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34.0),
                    child: OutlinedButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        model.changeValues();
                      },
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: model.isListening
                              ? Colors.blueGrey
                              : Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          )),
                      child: Text(
                        model.isListening ? "Stop" : "Start",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34.0),
                  child: Hero(
                    tag: "full",
                    child: OutlinedButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const FullVisualizer()));
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.white54),
                      child: const Text(
                        "see all data",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

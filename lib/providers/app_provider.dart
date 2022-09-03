import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/helpers.dart';

class AppProvider extends ChangeNotifier {

  bool isDarkModeEnabled = false;

  changeTheme(BuildContext context) {
    HapticFeedback.selectionClick();
    isDarkModeEnabled = !isDarkModeEnabled;
    ThemeSwitcher.of(context).changeTheme(
        theme: isDarkModeEnabled ? darkTheme : lightTheme,
        isReversed: isDarkModeEnabled);
    notifyListeners();
  }
}

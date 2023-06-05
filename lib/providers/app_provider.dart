import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/helpers.dart';

class AppProvider extends ChangeNotifier {
  bool _isDarkModeEnabled = false;

  bool get isDarkMode => _isDarkModeEnabled;

  void changeTheme(BuildContext context) {
    HapticFeedback.selectionClick();
    _isDarkModeEnabled = !_isDarkModeEnabled;
    ThemeSwitcher.of(context).changeTheme(
      theme: _isDarkModeEnabled ? darkTheme : lightTheme,
      isReversed: _isDarkModeEnabled,
    );
    notifyListeners();
  }
}

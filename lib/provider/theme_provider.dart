import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const themeStatus = 'themeStatus';

  bool _isdarkTheme = false;
  bool get isDarkTheme => _isdarkTheme;

  ThemeProvider() {
    getTheme();
  }

  Future<void> setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeStatus, value);
    _isdarkTheme = value;
    notifyListeners();
  }

  Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isdarkTheme = prefs.getBool(themeStatus) ?? false;
    notifyListeners();
  }
}

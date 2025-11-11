import 'package:flutter/material.dart';


/// Tema modunu yönetmek için ChangeNotifier tabanlı bir sınıf.
class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;
  
  bool get isDarkMode => _isDarkMode;
  
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
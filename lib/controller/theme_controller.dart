import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;
  final _box = Hive.box('settings');
  final _key = 'isDarkMode';

  @override
  void onInit() {
    isDarkMode.value = _loadThemeFromHive();
    super.onInit();
  }

  bool _loadThemeFromHive() => _box.get(_key, defaultValue: false);

  void _saveThemeToHive(bool isDarkMode) => _box.put(_key, isDarkMode);

  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _saveThemeToHive(isDarkMode.value);
  }
}

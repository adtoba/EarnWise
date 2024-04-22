import 'package:earnwise/src/core/constants/prefs.dart';
import 'package:earnwise/src/core/services/storage_service.dart';
import 'package:earnwise/src/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final themeProvider = ChangeNotifierProvider<ThemeProvider>((ref) {
  return ThemeProvider(ref);
});


class ThemeProvider extends ChangeNotifier {

  final ChangeNotifierProviderRef ref;

  ThemeProvider(this.ref);

  ThemeProvider get() {
    return ref.watch(themeProvider);
  }

  ThemeMode? _currentThemeMode = ThemeMode.system;
  ThemeMode? get currentThemeMode => _currentThemeMode;

  ThemeData? _currentTheme;
  ThemeData? get currentTheme => _currentTheme;

  Future<ThemeMode?> initTheme() async {
    String? theme = await LocalStorage.get(SharedPrefs.currentTheme);

    if(theme == "dark") {
      _currentThemeMode = ThemeMode.dark;
      _currentTheme = AppTheme.darkTheme;
      await LocalStorage.put(SharedPrefs.currentTheme, "dark");
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ));
      notifyListeners();
    } else if(theme == "light") {
      _currentThemeMode = ThemeMode.light;
      _currentTheme = AppTheme.lightTheme;
      await LocalStorage.put(SharedPrefs.currentTheme, "light");
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ));
      notifyListeners();
    } else if(theme == "system") {
      _currentThemeMode = ThemeMode.system;
      await LocalStorage.put(SharedPrefs.currentTheme, "system");
      notifyListeners();
    } else if(theme == null) {
      _currentThemeMode = ThemeMode.dark;
      _currentTheme = AppTheme.darkTheme;
      await LocalStorage.put(SharedPrefs.currentTheme, "dark");
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ));
      notifyListeners();
    }

    return _currentThemeMode;
  }

  void setDarkMode() async {
    _currentThemeMode = ThemeMode.dark;
    _currentTheme = AppTheme.darkTheme;
    await LocalStorage.put(SharedPrefs.currentTheme, "dark");
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ));
    notifyListeners();
  }

  void setLightMode() async {
    _currentThemeMode = ThemeMode.light;
    _currentTheme = AppTheme.lightTheme;
    await LocalStorage.put(SharedPrefs.currentTheme, "light");
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ));
    notifyListeners();
  }

  void setSystem(BuildContext context) async {
    _currentThemeMode = ThemeMode.system;
    if(MediaQuery.of(context).platformBrightness == Brightness.dark) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ));
    }
    await LocalStorage.put(SharedPrefs.currentTheme, "system");
    notifyListeners();
  }

}
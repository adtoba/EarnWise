import 'package:earnwise/src/core/providers/theme_provider.dart';
import 'package:earnwise/src/features/auth/screens/login_screen.dart';
import 'package:earnwise/src/styles/theme.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var themeState = ref.watch(themeProvider);
    return MaterialApp(
      title: 'EarnWise',
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: themeState.currentThemeMode,
      home: Builder(
        builder: (context) {
          ref.read(themeProvider).initTheme();
          SizeConfig.init(context);
          return const LoginScreen();
        }
      )
    );
  }
}
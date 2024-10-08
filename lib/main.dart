import 'package:bot_toast/bot_toast.dart';
import 'package:earnwise/src/core/providers/theme_provider.dart';
import 'package:earnwise/src/features/onboarding/screens/splash_screen.dart';
import 'package:earnwise/src/styles/theme.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox("app_data");
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(themeProvider).initTheme();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themeState = ref.watch(themeProvider);
    return StyledToast(
      locale: const Locale('en', 'US'),
      child: MaterialApp(
        title: 'EarnWise',
        navigatorKey: navigatorKey,
        builder: BotToastInit(),
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        themeMode: themeState.currentThemeMode,
        // themeMode: ThemeMode.light,
        home: Builder(
          builder: (context) {
            SizeConfig.init(context);
            return const SplashScreen();
          }
        )
      ),
    );
  }
}
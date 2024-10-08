import 'dart:async';

import 'package:earnwise/src/core/constants/prefs.dart';
import 'package:earnwise/src/core/services/storage_service.dart';
import 'package:earnwise/src/features/auth/screens/login_screen.dart';
import 'package:earnwise/src/features/dashboard/screens/dashboard.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  late bool _visible = false;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _visible = true;
      });
    });

    Timer(const Duration(seconds: 5), () async {
      String? token = await LocalStorage.get(SharedPrefs.userToken);
      if(token != null) {
        pushAndRemoveUntil(const DashboardScreen());
      } else {
        pushAndRemoveUntil(const LoginScreen());
      }
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(seconds: 2),
          child: Text(
            "EarnWise",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: config.sp(50),
              fontFamily: GoogleFonts.raleway().fontFamily
            ),
          )
        ),
      ),
    );
  }
}
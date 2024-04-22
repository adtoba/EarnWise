import 'dart:async';

import 'package:earnwise/src/features/auth/screens/login_screen.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      push(const LoginScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
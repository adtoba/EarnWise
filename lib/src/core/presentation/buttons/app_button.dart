import 'package:earnwise/src/styles/palette.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:flutter/material.dart';


class AppButton extends StatelessWidget {
  const AppButton({ super.key, required this.text, this.onPressed, this.enabled = true, this.color});

  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {

    return MaterialButton(
      minWidth: double.infinity,
      height: config.sh(50),
      onPressed: enabled! ? onPressed : null,
      color: color ?? const Color(0xff481F9F),
      disabledColor: Palette.primary.withOpacity(.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: config.sp(16),
          fontWeight: FontWeight.bold,
          color: enabled! ? Colors.white : Colors.white38
        ),
      ),
    );
  }
}
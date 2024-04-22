import 'package:earnwise/src/styles/palette.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:flutter/material.dart';


class AppButton extends StatelessWidget {
  const AppButton({ super.key, required this.text, this.onPressed, this.enabled = true});

  final String text;
  final VoidCallback? onPressed;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {

    return MaterialButton(
      minWidth: double.infinity,
      height: config.sh(50),
      onPressed: enabled! ? onPressed : null,
      color: Palette.darkPurple,
      disabledColor: Palette.primary.withOpacity(.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: config.sp(14),
          fontWeight: FontWeight.normal,
          color: enabled! ? Colors.white : Colors.white38
        ),
      ),
    );
  }
}
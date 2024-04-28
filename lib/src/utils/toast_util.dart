import 'package:bot_toast/bot_toast.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:flutter/material.dart';

class ToastUtil {
  static showError({String? message}) {
    BotToast.showCustomNotification(
      duration: const Duration(seconds: 3),
      backButtonBehavior: BackButtonBehavior.close,
      onClose: () {},
      toastBuilder: (_) {
        return Container(
          width: config.sw(600),
          height: config.sh(30),
          color: Colors.red,
          padding: EdgeInsets.symmetric(vertical: config.sh(5), horizontal: config.sw(10)),
          child: Text(
            message!,
            style: TextStyle(
              color: Colors.white,
              fontSize: config.sp(14)
            ),
          ),
        );
      }
    );
  }
}
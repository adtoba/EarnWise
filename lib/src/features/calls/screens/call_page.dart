import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

String userID = Random().nextInt(10000).toString();

class CallPage extends StatelessWidget {
  const CallPage({super.key, this.userId, this.callId});

  final String? userId;
  final String? callId;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1728949329,
      appSign: "2584e9d041dbf572a868ca5a42c5b4ea145cb2eb71f0ca756d4170549b4d10af",
      userID: userId!,
      userName: "user_$userId",
      callID: callId!,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}
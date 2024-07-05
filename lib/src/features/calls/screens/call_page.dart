import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

String userID = Random().nextInt(10000).toString();

class CallPage extends StatelessWidget {
  const CallPage({super.key, this.userId, this.callId, this.userName});

  final String? userId;
  final String? callId;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 509158382,
      appSign: "5652baa9a9f6e04937fcdab44d604ba84e986de820ab247d34be837d474ded74",
      userID: userId!,
      userName: userName!,
      callID: callId!,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}
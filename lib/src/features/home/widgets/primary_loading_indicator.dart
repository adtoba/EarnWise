import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryLoadingIndicator extends StatelessWidget {
  const PrimaryLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CupertinoActivityIndicator(),
        )
      );
    } else {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        )
      );
    }
  }
}
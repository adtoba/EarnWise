import 'package:earnwise/main.dart';
import 'package:flutter/material.dart';

push(Widget page) {
  navigatorKey.currentState!.push(MaterialPageRoute(builder: (ctx) {
    return page;
  }));
}

pushAndReplace(Widget page) {
  navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (ctx) {
    return page;
  }));
}

pushAndRemoveUntil(Widget page) {
  navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
    return page;
  }), (route) => false);
}

pop() {
  navigatorKey.currentState!.pop();
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardProvider = ChangeNotifierProvider<DashboardProvider>((ref) {
  return DashboardProvider();
});

class DashboardProvider extends ChangeNotifier {
  final controller = PageController(
    keepPage: true,
    initialPage: 0
  );

  int currentIndex = 0;

  void onPageChanged(int index) {
    currentIndex = index;    
    notifyListeners();
  
    controller.jumpToPage(index);
  }
}
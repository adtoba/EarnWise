import 'package:earnwise/src/features/calls/screens/calls_screen.dart';
import 'package:earnwise/src/features/dashboard/view_model/dashboard_provider.dart';
import 'package:earnwise/src/features/home/screens/home_screen.dart';
import 'package:earnwise/src/features/notification/screens/notifications_screen.dart';
import 'package:earnwise/src/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    var dashboardState = ref.watch(dashboardProvider);

    return Scaffold(
      body: PageView(
        controller: dashboardState.controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: dashboardState.onPageChanged,
        children: const [
          HomeScreen(),
          CallsScreen(),
          NotificationScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: dashboardState.onPageChanged,
        currentIndex: dashboardState.currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore, size: 30,),
            label: "Explore"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call, size: 30,),
            label: "Calls"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, size: 30),
            label: "Notifications"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30,),
            label: "Profile"
          )
        ],
      ),
    );
  }
}
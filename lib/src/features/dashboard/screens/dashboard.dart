import 'package:earnwise/src/features/dashboard/view_model/dashboard_provider.dart';
import 'package:earnwise/src/features/home/screens/home_screen.dart';
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
        onPageChanged: dashboardState.onPageChanged,
        children: const [
          HomeScreen()
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
            icon: Icon(Icons.chat_bubble_outline, size: 30),
            label: "Messages"
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
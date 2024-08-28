import 'package:backend/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';
import 'package:zonin/colors.dart';
import 'package:zonin/screens/analytics_screen.dart';
import 'package:zonin/screens/home_screen.dart';
import 'package:zonin/state/auth/auth_cubit.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen(this.user, {super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.red,
        title: Row(
          children: [
            const SizedBox(width: 10),
            Image.asset(
              'assets/logo.png',
              scale: 7,
            ),
            const SizedBox(width: 10),
            const Text(
              'Zonin',
              style: TextStyle(color: accentBlue2, fontFamily: 'Caros Soft'),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                },
                icon: const Icon(
                  CupertinoIcons.square_arrow_right,
                  size: 33,
                  color: accentPurple,
                )),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int idx) {
          setState(() {
            currentPageIndex = idx;
          });
        },
        indicatorColor: Colors.transparent,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined, size: 40, color: Color(0xFF79747E)),
            selectedIcon: Icon(Icons.home_outlined, size: 40, color: accentPurple2),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart, size: 40, color: Color(0xFF79747E)),
            selectedIcon: Icon(Icons.bar_chart, size: 40, color: accentPurple2),
            label: 'Analytics',
          ),
        ],
      ),
      body: <Widget>[
        HomeScreen(widget.user),
        AnalyticsScreen(widget.user),
      ][currentPageIndex],
    );
  }
}

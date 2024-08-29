import 'package:backend/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zonin/colors.dart';
import 'package:zonin/screens/views/activities_view.dart';
import 'package:zonin/state/activity/activity_bloc.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen(this.user, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loading = !context.read<ActivityBloc>().loaded;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActivityBloc, ActivityState>(
      listener: (context, state) {
        if (state is ActivityLoadSuccess) {
          setState(() {
            _loading = false;
          });
        }
      },
      child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Timer Icon
                  const Expanded(
                      child: Row(
                    children: [
                      Spacer(),
                      Icon(
                        Icons.timer_outlined,
                        color: accentPurple,
                        size: 35,
                      ),
                    ],
                  )),
                  // Accumulated Daily Time
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      '08h 45m',
                      style: TextStyle(
                        fontFamily: 'Caros Soft',
                        fontSize: 30,
                        color: textColour,
                      ),
                    ),
                  ),
                  // Percentage Change Widget
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFF43EA60).withAlpha(80),
                          ),
                          child: const Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  children: [
                                    Icon(Icons.keyboard_arrow_up,
                                        color: Color(0xFF00FF29), size: 25),
                                    Text('5.3%',
                                        style: TextStyle(color: Color(0xFF00FF29), fontSize: 13)),
                                  ],
                                ),
                              )),
                        ),
                        const Spacer(),
                      ],
                    ),
                  )
                ],
              ),
              bottom: const TabBar(
                indicatorPadding: EdgeInsets.symmetric(vertical: 10),
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStatePropertyAll(Colors.transparent),
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('Activities'),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('Goals'),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _loading
                    ? const Center(
                        child: SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(),
                      ))
                    : const ActivitiesView(),
                const Placeholder(),
              ],
            ),
          )),
    );
  }
}

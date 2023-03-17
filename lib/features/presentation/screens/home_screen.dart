import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:my_daily_tasks/app_const.dart';
import 'package:my_daily_tasks/features/presentation/cubit/task_cubit.dart';
import 'package:my_daily_tasks/features/presentation/pages/complete_task_page.dart';
import 'package:my_daily_tasks/features/presentation/pages/home_page.dart';
import 'package:my_daily_tasks/features/presentation/widgets/theme/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final iconList = <IconData>[
    FontAwesome.home,
    FontAwesome.tasks,
  ];
  int _pageNavIndex = 0;
  List<Widget> get _pages => [
        const HomePage(),
        const CompleteTaskPage(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            PageConst.addNewTaskPage,
          ).then((value) {
            BlocProvider.of<TaskCubit>(context).getAllTask();
          });
        },
        elevation: 8,
        backgroundColor: colorC80863,
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomNavBar(),
      body: _pages[_pageNavIndex],
    );
  }

  Widget _bottomNavBar() {
    return AnimatedBottomNavigationBar(
      leftCornerRadius: 50,
      rightCornerRadius: 50,
      notchSmoothness: NotchSmoothness.smoothEdge,
      activeColor: color6FADE4,
      gapLocation: GapLocation.center,
      icons: iconList,
      activeIndex: _pageNavIndex,
      onTap: (index) {
        setState(() {
          _pageNavIndex = index;
        });
      },
    );
  }
}

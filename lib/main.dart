import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daily_tasks/features/presentation/cubit/task_cubit.dart';
import 'package:my_daily_tasks/features/presentation/screens/home_screen.dart';
import 'package:my_daily_tasks/on_generate_route.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCubit>(
      create: (_) => di.sl<TaskCubit>()
        ..openDatabase()
        ..initNotification(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Daily Tasks',
        theme: ThemeData(
          primaryColor: Colors.indigoAccent,
        ),
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          '/': (context) {
            return const HomeScreen();
          }
        },
      ),
    );
  }
}

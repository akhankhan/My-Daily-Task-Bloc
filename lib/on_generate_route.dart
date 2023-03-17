import 'package:flutter/material.dart';
import 'app_const.dart';
import 'features/presentation/pages/add_new_task.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.addNewTaskPage:
        {
          return materialBuilder(widget: const AddNewTask());
        }
      default:
        return materialBuilder(
          widget: const ErrorPage(),
        );
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("error"),
      ),
      body: const Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}

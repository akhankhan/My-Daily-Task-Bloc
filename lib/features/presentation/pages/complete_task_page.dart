import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_daily_tasks/features/domain/enitites/task_entity.dart';
import 'package:my_daily_tasks/features/presentation/cubit/task_cubit.dart';
import 'package:my_daily_tasks/features/presentation/widgets/common.dart';
import 'package:my_daily_tasks/features/presentation/widgets/theme/style.dart';

class CompleteTaskPage extends StatefulWidget {
  const CompleteTaskPage({super.key});

  @override
  State<CompleteTaskPage> createState() => _CompleteTaskPageState();
}

class _CompleteTaskPageState extends State<CompleteTaskPage> {
  List<TaskEntity> _taskData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadedState) {
            final completeTask = state.taskData
                .where((element) => element.isCompleteTask == true)
                .toList();
            return Column(
              children: [
                _headerWidget(completeTask),
                completeTask.isEmpty && _taskData.isEmpty
                    ? Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 70,
                                    child: Opacity(
                                        opacity: .5,
                                        child:
                                            Image.asset("assets/tasks.png"))),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "You do not have any task",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(.4)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : _listTaskWidget(
                        _taskData.isEmpty ? completeTask : _taskData),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _listTaskWidget(List<TaskEntity> task) {
    return Expanded(
      child: ListView.builder(
        itemCount: task.length,
        itemBuilder: (_, index) {
          return _listItem(task[index]);
        },
      ),
    );
  }

  _listItem(TaskEntity task) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          AwesomeDialog(
            context: context,
            borderSide: BorderSide(color: taskTypeListColor[0], width: 2),
            width: 280,
            buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
            headerAnimationLoop: true,
            animType: AnimType.TOPSLIDE,
            title: '${task.title}',
            desc:
                '${task.title}\n${DateFormat("hh:mm a").format(DateTime.parse(task.time!))}',
            showCloseIcon: false,
            dialogType: DialogType.INFO,
            btnOkOnPress: () {},
          ).show();
        },
        child: Card(
          elevation: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 4,
                    decoration: BoxDecoration(
                        color: taskTypeListColor[task.colorIndex!],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8))),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: true == false ? Colors.white : Colors.green,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                        border: Border.all(color: Colors.grey)),
                    child: true == false
                        ? const Icon(
                            Icons.done,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat("hh:mm a").format(DateTime.parse(task.time!)),
                    style: TextStyle(color: Colors.black.withOpacity(.4)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2.1,
                      child: Text(
                        '${task.title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black,
                            decoration: true == false
                                ? TextDecoration.none
                                : TextDecoration.lineThrough),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _headerWidget(List<TaskEntity> task) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.indigo,
          color6FADE4,
        ], end: Alignment.topLeft, begin: Alignment.topRight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Complete Tasks",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    // ${task.length}
                    Text(
                      "You have Completed  tasks",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(.8),
                      ),
                    ),
                  ],
                ),
                PopupMenuButton<String>(
                  itemBuilder: (_) => taskTypeList.map((value) {
                    return PopupMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onSelected: (String value) {
                    setState(() {
                      if (value == "Other") {
                        _taskData = task;
                      } else {
                        _taskData = task
                            .where((element) => element.taskType == value)
                            .toList();
                      }
                    });
                  },
                  child: const Icon(
                    Icons.filter_list_outlined,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

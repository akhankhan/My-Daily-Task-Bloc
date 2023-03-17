import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:my_daily_tasks/features/domain/enitites/task_entity.dart';
import 'package:my_daily_tasks/features/presentation/cubit/task_cubit.dart';
import 'package:my_daily_tasks/features/presentation/widgets/common.dart';
import 'package:my_daily_tasks/features/presentation/widgets/theme/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TaskEntity> _taskData = [];

  @override
  void initState() {
    BlocProvider.of<TaskCubit>(context).getAllTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadedState) {
            return _bodyWidget(state.taskData);
            // } else if (state is TaskLoadingState) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
          } else if (state is TaskFailureState) {
            log('Error');
          }
          // return Container();
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _bodyWidget(List<TaskEntity> taskData) {
    return Column(
      children: [
        _headerWidget(taskData),
        taskData.isEmpty && _taskData.isEmpty
            ? SizedBox(
                height: 250,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 70,
                          child: Opacity(
                              opacity: .5,
                              child: Image.asset("assets/tasks.png"))),
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
              )
            : _listTaskWidget(_taskData.isEmpty ? taskData : _taskData),
      ],
    );
  }

  _headerWidget(List<TaskEntity> taskData) {
    return Container(
      height: 250,
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
                      "My Daily Tasks",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    //${taskData.length}
                    Text(
                      "Today you have ${taskData.length} task",
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
                        _taskData = taskData;
                      } else {
                        _taskData = taskData
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
          _currentTaskWidget(taskData),
        ],
      ),
    );
  }

  _currentTaskWidget(List<TaskEntity> taskData) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.white.withOpacity(.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Today Reminder",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                taskData.isEmpty ? "Title" : "${taskData.last.title}",
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                taskData.isEmpty
                    ? ""
                    : DateFormat("hh:mm a")
                        .format(DateTime.parse(taskData.last.time!)),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 60, child: Image.asset('assets/bell_icon.png')),
        ],
      ),
    );
  }

  _listTaskWidget(List<TaskEntity> taskData) {
    return Expanded(
      child: ListView.builder(
        itemCount: taskData.length,
        itemBuilder: (_, index) {
          return _listItem(taskData[index]);
        },
      ),
    );
  }

  _listItem(TaskEntity task) {
    return Slidable(
      key: ValueKey(task.id),
      enabled: true,
      closeOnScroll: true,
      endActionPane: ActionPane(
        key: ValueKey(task.id),
        motion: const ScrollMotion(),
        // dismissible: DismissiblePane(onDismissed: () {
        //   BlocProvider.of<TaskCubit>(context)
        //       .deleteTask(task: task)
        //       .then((value) {
        //     Future.delayed(const Duration(seconds: 2), () {
        //       BlocProvider.of<TaskCubit>(context).getAllTask();
        //     });
        //   });
        // }),
        children: [
          SlidableAction(
            key: ValueKey(task.id),
            onPressed: (_) {
              BlocProvider.of<TaskCubit>(context)
                  .deleteTask(task: task)
                  .then((value) {
                Future.delayed(const Duration(seconds: 1), () {
                  BlocProvider.of<TaskCubit>(context).getAllTask();
                });
              });
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
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
                    InkWell(
                      onTap: () {
                        BlocProvider.of<TaskCubit>(context)
                            .updateTask(task: task)
                            .then((value) {
                          Future.delayed(const Duration(seconds: 1), () {
                            BlocProvider.of<TaskCubit>(context).getAllTask();
                          });
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: task.isCompleteTask == false
                                ? Colors.white
                                : Colors.green,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(40),
                            ),
                            border: Border.all(color: Colors.grey)),
                        child: task.isCompleteTask == false
                            ? const Icon(
                                Icons.done,
                                color: Colors.grey,
                              )
                            : const Icon(
                                Icons.done,
                                color: Colors.white,
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      ' ${DateFormat("hh:mm a").format(DateTime.parse(task.time!))}',
                      style: TextStyle(color: Colors.black.withOpacity(.4)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.1,
                        child: Text(
                          task.title.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              decoration: task.isCompleteTask == false
                                  ? TextDecoration.none
                                  : TextDecoration.lineThrough),
                        )),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<TaskCubit>(context)
                        .turnOnNotificatoin(task: task)
                        .then((value) {
                      Future.delayed(const Duration(seconds: 1), () {
                        BlocProvider.of<TaskCubit>(context).getAllTask();
                      });
                    });
                    BlocProvider.of<TaskCubit>(context)
                        .getNotification(task: task);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(
                      FontAwesome.bell,
                      color: task.isNotification == false
                          ? Colors.grey
                          : Colors.deepOrange,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

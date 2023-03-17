import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daily_tasks/features/domain/enitites/task_entity.dart';
import 'package:my_daily_tasks/features/presentation/cubit/task_cubit.dart';
import 'package:my_daily_tasks/features/presentation/widgets/common.dart';
import 'package:intl/intl.dart';
import 'package:my_daily_tasks/features/presentation/widgets/theme/style.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _taskTextController = TextEditingController();
  int _selectedTaskTypeIndex = 0;
  late DateTime _selectedTime = DateTime.now();

  @override
  void dispose() {
    _taskTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Task'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _addNewTaskWidget(),
              _divider(),
              _taskTypeWidget(),
              _divider(),
              _chooseTimeWidget(),
              _addTaskWidget(),
              // SizedBox(
              //   height: 30,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: 3,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       return SelectTaskType(
              //         color: taskTypeListColor[index],
              //         name: taskTypeList[index],
              //         index: index,
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ));
  }

  _addNewTaskWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        color: Colors.blueGrey.withOpacity(.2),
      ),
      child: Scrollbar(
        thickness: 6,
        child: TextField(
          controller: _taskTextController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: "e.g moring walk",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  _divider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.height,
        const Divider(
          thickness: 1.5,
        ),
        10.height,
      ],
    );
  }

  _taskTypeWidget() {
    return SizedBox(
      height: 20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: taskTypeList.map((name) {
          var index = taskTypeList.indexOf(name);

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTaskTypeIndex = index;
              });
            },
            child: _selectedTaskTypeIndex == index
                ? Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: taskTypeListColor[index],
                      ),
                      child: Text(
                        name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: taskTypeListColor[index],
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedS = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (pickedS != null &&
        pickedS !=
            TimeOfDay(hour: _selectedTime.hour, minute: _selectedTime.minute)) {
      setState(() {
        _selectedTime = DateTime(_selectedTime.year, _selectedTime.month,
            _selectedTime.day, pickedS.hour, pickedS.minute);
      });
    }
  }

  _chooseTimeWidget() {
    return GestureDetector(
      onTap: () {
        _selectTime();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Choose Time",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
              "${DateFormat("hh:mm a").format(DateTime.now())} - ${DateFormat("hh:mm a").format(_selectedTime)}"),
        ],
      ),
    );
  }

  _addTaskWidget() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          submitNewTask();
        },
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50,
            alignment: Alignment.center,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gradient: LinearGradient(colors: [
                Colors.indigo,
                color6FADE4,
              ], end: Alignment.topLeft, begin: Alignment.topRight),
            ),
            child: const Text(
              "Add task",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  void submitNewTask() {
    if (_taskTextController.text.isEmpty) {
      return;
    }
    BlocProvider.of<TaskCubit>(context).addNewTask(
        task: TaskEntity(
      title: _taskTextController.text,
      taskType: taskTypeList[_selectedTaskTypeIndex],
      isNotification: false,
      isCompleteTask: false,
      colorIndex: _selectedTaskTypeIndex,
      time: _selectedTime.toString(),
    ));
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "New Task Added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}

extension on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}

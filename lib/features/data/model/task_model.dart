import 'package:my_daily_tasks/features/domain/enitites/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    int? id,
    final String? title,
    final int? colorIndex,
    final String? time,
    final bool? isCompleteTask,
    final bool? isNotification,
    final String? taskType,
  }) : super(
          colorIndex: colorIndex,
          isCompleteTask: isCompleteTask,
          isNotification: isNotification,
          time: time,
          title: title,
          taskType: taskType,
        );

// fetch data
  static TaskModel fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      isCompleteTask: json['isCompleteTask'],
      time: json['time'],
      isNotification: json['isNotification'],
      colorIndex: json['colorIndex'],
      taskType: json['taskType'],
    );
  }

// insert data
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "isCompleteTask": isCompleteTask,
      "time": time,
      "isNotification": isNotification,
      "colorIndex": colorIndex,
      "taskType": taskType,
    };
  }
}

import 'package:my_daily_tasks/features/domain/enitites/task_entity.dart';
import 'package:sembast/sembast.dart';

abstract class LocalDataSource {
  Future<void> addNewTask(TaskEntity task);
  Future<void> deleteTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<List<TaskEntity>> getAllTask();
  Future<void> getNotification(TaskEntity task);
  Future<Database> openDatabase();
  Future<void> turnOnNotification(TaskEntity task);
  Future<void> initNotification();
}

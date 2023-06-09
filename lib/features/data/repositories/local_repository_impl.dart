import 'package:my_daily_tasks/features/data/local_data_source/local_data_source.dart';
import 'package:my_daily_tasks/features/domain/enitites/task_entity.dart';
import 'package:my_daily_tasks/features/domain/repositories/local_repositories.dart';
import 'package:sembast/sembast.dart';

class LocalRepositoryImpl implements LocalRepository {
  final LocalDataSource localDataSource;

  LocalRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addNewTask(TaskEntity task) async =>
      localDataSource.addNewTask(task);

  @override
  Future<void> deleteTask(TaskEntity task) async =>
      localDataSource.deleteTask(task);

  @override
  Future<List<TaskEntity>> getAllTask() async => localDataSource.getAllTask();

  @override
  Future<void> getNotification(TaskEntity task) async =>
      localDataSource.getNotification(task);

  @override
  Future<Database> openDatabase() async => localDataSource.openDatabase();

  @override
  Future<void> turnOnNotification(TaskEntity task) async =>
      localDataSource.turnOnNotification(task);

  @override
  Future<void> updateTask(TaskEntity task) async =>
      localDataSource.updateTask(task);

  @override
  Future<void> initNotification() async {
    localDataSource.initNotification();
  }
}

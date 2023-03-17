import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daily_tasks/features/domain/enitites/task_entity.dart';
import 'package:my_daily_tasks/features/domain/usecases/add_task_usecase.dart';
import 'package:my_daily_tasks/features/domain/usecases/delete_usecase.dart';
import 'package:my_daily_tasks/features/domain/usecases/get_all_tasks.dart';
import 'package:my_daily_tasks/features/domain/usecases/get_notification_usecase.dart';
import 'package:my_daily_tasks/features/domain/usecases/init_notification_usecase.dart';
import 'package:my_daily_tasks/features/domain/usecases/open-database_usecase.dart';
import 'package:my_daily_tasks/features/domain/usecases/turn_off_notification_usecase.dart';
import 'package:my_daily_tasks/features/domain/usecases/update_usecase.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final AddTaskUseCase addTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final GetAllTaskUseCase getAllTaskUseCase;
  final GetNotificationUseCase getNotificationUseCase;
  final OpenDatabaseUseCase openDatabaseUseCase;
  final TurnOnNotificationUseCase turnOnNotificationUseCase;
  final UpdateUseCase updateUseCase;
  final InitNotificationUseCase initNotificationUseCase;

  TaskCubit({
    required this.addTaskUseCase,
    required this.deleteTaskUseCase,
    required this.getAllTaskUseCase,
    required this.getNotificationUseCase,
    required this.openDatabaseUseCase,
    required this.turnOnNotificationUseCase,
    required this.updateUseCase,
    required this.initNotificationUseCase,
  }) : super(TaskInitialState());

  Future<void> addNewTask({required TaskEntity task}) async {
    try {
      await addTaskUseCase.call(task);
      // or  addTaskUseCase(task);
    } catch (_) {
      emit(TaskFailureState());
    }
  }

  Future<void> initNotification() async {
    try {
      await initNotificationUseCase.call();
      // or  addTaskUseCase(task);
    } catch (_) {
      // emit(TaskFailureState());
    }
  }

  Future<void> deleteTask({required TaskEntity task}) async {
    try {
      await deleteTaskUseCase.call(task);
    } catch (_) {}
  }

  Future<void> getAllTask() async {
    emit(TaskLoadingState());
    try {
      final taskData = await getAllTaskUseCase.call();
      emit(TaskLoadedState(taskData: taskData));
    } catch (e) {
      log('Error $e');
      emit(TaskFailureState());
    }
  }

  Future<void> openDatabase() async {
    try {
      await openDatabaseUseCase.call();
    } catch (_) {}
  }

  Future<void> getNotification({required TaskEntity task}) async {
    try {
      await getNotificationUseCase.call(task);
    } catch (_) {}
  }

  Future<void> turnOnNotificatoin({required TaskEntity task}) async {
    try {
      await turnOnNotificationUseCase.call(task);
    } catch (_) {}
  }

  Future<void> updateTask({required TaskEntity task}) async {
    try {
      await updateUseCase.call(task);
    } catch (_) {}
  }
}

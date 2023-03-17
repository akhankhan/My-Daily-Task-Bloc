// initial
// failure
// loaded/success
// loading

part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitialState extends TaskState {
  @override
  List<Object?> get props => [];
}

class TaskLoadingState extends TaskState {
  @override
  List<Object?> get props => [];
}

class TaskLoadedState extends TaskState {
  final List<TaskEntity> taskData;

  const TaskLoadedState({required this.taskData});

  @override
  List<Object?> get props => [];
}

class TaskFailureState extends TaskState {
  @override
  List<Object?> get props => [];
}

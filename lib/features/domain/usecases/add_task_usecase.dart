import 'package:my_daily_tasks/features/domain/enitites/task_entity.dart';
import 'package:my_daily_tasks/features/domain/repositories/local_repositories.dart';

class AddTaskUseCase {
  final LocalRepository localRepository;

  AddTaskUseCase({required this.localRepository});

  Future<void> call(TaskEntity task) {
    return localRepository.addNewTask(task);
  }
}

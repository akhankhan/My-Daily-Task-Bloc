import 'package:my_daily_tasks/features/domain/enitites/task_entity.dart';
import 'package:my_daily_tasks/features/domain/repositories/local_repositories.dart';

class DeleteTaskUseCase {
  final LocalRepository localRepository;

  DeleteTaskUseCase({required this.localRepository});

  Future<void> call(TaskEntity task) {
    return localRepository.deleteTask(task);
  }
}

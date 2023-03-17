import 'package:my_daily_tasks/features/domain/enitites/task_entity.dart';
import 'package:my_daily_tasks/features/domain/repositories/local_repositories.dart';

class GetAllTaskUseCase {
  final LocalRepository localRepository;

  GetAllTaskUseCase({required this.localRepository});

  Future<List<TaskEntity>> call() {
    return localRepository.getAllTask();
  }
}

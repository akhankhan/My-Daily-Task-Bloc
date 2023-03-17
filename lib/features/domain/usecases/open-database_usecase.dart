import 'package:my_daily_tasks/features/domain/repositories/local_repositories.dart';
import 'package:sembast/sembast.dart';

class OpenDatabaseUseCase {
  final LocalRepository localRepository;

  OpenDatabaseUseCase({required this.localRepository});

  Future<Database> call() {
    return localRepository.openDatabase();
  }
}

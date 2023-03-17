import 'package:my_daily_tasks/features/domain/repositories/local_repositories.dart';

class InitNotificationUseCase {
  final LocalRepository localRepository;

  InitNotificationUseCase({required this.localRepository});

  Future<void> call() {
    return localRepository.initNotification();
  }
}

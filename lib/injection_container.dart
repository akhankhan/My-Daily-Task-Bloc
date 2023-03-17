import 'package:get_it/get_it.dart';
import 'package:my_daily_tasks/features/data/local_data_source/local_data_source.dart';
import 'package:my_daily_tasks/features/data/local_data_source/local_data_source_impl.dart';
import 'package:my_daily_tasks/features/data/repositories/local_repository_impl.dart';
import 'package:my_daily_tasks/features/domain/repositories/local_repositories.dart';
import 'package:my_daily_tasks/features/domain/usecases/add_task_usecase.dart';
import 'package:my_daily_tasks/features/domain/usecases/delete_usecase.dart';
import 'package:my_daily_tasks/features/domain/usecases/get_all_tasks.dart';
import 'package:my_daily_tasks/features/domain/usecases/get_notification_usecase.dart';
import 'package:my_daily_tasks/features/domain/usecases/init_notification_usecase.dart';
import 'package:my_daily_tasks/features/domain/usecases/open-database_usecase.dart';
import 'package:my_daily_tasks/features/domain/usecases/turn_off_notification_usecase.dart';
import 'package:my_daily_tasks/features/domain/usecases/update_usecase.dart';
import 'package:my_daily_tasks/features/presentation/cubit/task_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //bloc//Cubit
  sl.registerFactory<TaskCubit>(() => TaskCubit(
        addTaskUseCase: sl.call(),
        deleteTaskUseCase: sl.call(),
        getAllTaskUseCase: sl.call(),
        getNotificationUseCase: sl.call(),
        openDatabaseUseCase: sl.call(),
        turnOnNotificationUseCase: sl.call(),
        updateUseCase: sl.call(),
        initNotificationUseCase: sl.call(),
      ));

  //UseCase
  sl.registerLazySingleton<AddTaskUseCase>(
      () => AddTaskUseCase(localRepository: sl.call()));

  sl.registerLazySingleton<DeleteTaskUseCase>(
      () => DeleteTaskUseCase(localRepository: sl.call()));

  sl.registerLazySingleton<GetAllTaskUseCase>(
      () => GetAllTaskUseCase(localRepository: sl.call()));

  sl.registerLazySingleton<GetNotificationUseCase>(
      () => GetNotificationUseCase(localRepository: sl.call()));

  sl.registerLazySingleton<OpenDatabaseUseCase>(
      () => OpenDatabaseUseCase(localRepository: sl.call()));

  sl.registerLazySingleton<TurnOnNotificationUseCase>(
      () => TurnOnNotificationUseCase(localRepository: sl.call()));

  sl.registerLazySingleton<UpdateUseCase>(
      () => UpdateUseCase(localRepository: sl.call()));

  sl.registerLazySingleton<InitNotificationUseCase>(
      () => InitNotificationUseCase(localRepository: sl.call()));

  //Repository
  sl.registerLazySingleton<LocalRepository>(
      () => LocalRepositoryImpl(localDataSource: sl.call()));

  //RemoteDataSource
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  //External
}

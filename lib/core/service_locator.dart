import 'package:get_it/get_it.dart';
import 'package:r5_task_list/data/datasources/authentication/authentication_local_data_source.dart';
import 'package:r5_task_list/data/datasources/authentication/authentication_remote_data_source.dart';
import 'package:r5_task_list/data/datasources/task/task_remote_data_source.dart';
import 'package:r5_task_list/data/repository/task_repository_impl.dart';
import 'package:r5_task_list/domain/repositories/task_repository.dart';
import 'package:r5_task_list/domain/usecases/create_task_use_case.dart';
import 'package:r5_task_list/domain/usecases/delete_task_use_case.dart';
import 'package:r5_task_list/domain/usecases/get_task_list_use_case.dart';
import 'package:r5_task_list/domain/usecases/is_user_authenticated_use_case.dart';
import 'package:r5_task_list/domain/usecases/login_user_use_case.dart';
import 'package:r5_task_list/domain/usecases/sign_out_user_use_case.dart';
import 'package:r5_task_list/domain/usecases/update_task_use_case.dart';

import '../data/repository/authentication_repository_impl.dart';
import '../domain/repositories/authentication_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator
    ..registerLazySingleton<LoginUserUseCase>(LoginUserUseCase.new)
    ..registerLazySingleton<AuthenticationRepository>(
            () => AuthenticationRepositoryImpl())
    ..registerLazySingleton<AuthenticationLocalDataSource>(
        AuthenticationLocalDataSourceImpl.new)
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        AuthenticationRemoteDataSourceImpl.new)
    ..registerLazySingleton<IsUserAuthenticatedUseCase>(IsUserAuthenticatedUseCase.new)
    ..registerLazySingleton<GetTaskListUseCase>(GetTaskListUseCase.new)
    ..registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl())
    ..registerLazySingleton<TaskRemoteDataSource>(() => TaskRemoteDataSourceImpl())
    ..registerLazySingleton<CreateTaskUseCase>(CreateTaskUseCase.new)
    ..registerLazySingleton<SignOutUserUseCase>(SignOutUserUseCase.new)
    ..registerLazySingleton<UpdateTaskUseCase>(UpdateTaskUseCase.new)
    ..registerLazySingleton<DeleteTaskUseCase>(DeleteTaskUseCase.new);
}
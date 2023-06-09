import 'package:r5_task_list/core/service_locator.dart';
import 'package:r5_task_list/data/datasources/task/task_remote_data_source.dart';
import 'package:r5_task_list/data/models/task_model.dart';
import 'package:r5_task_list/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource _remoteDataSource;

  TaskRepositoryImpl({
    TaskRemoteDataSource? remoteDataSource,
  }) : _remoteDataSource = remoteDataSource ?? locator<TaskRemoteDataSource>();
  
  @override
  Future<List<Task>> getTaskList() async {
    return _remoteDataSource.getTaskList();
  }

  @override
  Future<bool> createTask({ required Task task }) async {
    return _remoteDataSource.createTask(task: task);
  }

  @override
  Future<bool> updateTask({ required Task task }) async {
    return _remoteDataSource.updateTask(task: task);
  }

  @override
  Future<bool> deleteTask({ required String docId }) {
    return _remoteDataSource.deleteTask(docId: docId);
  }
}
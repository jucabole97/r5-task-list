import 'package:r5_task_list/core/service_locator.dart';
import 'package:r5_task_list/data/models/task_model.dart';
import 'package:r5_task_list/domain/repositories/task_repository.dart';

class GetTaskListUseCase {
  final TaskRepository _taskRepository;
  
  GetTaskListUseCase({
    TaskRepository? taskRepository,
  }) : _taskRepository = taskRepository ?? locator<TaskRepository>();

  Future<List<Task>> call() {
    return _taskRepository.getTaskList();
  }
}
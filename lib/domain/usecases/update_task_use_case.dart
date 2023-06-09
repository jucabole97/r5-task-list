import 'package:r5_task_list/core/service_locator.dart';
import 'package:r5_task_list/data/models/task_model.dart';
import 'package:r5_task_list/domain/repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository _taskRepository;
  
  UpdateTaskUseCase({
    TaskRepository? taskRepository,
  }) : _taskRepository = taskRepository ?? locator<TaskRepository>();

  Future<bool> call({ required Task task }) {
    return _taskRepository.updateTask(task: task);
  }
}
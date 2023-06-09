import 'package:r5_task_list/core/service_locator.dart';
import 'package:r5_task_list/domain/repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository _taskRepository;
  
  DeleteTaskUseCase({
    TaskRepository? taskRepository,
  }) : _taskRepository = taskRepository ?? locator<TaskRepository>();

  Future<bool> call({ required String docId }) {
    return _taskRepository.deleteTask(docId: docId);
  }
}
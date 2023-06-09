import 'package:r5_task_list/data/models/task_model.dart';

abstract class TaskRepository {
  ///Method to get task by user
  Future<List<Task>> getTaskList();

  ///Method to create task by user
  Future<bool> createTask({ required Task task });

  ///Method to update task
  Future<bool> updateTask({ required Task task });

  ///Method to delete task by id
  Future<bool> deleteTask({ required String docId });

}
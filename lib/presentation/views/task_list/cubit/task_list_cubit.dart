import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r5_task_list/core/service_locator.dart';
import 'package:r5_task_list/data/models/task_model.dart';
import 'package:r5_task_list/domain/usecases/delete_task_use_case.dart';
import 'package:r5_task_list/domain/usecases/get_task_list_use_case.dart';
import 'package:r5_task_list/domain/usecases/update_task_use_case.dart';

part 'task_list_state.dart';

// Class that contains the  bloc of singup user
class TaskListCubit extends Cubit<TaskListState> {
  final GetTaskListUseCase _getTaskListUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  TaskListCubit({
    GetTaskListUseCase? getTaskListUseCase,
    UpdateTaskUseCase? updateTaskUseCase,
    DeleteTaskUseCase? deleteTaskUseCase,
  }) : _getTaskListUseCase = getTaskListUseCase ?? locator<GetTaskListUseCase>(),
       _updateTaskUseCase = updateTaskUseCase ?? locator<UpdateTaskUseCase>(),
       _deleteTaskUseCase = deleteTaskUseCase ?? locator<DeleteTaskUseCase>(),
      super(InitialState()) {
        getTaskList();
    }

  void getTaskList() async {
    emit(LoadingState());

    final List<Task> taskList = await _getTaskListUseCase.call();

    if (taskList.isEmpty) {
      emit(TaskEmptyState());
      return;
    }

    emit(TaskLoadedState(taskList));
  }

  void updateTask(Task task) async {
    emit(LoadingState());

    final bool taskUpdated = await _updateTaskUseCase.call(task: task);

    if (!taskUpdated) {
      emit(ErrorState());
      return;
    }
    getTaskList();
  }

  void deleteTask(String? docId) async {
    emit(LoadingState());

    if (docId == null) {
      emit(ErrorState());
      return;
    }

    final bool deletedTask = await _deleteTaskUseCase.call(docId: docId);

    if (!deletedTask) {
      emit(ErrorState());
      return;
    }

    getTaskList();
  }
}

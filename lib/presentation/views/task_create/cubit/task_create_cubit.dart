import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r5_task_list/core/service_locator.dart';
import 'package:r5_task_list/data/models/task_model.dart';
import 'package:r5_task_list/domain/usecases/create_task_use_case.dart';

part 'task_create_state.dart';

// Class that contains the  bloc of singup user
class TaskCreateCubit extends Cubit<TaskCreateState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final CreateTaskUseCase _createTaskUseCase;

  TaskCreateCubit({
    CreateTaskUseCase? createTaskUseCase,
  }) : _createTaskUseCase = createTaskUseCase ?? locator<CreateTaskUseCase>(),
       super(InitialState());

  void createTask() async {
    try {
      emit(LoadingState());

      final Task taskToSend = Task(
        titleEs: titleController.text,
        descriptionEs: descriptionController.text,
        date: dateController.text,
      );

      final bool response = await _createTaskUseCase.call(task: taskToSend);

      if (!response) {
        emit(ErrorState());
        return;
      }

      emit(LoadedState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    return super.close();
  }
}

part of 'task_list_cubit.dart';

@immutable
abstract class TaskListState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends TaskListState {
  @override
  List<Object> get props => [];
}

class LoadingState extends TaskListState {
  @override
  List<Object> get props => [];
}

class TaskLoadedState extends TaskListState {
  final List<Task> tasks;

  TaskLoadedState(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskEmptyState extends TaskListState {
  @override
  List<Object> get props => [];
}

class ErrorState extends TaskListState {
  @override
  List<Object> get props => [];
}
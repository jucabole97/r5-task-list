import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:r5_task_list/core/framework/colors.dart';
import 'package:r5_task_list/data/models/task_model.dart';
import 'package:r5_task_list/presentation/views/task_create/cubit/task_create_cubit.dart' as create;
import 'package:r5_task_list/presentation/views/task_create/ui/task_create_view.dart';
import 'package:r5_task_list/presentation/views/task_list/cubit/task_list_cubit.dart';
import 'package:r5_task_list/presentation/widgets/custom_material_dialog.dart';

/// This class contains the  UI Login Screen
class TaskListView extends StatelessWidget {
  const TaskListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListCubit, TaskListState>(
      builder: (_, state) {
        if (state is TaskLoadedState) {
          return _buildTaskList(tasks: state.tasks, context: context);
        } else if (state is LoadingState) {
          return _buildLoadingState();
        } else {
          return _buildEmptyState();
        }
      },
    );
  }

  Widget _buildTaskList({ required List<Task> tasks, required BuildContext context }) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTaskListTitle(),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return _buildTaskItem(task: tasks[index], context: context);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateTaskForm(context),
        backgroundColor: secondaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskItem({ required Task task, required BuildContext context }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, top: 8),
                child: InkWell(
                  child: const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ),
                  onTap: () => context.read<TaskListCubit>().deleteTask(task.id),
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                'resources/images/logo.png',
                width: 60,
                fit: BoxFit.cover,
              ),
              title: Text(task.titleEs ?? ''),
              subtitle: Text(task.descriptionEs ?? ''),
              trailing: Text(task.date ?? ''),
              isThreeLine: false,
            ),
            SizedBox(
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                height: 1,
                width: double.infinity,
                color: primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('¿Desea finalizar la tarea?'),
                  Switch(
                    value: task.isCompleted ?? false,
                    onChanged: (value) async {
                      final Task updatedTask = task.copyWith(isCompleted: value);
                      await CustomMaterialDialog.showMaterialDialog(
                        context: context,
                        title: 'Cerrar sesión',
                        description: '¿Desea cerrar sesión?',
                        cancelButtonText: 'Cancelar',
                        confimButtonText: 'Confirmar',
                        onTapConfirmButton: () => context.read<TaskListCubit>().updateTask(updatedTask),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Lista vacía',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Lottie.asset('resources/lotties/empty_list.json'),
        ],
      ),
    );
  }

  Widget _buildTaskListTitle() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: const Text('Lista de tareas',
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
    );
  }

  void _showCreateTaskForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider<create.TaskCreateCubit>(
          create: (_) => create.TaskCreateCubit(),
          child: const TaskCreateView(),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        )
      ),
      useSafeArea: true,
      isScrollControlled: true,
    ).whenComplete(() => context.read<TaskListCubit>().getTaskList());
  }

}
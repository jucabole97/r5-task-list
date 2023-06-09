import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:r5_task_list/core/framework/colors.dart';
import 'package:r5_task_list/presentation/views/task_create/cubit/task_create_cubit.dart';
import 'package:r5_task_list/presentation/widgets/custom_button.dart';
import 'package:r5_task_list/presentation/widgets/custom_form_section.dart';

class TaskCreateView extends StatelessWidget {
  const TaskCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskCreateCubit cubitProvider = context.read<TaskCreateCubit>();
    return BlocBuilder<TaskCreateCubit, TaskCreateState>(
      builder: (context, state) {
        return Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              const Text('Crear tarea',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Lottie.asset('resources/lotties/form.json'),
              CustomFormSection(
                hintText: "Título",
                labelText: "Título",
                controller: cubitProvider.titleController,
                prefixIcon: const Icon(Icons.file_copy_outlined),
              ),
              const SizedBox(height: 10),
              CustomFormSection(
                hintText: "Descripción",
                labelText: "Descripción",
                controller: cubitProvider.descriptionController,
                prefixIcon: const Icon(Icons.description),
              ),
              const SizedBox(height: 10),
              CustomFormSection(
                hintText: "Fecha",
                labelText: "Fecha",
                controller: cubitProvider.dateController,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  cubitProvider.dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate ?? DateTime.now());
                },
                prefixIcon: const Icon(Icons.calendar_today),
                readOnly: true,
              ),
              const SizedBox(height: 15),
              CustomButton(
                buttonText: 'CREAR',
                onTapButton: () {
                  cubitProvider.createTask();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
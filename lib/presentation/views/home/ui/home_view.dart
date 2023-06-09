import 'package:r5_task_list/presentation/views/login/cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:r5_task_list/presentation/views/login/ui/login_view.dart';
import 'package:r5_task_list/presentation/views/task_list/ui/task_list_view.dart';
import 'package:r5_task_list/presentation/widgets/custom_material_dialog.dart';

/// This class contains the  UI Login Screen
class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginCubit cubitProvider = context.read<LoginCubit>();
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return Scaffold(
            body: const TaskListView(),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  onPressed: () => CustomMaterialDialog.showMaterialDialog(
                    context: context,
                    title: 'Cerrar sesión',
                    description: '¿Desea cerrar sesión?',
                    cancelButtonText: 'Cancelar',
                    confimButtonText: 'Confirmar',
                    onTapConfirmButton: cubitProvider.signOutUser,
                  ),
                  // cubitProvider.signOutUser,
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.exit_to_app_rounded),
                ),
              ),
            ),
          );
        } else {
          return const LoginView();
        }
      },
    );
  }
}
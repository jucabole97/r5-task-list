import 'package:lottie/lottie.dart';
import 'package:r5_task_list/core/framework/colors.dart';
import 'package:r5_task_list/presentation/views/login/cubit/login_cubit.dart' as bloc;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:r5_task_list/presentation/views/login/cubit/login_cubit.dart';
import 'package:r5_task_list/presentation/widgets/custom_button.dart';
import 'package:r5_task_list/presentation/widgets/custom_form_section.dart';

/// This class contains the  UI Login Screen
class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginCubit cubitProvider = context.read<LoginCubit>();
    return BlocBuilder<bloc.LoginCubit, bloc.LoginState>(
      bloc: cubitProvider,
      builder: (context, state) {
        if (state is bloc.LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  '¡Bienvenido!',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Lottie.asset('resources/lotties/welcome.json'),
                Form(
                  key: cubitProvider.formKey,
                  child: Column(
                    children: [
                      CustomFormSection(
                        hintText: "Correo electrónico",
                        labelText: "Correo electrónico",
                        controller: cubitProvider.emailController,
                        prefixIcon: const Icon(Icons.email_outlined),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      CustomFormSection(
                        hintText: "Contraseña",
                        labelText: "Contraseña",
                        controller: cubitProvider.passwordController,
                        prefixIcon: const Icon(Icons.password_rounded),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                        buttonText: 'INICIAR SESIÓN',
                        onTapButton: cubitProvider.loginUser,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
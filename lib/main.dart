import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r5_task_list/core/framework/colors.dart';
import 'package:r5_task_list/core/shared_preferences_manager.dart';
import 'package:r5_task_list/domain/usecases/create_task_use_case.dart';
import 'package:r5_task_list/domain/usecases/get_task_list_use_case.dart';
import 'package:r5_task_list/domain/usecases/is_user_authenticated_use_case.dart';
import 'package:r5_task_list/domain/usecases/login_user_use_case.dart';
import 'package:r5_task_list/domain/usecases/sign_out_user_use_case.dart';
import 'package:r5_task_list/firebase_options.dart';
import 'package:r5_task_list/core/service_locator.dart';
import 'package:r5_task_list/presentation/views/home/ui/home_view.dart';
import 'package:r5_task_list/presentation/views/login/cubit/login_cubit.dart';
import 'package:r5_task_list/presentation/views/task_list/cubit/task_list_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/views/task_create/cubit/task_create_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator();

  runApp(const R5TaskList());
}

class R5TaskList extends StatelessWidget {
  const R5TaskList({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        fontFamily: 'Gilroy',
      ),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(
            create: (_) => LoginCubit(
              loginUserUseCase: locator<LoginUserUseCase>(),
              isUserAuthenticatedUseCase: locator<IsUserAuthenticatedUseCase>(),
              signOutUseCase: locator<SignOutUserUseCase>(),
            ),
          ),
          BlocProvider<TaskListCubit>(
            create: (_) => TaskListCubit(
              getTaskListUseCase: locator<GetTaskListUseCase>(),
            ),
          ),
          BlocProvider<TaskCreateCubit>(
            create: (_) => TaskCreateCubit(
              createTaskUseCase: locator<CreateTaskUseCase>(),
            ),
          ),
        ],
        child: const Scaffold(
          body: HomeView(),
        ),
      ),
    );
  }
}
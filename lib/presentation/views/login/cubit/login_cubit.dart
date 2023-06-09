import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r5_task_list/data/models/service_model.dart';
import 'package:r5_task_list/domain/usecases/is_user_authenticated_use_case.dart';
import 'package:r5_task_list/domain/usecases/login_user_use_case.dart';
import 'package:r5_task_list/domain/usecases/sign_out_user_use_case.dart';

part 'login_state.dart';

// Class that contains the  bloc of singup user
class LoginCubit extends Cubit<LoginState> {
  final LoginUserUseCase loginUserUseCase;
  final SignOutUserUseCase signOutUseCase;
  final IsUserAuthenticatedUseCase isUserAuthenticatedUseCase;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginCubit({
    required this.loginUserUseCase,
    required this.isUserAuthenticatedUseCase,
    required this.signOutUseCase,
  }) : super(InitialState()) {
        if (isUserAuthenticated) {
          emit(AuthenticatedState());
        } else {
          emit(UnauthenticatedState());
        }
      }

  void loginUser() async {
    if (enableButton) {
      try {
        emit(LoadingState());

        final Service response = await loginUserUseCase.call(email: emailController.text, password: passwordController.text);

        if (!(response.isOk ?? false)) {
          emit(ErrorState());
          return;
        }

        emit(AuthenticatedState());
      } catch (e) {
        emit(ErrorState());
      }
    }
  }

  void signOutUser() async {
    emit(LoadingState());
    await signOutUseCase.call();
    emit(UnauthenticatedState());
  }

  bool get enableButton {
    final bool enable = formKey.currentState?.validate() ?? false;
    return enable;
  }

  bool get isUserAuthenticated => isUserAuthenticatedUseCase.call();
  
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}

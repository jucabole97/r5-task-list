import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:r5_task_list/data/models/service_model.dart';
import 'package:r5_task_list/domain/usecases/is_user_authenticated_use_case.dart';
import 'package:r5_task_list/domain/usecases/login_user_use_case.dart';
import 'package:r5_task_list/domain/usecases/sign_out_user_use_case.dart';
import 'package:r5_task_list/presentation/views/login/cubit/login_cubit.dart';

class MockLoginUserUseCase extends Mock implements LoginUserUseCase {}

class MockSignOutUserUseCase extends Mock implements SignOutUserUseCase {}

class MockIsUserAuthenticatedUseCase extends Mock
    implements IsUserAuthenticatedUseCase {}

void main() {
  final MockLoginUserUseCase mockLoginUserUseCase = MockLoginUserUseCase();
  final MockSignOutUserUseCase mockSignOutUserUseCase = MockSignOutUserUseCase();
  final MockIsUserAuthenticatedUseCase mockIsUserAuthenticatedUseCase = MockIsUserAuthenticatedUseCase();
  final LoginCubit cubit = LoginCubit(
    loginUserUseCase: mockLoginUserUseCase,
    isUserAuthenticatedUseCase: mockIsUserAuthenticatedUseCase,
    signOutUseCase: mockSignOutUserUseCase,
  );

  setUp(() {
    when(mockIsUserAuthenticatedUseCase.call).thenReturn(false);
  });

  tearDown(() {
    verify(mockIsUserAuthenticatedUseCase.call);
    cubit.close();
  });

  test('Initial state is correct', () {
    expect(cubit.state, isA<InitialState>());
  });

  group('LoginUser', () {
    test('Emits LoadingState and AuthenticatedState on successful login',
        () async {
      // Arrange
      when(() => mockLoginUserUseCase.call(email: any(named: 'email'), password: any(named: 'password'))).thenAnswer(
        (_) async => Service(isOk: true),
      );

      // Act
      cubit.loginUser();

      // Assert
      expect(cubit.state, isA<LoadingState>());

      await untilCalled(() => mockLoginUserUseCase.call(email: any(named: 'email'), password: any(named: 'password')));
      verify(() => mockLoginUserUseCase.call(email: any(named: 'email'), password: any(named: 'password'))).called(1);

      expect(cubit.state, isA<AuthenticatedState>());
    });

    test('Emits LoadingState and ErrorState on unsuccessful login', () async {
      // Arrange
      when(() => mockLoginUserUseCase.call(email: any(named: 'email'), password: any(named: 'password'))).thenAnswer(
        (_) async => Service(isOk: false),
      );

      // Act
      cubit.loginUser();

      // Assert
      expect(cubit.state, isA<LoadingState>());

      await untilCalled(() => mockLoginUserUseCase.call(email: any(named: 'email'), password: any(named: 'password')));
      verify(() => mockLoginUserUseCase.call(email: any(named: 'email'), password: any(named: 'password'))).called(1);

      expect(cubit.state, isA<ErrorState>());
    });

    test('Emits ErrorState on login error', () async {
      // Arrange
      when(() => mockLoginUserUseCase.call(email: any(named: 'email'), password: any(named: 'password'))).thenThrow(Exception());

      // Act
      cubit.loginUser();

      // Assert
      expect(cubit.state, isA<LoadingState>());

      await untilCalled(() => mockLoginUserUseCase.call(email: any(named: 'email'), password: any(named: 'password')));
      verify(() => mockLoginUserUseCase.call(email: any(named: 'email'), password: any(named: 'password'))).called(1);

      expect(cubit.state, isA<ErrorState>());
    });
  });

  group('SignOutUser', () {
    test('Emits LoadingState and UnauthenticatedState on successful sign out',
        () async {
      // Arrange
      when(() => mockSignOutUserUseCase.call()).thenAnswer((_) async => null);
      // Act
      cubit.signOutUser();

      // Assert
      expect(cubit.state, isA<LoadingState>());

      await untilCalled(() => mockSignOutUserUseCase.call());
      verify(() => mockSignOutUserUseCase.call()).called(1);

      expect(cubit.state, isA<UnauthenticatedState>());
    });
  });

  group('isUserAuthenticated', () {
    test('Returns true if user is authenticated', () {
      // Arrange
      when(() => mockIsUserAuthenticatedUseCase.call()).thenReturn(true);

      // Act
      final result = cubit.isUserAuthenticated;

      // Assert
      expect(result, true);
      verify(() => mockIsUserAuthenticatedUseCase.call()).called(1);
    });

    test('Returns false if user is not authenticated', () {
      // Arrange
      when(() => mockIsUserAuthenticatedUseCase.call()).thenReturn(false);

      // Act
      final result = cubit.isUserAuthenticated;

      // Assert
      expect(result, false);
      verify(() => mockIsUserAuthenticatedUseCase.call()).called(1);
    });
  });
}
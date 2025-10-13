part of 'login_cubit.dart';

abstract class LoginState implements Built<LoginState, LoginStateBuilder> {
  LoginState._();

  LoginForm get loginForm;

  bool get isLoading;

  factory LoginState([Function(LoginStateBuilder b) updates]) = _$LoginState;

  factory LoginState.initial() {
    return LoginState(
      (s) => s
        ..loginForm = LoginForm()
        ..isLoading = false,
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:built_value/built_value.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:painter_app/base/forms/login/login_form.dart';
import 'package:painter_app/core/resources/base_exception.dart';
import 'package:painter_app/core/resources/response_state.dart';
import 'package:painter_app/firebase/auth/auth_repository.dart';

part 'login_cubit.g.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  Future<DataState<UserCredential>> login(String email, String password) async {
    try {
      emit(state.rebuild((s) => s.isLoading = true));
      var res = await AuthRepository().signIn(email: email, password: password);

      emit(state.rebuild((s) => s.isLoading = false));
      return DataSuccess(res);
    } on FirebaseAuthException catch (e) {
      emit(state.rebuild((s) => s.isLoading = false));

      return DataFailed(BaseException.fromFirebase(e));
    }
  }
}

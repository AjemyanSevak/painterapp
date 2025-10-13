import 'package:bloc/bloc.dart';
import 'package:built_value/built_value.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:painter_app/base/forms/registration/registration_form.dart';
import 'package:painter_app/core/resources/base_exception.dart';
import 'package:painter_app/core/resources/response_state.dart';
import 'package:painter_app/firebase/auth/auth_repository.dart';

part 'registration_cubit.g.dart';
part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationState.initial());

  Future<DataState<UserCredential>> register(
    String email,
    String password,
  ) async {
    try {
      emit(state.rebuild((s) => s.isLoading = true));
      var res = await AuthRepository().register(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(res.user!.uid)
          .set({
            'firstName': state.registrationForm.nameControl.value,
            'email': email,
          });
      emit(state.rebuild((s) => s.isLoading = false));
      return DataSuccess(res);
    } on FirebaseAuthException catch (e) {
      emit(state.rebuild((s) => s.isLoading = false));
      return DataFailed(BaseException.fromFirebase(e));
    }
  }
}

part of 'registration_cubit.dart';

abstract class RegistrationState
    implements Built<RegistrationState, RegistrationStateBuilder> {
  RegistrationState._();

  RegistrationForm get registrationForm;

  bool get isLoading;

  factory RegistrationState([Function(RegistrationStateBuilder b) updates]) =
      _$RegistrationState;

  factory RegistrationState.initial() {
    return RegistrationState(
      (s) => s
        ..registrationForm = RegistrationForm()
        ..isLoading = false,
    );
  }
}

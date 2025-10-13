import 'package:painter_app/base/forms/general_form.dart';
import 'package:reactive_forms/reactive_forms.dart' hide MustMatchValidator;

class RegistrationForm extends GeneralForm {
  static const _nameControlName = 'name';
  static const _emailControlName = 'email';
  static const _passwordControlName = 'password';
  static const _passwordConfirmControlName = 'confirmpassword';

  RegistrationForm()
    : super(
        FormGroup(
          {
            _nameControlName: FormControl<String>(
              validators: [Validators.required],
            ),
            _emailControlName: FormControl<String>(
              validators: [Validators.required, Validators.email],
            ),
            _passwordControlName: FormControl<String>(
              validators: [
                Validators.required,
                Validators.pattern(
                  // Raw string for the pattern, with Unicode flag enabled:
                  RegExp(r'^.{6,}$', unicode: true),
                  // Optional custom error key:
                  validationMessage: 'passwordComplexity',
                ),
              ],
            ),
            _passwordConfirmControlName: FormControl<String>(
              validators: [Validators.required],
            ),
          },
          validators: [
            MustMatchValidator(
              _passwordControlName,
              _passwordConfirmControlName,
              markAsDirty: true,
            ),
          ],
        ),
      );

  TextControl get nameControl =>
      formGroup.control(_nameControlName) as TextControl;
  TextControl get emailControl =>
      formGroup.control(_emailControlName) as TextControl;
  TextControl get passwordControl =>
      formGroup.control(_passwordControlName) as TextControl;
  TextControl get confirmPasswordControl =>
      formGroup.control(_passwordConfirmControlName) as TextControl;
}

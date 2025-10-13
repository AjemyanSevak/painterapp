import 'package:reactive_forms/reactive_forms.dart';

typedef TextControl = FormControl<String>;
typedef NumControl = FormControl<num>;
typedef BoolControl = FormControl<bool>;
typedef DateControl = FormControl<DateTime>;

abstract class GeneralForm {
  FormGroup formGroup;

  GeneralForm(this.formGroup);

  /// Validates the field, notifies listeners and returns the validity value.
  bool validate() {
    formGroup
      ..markAllAsTouched()
      ..updateValueAndValidity();

    return formGroup.valid;
  }

  /// Marks all controls as untouched and sets values to null.
  void clear() {
    formGroup.controls.forEach((name, control) {
      control
        ..markAsUntouched()
        ..updateValue(null);
    });
  }
}

/// Represents a [FormGroup] validator that requires that two controls in the
/// group have the same values.
class MustMatchValidator extends Validator<dynamic> {
  final String controlName;
  final String matchingControlName;
  final bool markAsDirty;

  /// Constructs an instance of [MustMatchValidator]
  const MustMatchValidator(this.controlName, this.matchingControlName, {this.markAsDirty = true}) : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = {ValidationMessage.mustMatch: true};

    if (control is! FormGroup) {
      return error;
    }

    final formControl = control.control(controlName);
    final matchingFormControl = control.control(matchingControlName);

    if (formControl.value != matchingFormControl.value && matchingFormControl.touched) {
      matchingFormControl.setErrors(error, markAsDirty: markAsDirty);
    } else {
      matchingFormControl.removeError(ValidationMessage.mustMatch);
    }

    return null;
  }
}

/// Represents a control value accessor that convert between data types
/// [num] and [String].
class NumValueAccessor extends ControlValueAccessor<num, String> {
  @override
  String modelToViewValue(num? modelValue) {
    return modelValue == null ? '' : modelValue.toString();
  }

  @override
  num? viewToModelValue(String? viewValue) {
    return (viewValue == '' || viewValue == null) ? null : num.tryParse(viewValue);
  }
}

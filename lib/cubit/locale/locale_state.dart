part of 'locale_cubit.dart';

abstract class LocaleState implements Built<LocaleState, LocaleStateBuilder> {
  LocaleState._();

  Locale get locale;

  factory LocaleState([Function(LocaleStateBuilder b) updates]) = _$LocaleState;

  factory LocaleState.initial(final Locale locale) {
    return LocaleState((s) => s..locale = locale);
  }
}

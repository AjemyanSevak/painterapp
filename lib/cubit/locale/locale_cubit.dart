import 'package:bloc/bloc.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:painter_app/base/global_values/global_values.dart';

part 'locale_cubit.g.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState.initial(deviceLocale)) {
    initLocale();
  }

  Future<void> initLocale() async {
    setLocale(const Locale('ru'));
  }

  void setLocale(final Locale locale) {
    emit(state.rebuild((s) => s..locale = locale));
  }
}

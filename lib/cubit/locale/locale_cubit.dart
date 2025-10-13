import 'package:bloc/bloc.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:get_it/get_it.dart';
import 'package:painter_app/base/global_values/global_values.dart';
import 'package:painter_app/core/services/secure_storage_service.dart';

part 'locale_cubit.g.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState.initial(deviceLocale)) {
    initLocale();
  }

  final _secureStorageService = GetIt.I<SecureStorageService>();

  Future<void> initLocale() async {
    final locale = await _secureStorageService.readLocale();
    if (locale != null && supportedLocales.contains(locale)) {
      setLocale(locale);
    } else {
      setLocale(const Locale('ru'));
    }
  }

  void setLocale(final Locale locale) {
    _secureStorageService.writeLocale(locale.languageCode);
    emit(state.rebuild((s) => s..locale = locale));
  }
}

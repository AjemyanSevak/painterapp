// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Приложение для рисования';

  @override
  String get loginTitle => 'Вход';

  @override
  String get registration => 'Регистрация';

  @override
  String get login => 'Войти';

  @override
  String get name => 'Имя';

  @override
  String get email => 'e-mail';

  @override
  String get password => 'Пароль';

  @override
  String get confirmPassword => 'Подтверждение пароля';

  @override
  String get signup => 'Зарегистрироваться';

  @override
  String get gallery => 'Галерея';

  @override
  String get edit => 'Редактирование';

  @override
  String get newImage => 'Новое изображение';

  @override
  String get enterName => 'Введите ваше имя';

  @override
  String get enterEmail => 'Введите электронную почту';

  @override
  String get enterPassword => 'Введите пароль';

  @override
  String get yourEmail => 'Ваша электронная почта';

  @override
  String get passwordValidationMessage => '8-16 символов';

  @override
  String get create => 'Создать';

  @override
  String get areyousureexit => 'Вы уверены, что хотите выйти?';

  @override
  String get yes => 'Да';

  @override
  String get cancel => 'Отмена';

  @override
  String get accountexist => 'Пользователь уже существует.';

  @override
  String get wrongcredentials => 'Неверный пароль.';

  @override
  String get emailrequired => 'Требуется адрес электронной почты.';

  @override
  String get passwordrequired => 'Требуется пароль.';

  @override
  String get namerequired => 'Имя обязательно.';

  @override
  String get entervalidemail =>
      'Введите действительный адрес электронной почты.';

  @override
  String get passwordshouldmatch => 'Пароли должны совпадать.';

  @override
  String get mustbeatchars => 'Должно быть не менее 6 символов.';
}

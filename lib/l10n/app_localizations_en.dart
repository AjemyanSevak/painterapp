// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Painter App';

  @override
  String get loginTitle => 'Login';

  @override
  String get registration => 'Registration';

  @override
  String get login => 'Log in';

  @override
  String get name => 'Name';

  @override
  String get email => 'e-mail';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get signup => 'Sign up';

  @override
  String get gallery => 'Gallery';

  @override
  String get edit => 'Edit';

  @override
  String get newImage => 'New image';

  @override
  String get enterName => 'Enter your nane';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get yourEmail => 'Your email';

  @override
  String get passwordValidationMessage => '8-16 symbol';

  @override
  String get create => 'Create';

  @override
  String get areyousureexit => 'Are you sure you want to exit?';

  @override
  String get yes => 'Yes';

  @override
  String get cancel => 'Cancel';

  @override
  String get accountexist => 'Account already exists.';

  @override
  String get wrongcredentials => 'Incorrect email or password';

  @override
  String get emailrequired => 'Email is required.';

  @override
  String get passwordrequired => 'Password is required.';

  @override
  String get namerequired => 'Name is required.';

  @override
  String get entervalidemail => 'Please enter a valid email.';

  @override
  String get passwordshouldmatch => 'Passwords should match';

  @override
  String get mustbeatchars => 'Must be at least 6 chars';
}

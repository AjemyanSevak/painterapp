import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:painter_app/base/global_values/global_values.dart';
import 'package:painter_app/base/keys/app_keys.dart';
import 'package:painter_app/base/routes/routes.dart';
import 'package:painter_app/base/theme.dart';
import 'package:painter_app/core/injector/injector.dart' as service_locator;
import 'package:painter_app/cubit/home/home_cubit.dart';
import 'package:painter_app/cubit/locale/locale_cubit.dart';
import 'package:painter_app/cubit/painteredit/painter_edit_cubit.dart';
import 'package:painter_app/cubit/painternew/painter_new_cubit.dart';
import 'package:painter_app/firebase_options.dart';
import 'package:painter_app/l10n/app_localizations.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> setupLocalNotifications() async {
  const ios = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(iOS: ios),
  );
}

Future<void> showNotification(String title, String body) async {
  try {
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      const NotificationDetails(
        iOS: DarwinNotificationDetails(subtitle: 'Notification'),
      ),
    );
  } catch (e) {
    debugPrint('Error showing notification: $e');
  }
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // show splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await setupLocalNotifications();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // uses the right keys per platform
  );

  // Register singletons.
  service_locator.call();

  // hide splash screen
  FlutterNativeSplash.remove();

  runApp(const PainterApp());
}

class PainterApp extends StatelessWidget {
  const PainterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => PainterEditCubit()),
        BlocProvider(create: (context) => PainterNewCubit()),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Painter App',
            routerConfig: goRouter,
            scaffoldMessengerKey: AppKeys.scaffoldMessengerKey,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: supportedLocales,
            locale: localeState.locale,
            theme: AppThemes.appTheme,
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:painter_app/base/routes/rout_constants.dart';
import 'package:painter_app/models/image/image_model.dart';
import 'package:painter_app/ui/overlay/loading/home/home.dart';
import 'package:painter_app/ui/overlay/loading/login/login.dart';
import 'package:painter_app/ui/overlay/loading/painter_edit/edit_view.dart';
import 'package:painter_app/ui/overlay/loading/painter_new/create_view.dart';
import 'package:painter_app/ui/overlay/loading/registration/registration.dart';

Page<T> _platformPage<T>(BuildContext context, Widget child) {
  final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
  if (isIOS) return CupertinoPage<T>(child: child); // enables swipe-back
  return MaterialPage<T>(child: child);
}

final goRouter = GoRouter(
  initialLocation: AppRoute.login,
  routes: [
    GoRoute(
      path: AppRoute.login,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: LoginView()),
    ),
    GoRoute(
      path: AppRoute.home,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomeView()),
    ),

    // with iOS swipe-back
    GoRoute(
      path: AppRoute.registration,
      pageBuilder: (context, state) =>
          _platformPage(context, const RegistrationView()),
    ),

    GoRoute(
      path: AppRoute.painternew,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: CreateNewView()),
    ),
    GoRoute(
      path: AppRoute.painteredit,
      pageBuilder: (context, state) {
        final imageData = state.extra as ImageDoc;
        return NoTransitionPage(child: EditView(imageData: imageData));
      },
    ),
  ],
);

import 'package:go_router/go_router.dart';
import 'package:painter_app/base/routes/rout_constants.dart';
import 'package:painter_app/models/image/image_model.dart';
import 'package:painter_app/ui/overlay/loading/home/home.dart';
import 'package:painter_app/ui/overlay/loading/login/login.dart';
import 'package:painter_app/ui/overlay/loading/painter_edit/edit_view.dart';
import 'package:painter_app/ui/overlay/loading/painter_new/create_view.dart';
import 'package:painter_app/ui/overlay/loading/registration/registration.dart';

final goRouter = GoRouter(
  initialLocation: AppRoute.login,
  routes: [
    GoRoute(
      path: AppRoute.login,
      pageBuilder: (context, state) => NoTransitionPage(child: LoginView()),
    ),
    GoRoute(
      path: AppRoute.home,
      pageBuilder: (context, state) => NoTransitionPage(child: HomeView()),
    ),
    GoRoute(
      path: AppRoute.registration,
      pageBuilder: (context, state) {
        return NoTransitionPage(child: RegistrationView());
      },
    ),
    GoRoute(
      path: AppRoute.painternew,
      pageBuilder: (context, state) => NoTransitionPage(child: CreateNewView()),
    ),

    GoRoute(
      path: AppRoute.painteredit,
      pageBuilder: (context, state) {
        final imageData = (state.extra) as ImageDoc;
        return NoTransitionPage(child: EditView(imageData: imageData));
      },
    ),
  ],
);

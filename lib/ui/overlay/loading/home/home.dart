import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:painter_app/base/enums/enums.dart';
import 'package:painter_app/base/routes/rout_constants.dart';
import 'package:painter_app/base/routes/routes.dart';
import 'package:painter_app/cubit/home/home_cubit.dart';
import 'package:painter_app/l10n/app_localizations.dart';
import 'package:painter_app/ui/overlay/loading/home/widgets/header.dart';
import 'package:painter_app/ui/overlay/loading/home/widgets/image_grid_view.dart';
import 'package:painter_app/ui/overlay/loading/widgets/app_background.dart';
import 'package:painter_app/ui/overlay/loading/widgets/app_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final localeStrings = AppLocalizations.of(context)!;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              AppBackground(),
              Column(
                children: [
                  HomeHeader(),
                  Expanded(child: GalleryGrid()),
                  state.createButtonVisible
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: AppButton(
                            label: localeStrings.create,
                            onPressed: () {
                              goRouter.go(AppRoute.painternew);
                            },
                            variant: AppButtonVariant
                                .primaryGradient, // see all variants below
                            // optional
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

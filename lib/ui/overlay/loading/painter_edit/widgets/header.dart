import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:painter_app/base/base.dart';
import 'package:painter_app/base/routes/rout_constants.dart';
import 'package:painter_app/base/routes/routes.dart';
import 'package:painter_app/base/text_styles.dart';
import 'package:painter_app/cubit/painteredit/painter_edit_cubit.dart';
import 'package:painter_app/l10n/app_localizations.dart';
import 'package:painter_app/ui/overlay/loading/widgets/header_shadow.dart';
import 'package:painter_app/ui/overlay/loading/widgets/loading.dart';

class EditHeader extends StatelessWidget {
  final Function() onSave;
  const EditHeader({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final localeStrings = AppLocalizations.of(context)!;

    return BlocBuilder<PainterEditCubit, PainterEditState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 102,
          decoration: BoxDecoration(),
          child: Stack(
            children: [
              BlurredInnerShadowBox(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            overlayColor: WidgetStatePropertyAll(
                              AppColors.white.withValues(alpha: 0.2),
                            ),
                            onTap: () {
                              goRouter.go(AppRoute.home);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                AppAssets.back,
                                width: 24,
                                height: 24,
                                color: AppColors.whiter,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            localeStrings.edit,
                            style: AppTextStyles.bodyLargeMedium.copyWith(
                              fontSize: 17,
                              color: AppColors.whiter,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            overlayColor: WidgetStatePropertyAll(
                              AppColors.white.withValues(alpha: 0.2),
                            ),
                            onTap: () {
                              onSave.call();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: state.isLoading
                                  ? AppLoading(size: 24)
                                  : Image.asset(
                                      AppAssets.done,
                                      width: 24,
                                      height: 24,
                                      color: AppColors.whiter,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

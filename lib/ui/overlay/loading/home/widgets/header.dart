import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:painter_app/base/base.dart';
import 'package:painter_app/base/routes/rout_constants.dart';
import 'package:painter_app/base/routes/routes.dart';
import 'package:painter_app/base/text_styles.dart';
import 'package:painter_app/cubit/home/home_cubit.dart';
import 'package:painter_app/l10n/app_localizations.dart';
import 'package:painter_app/ui/overlay/loading/widgets/header_shadow.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final localeStrings = AppLocalizations.of(context)!;

    return BlocBuilder<HomeCubit, HomeState>(
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
                            onTap: () async {
                              bool exit = await _onWillPop(context);
                              if (exit) {
                                // ignore: use_build_context_synchronously
                                goRouter.go(AppRoute.login);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                AppAssets.exit,
                                width: 24,
                                height: 24,
                                color: AppColors.red,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            localeStrings.gallery,
                            style: AppTextStyles.bodyLargeMedium.copyWith(
                              fontSize: 17,
                              color: AppColors.whiter,
                            ),
                          ),
                        ),
                        state.createButtonVisible
                            ? SizedBox(width: 34)
                            : Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  overlayColor: WidgetStatePropertyAll(
                                    AppColors.white.withValues(alpha: 0.2),
                                  ),
                                  onTap: () {
                                    goRouter.go(AppRoute.painternew);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      AppAssets.createnew,
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

  Future<bool> _onWillPop(BuildContext context) async {
    final shouldExit = await showExitPopup(context);
    return shouldExit ?? false;
  }

  Future<bool?> showExitPopup(BuildContext context) async {
    final localeStrings = AppLocalizations.of(context)!;
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // must choose an option
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.black,
        title: Text(
          localeStrings.areyousureexit,
          style: AppTextStyles.bodyLargeRegular.copyWith(
            color: AppColors.whiter,
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          // ✅ YES button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(true); // return true
            },
            child: Text(
              localeStrings.yes,
              style: TextStyle(color: AppColors.white),
            ),
          ),

          // ❌ CLOSE button
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.whiter),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(false); // return false
            },
            child: Text(
              localeStrings.cancel,
              style: TextStyle(color: AppColors.whiter),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:painter_app/base/colors/app_colors.dart';
import 'package:painter_app/base/enums/enums.dart';
import 'package:painter_app/base/routes/rout_constants.dart';
import 'package:painter_app/base/routes/routes.dart';
import 'package:painter_app/base/text_styles.dart';
import 'package:painter_app/core/resources/response_state.dart';
import 'package:painter_app/cubit/login/login_cubit.dart';
import 'package:painter_app/l10n/app_localizations.dart';
import 'package:painter_app/ui/overlay/loading/widgets/app_background.dart';
import 'package:painter_app/ui/overlay/loading/widgets/app_button.dart';
import 'package:painter_app/ui/overlay/loading/widgets/reactiv_input.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final localeStrings = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                AppBackground(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: ReactiveForm(
                      formGroup: state.loginForm.formGroup,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 250),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                localeStrings.loginTitle,
                                style: AppTextStyles.h6.copyWith(
                                  color: AppColors.whiter,
                                  fontFamily: "PressStart2P",
                                  shadows: [
                                    Shadow(
                                      color: AppColors.primary,
                                      blurRadius: 28,
                                      offset: Offset(0, 0),
                                    ),
                                    Shadow(
                                      color: AppColors.primary,
                                      blurRadius: 28 * 0.66,
                                      offset: Offset(0, 0),
                                    ),
                                    Shadow(
                                      color: AppColors.primary,
                                      blurRadius: 28 * 0.33,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              ReactiveImput(
                                formControl: state.loginForm.emailControl,
                                hint: localeStrings.email,
                                requiredMessage: localeStrings.emailrequired,
                                fillColor: AppColors.black,
                                obscureText: false,
                                context: context,
                              ),
                              SizedBox(height: 20),
                              ReactiveImput(
                                context: context,
                                formControl: state.loginForm.passwordControl,
                                hint: localeStrings.password,
                                requiredMessage: localeStrings.passwordrequired,
                                fillColor: AppColors.black,
                                obscureText: true,
                              ),
                            ],
                          ),
                          SizedBox(height: 140),
                          Column(
                            children: [
                              AppButton(
                                label: localeStrings.login,
                                onPressed: () async {
                                  if (state.loginForm.validate()) {
                                    var dataSuccess = await context
                                        .read<LoginCubit>()
                                        .login(
                                          state.loginForm.emailControl.value!,
                                          state
                                              .loginForm
                                              .passwordControl
                                              .value!,
                                        );

                                    if (dataSuccess.data != null) {
                                      goRouter.go(AppRoute.home);
                                    } else {
                                      final errorMessage =
                                          (dataSuccess as DataFailed)
                                              .exception
                                              ?.message;
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            errorMessage ?? 'Login failed',
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    state.loginForm.formGroup
                                        .markAllAsTouched();
                                  }
                                },
                                variant: AppButtonVariant
                                    .primaryGradient, // see all variants below
                                // optional
                                showLoading: state.isLoading,
                                loadingColor: AppColors.whiter,
                              ),
                              SizedBox(height: 19),
                              AppButton(
                                label: localeStrings.registration,
                                onPressed: () {
                                  goRouter.push(AppRoute.registration);
                                },
                                variant: AppButtonVariant
                                    .primaryLight, // see all variants below
                                // optional
                                showLoading: false,
                                loadingColor: AppColors.primary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

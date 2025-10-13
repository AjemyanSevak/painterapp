import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:painter_app/base/colors/app_colors.dart';
import 'package:painter_app/base/enums/enums.dart';
import 'package:painter_app/base/routes/rout_constants.dart';
import 'package:painter_app/base/routes/routes.dart';
import 'package:painter_app/base/text_styles.dart';
import 'package:painter_app/core/resources/response_state.dart';
import 'package:painter_app/cubit/registration/registration_cubit.dart';
import 'package:painter_app/l10n/app_localizations.dart';
import 'package:painter_app/ui/overlay/loading/widgets/app_background.dart';
import 'package:painter_app/ui/overlay/loading/widgets/app_button.dart';
import 'package:painter_app/ui/overlay/loading/widgets/reactiv_input.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final localeStrings = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => RegistrationCubit(),
      child: BlocBuilder<RegistrationCubit, RegistrationState>(
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
                      formGroup: state.registrationForm.formGroup,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 250),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                localeStrings.registration,
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
                                formControl: state.registrationForm.nameControl,
                                hint: localeStrings.name,
                                requiredMessage: localeStrings.namerequired,
                                fillColor: AppColors.black,
                                obscureText: false,
                                context: context,
                              ),
                              SizedBox(height: 20),
                              ReactiveImput(
                                formControl:
                                    state.registrationForm.emailControl,
                                hint: localeStrings.email,
                                requiredMessage: localeStrings.emailrequired,
                                fillColor: AppColors.black,
                                obscureText: false,
                                context: context,
                              ),
                              SizedBox(height: 20),
                              ReactiveImput(
                                context: context,
                                formControl:
                                    state.registrationForm.passwordControl,
                                hint: localeStrings.password,
                                requiredMessage: localeStrings.passwordrequired,
                                passwordCustomKeyMessage:
                                    localeStrings.mustbeatchars,
                                fillColor: AppColors.black,
                                obscureText: true,
                              ),
                              SizedBox(height: 20),
                              ReactiveImput(
                                context: context,
                                formControl: state
                                    .registrationForm
                                    .confirmPasswordControl,
                                hint: localeStrings.confirmPassword,
                                passwordCustomKeyMessage:
                                    localeStrings.mustbeatchars,
                                requiredMessage: localeStrings.passwordrequired,
                                fillColor: AppColors.black,
                                obscureText: true,
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          Column(
                            children: [
                              ReactiveFormConsumer(
                                builder: (context, form, child) {
                                  return AppButton(
                                    label: localeStrings.signup,
                                    onPressed: form.valid
                                        ? () async {
                                            var dataSuccess = await context
                                                .read<RegistrationCubit>()
                                                .register(
                                                  state
                                                      .registrationForm
                                                      .emailControl
                                                      .value!,
                                                  state
                                                      .registrationForm
                                                      .passwordControl
                                                      .value!,
                                                );

                                            if (dataSuccess.data != null) {
                                              // Registration successful, navigate to home
                                              goRouter.go(AppRoute.home);
                                            } else {
                                              final errorMessage =
                                                  (dataSuccess as DataFailed)
                                                      .exception
                                                      ?.message;
                                              ScaffoldMessenger.of(
                                                // ignore: use_build_context_synchronously
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    errorMessage ??
                                                        'Login failed',
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        : null,

                                    variant: form.valid
                                        ? AppButtonVariant.primaryLight
                                        : AppButtonVariant
                                              .neutral, // see all variants below
                                    // optional
                                    showLoading: state.isLoading,
                                    loadingColor: AppColors.primary,
                                  );
                                },
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

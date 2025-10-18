import 'package:flutter/material.dart';
import 'package:painter_app/base/base.dart';
import 'package:painter_app/l10n/app_localizations.dart';
import 'package:painter_app/ui/overlay/loading/widgets/inner_shadow_bg.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveImput extends StatelessWidget {
  final FormControl<String> formControl;
  final String hint;
  final Color fillColor;
  final bool obscureText;
  final BuildContext context;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  final String? requiredMessage;
  final String? passwordCustomKeyMessage;

  const ReactiveImput({
    super.key,
    required this.context,
    required this.formControl,
    this.hint = '',
    this.fillColor = Colors.transparent,
    this.obscureText = false,
    this.requiredMessage = '',
    this.passwordCustomKeyMessage = '',
    required this.keyboardType,
    required this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    final localeStrings = AppLocalizations.of(context)!;
    return SizedBox(
      height: 78,
      width: 350,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            InnerShadowBg(),
            // Content
            Container(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      child: ReactiveTextField<String>(
                        obscureText: obscureText,
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        formControl: formControl,
                        cursorColor: Colors.white70,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          height: 1.3,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          labelText: hint,
                          labelStyle: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                          hintText: hint,
                          hintStyle: TextStyle(
                            color: AppColors.whiter.withValues(alpha: 0.6),
                            fontSize: 16,
                          ),
                          contentPadding: const EdgeInsets.only(
                            top: 8,
                            bottom: 6,
                          ),
                        ),
                        validationMessages: {
                          ValidationMessage.required: (_) =>
                              requiredMessage ?? 'required',
                          // match the error key you used above:
                          'passwordComplexity': (_) =>
                              passwordCustomKeyMessage ?? '',

                          ValidationMessage.email: (_) =>
                              localeStrings.entervalidemail,

                          ValidationMessage.mustMatch: (_) =>
                              localeStrings.password,
                        },
                        keyboardType: keyboardType,
                        textInputAction: textInputAction,
                      ),
                    ),
                  ),
                  // Thin divider
                  Container(
                    height: 1,
                    margin: const EdgeInsets.only(top: 6, left: 16, right: 16),
                    color: AppColors.whiter.withValues(alpha: 0.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

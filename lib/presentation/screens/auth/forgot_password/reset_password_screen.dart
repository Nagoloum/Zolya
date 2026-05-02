import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/i18n/locale_provider.dart';
import '../../../../core/i18n/localized_validators.dart';
import '../../../../theme/zolya_theme.dart';
import '../../../widgets/zolya/zolya.dart';
import 'widgets/auth_page_header.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.phone,
    required this.code,
  });

  final String phone;
  final String code;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.hideKeyboard();

    final l = context.l10n;
    ZolyaSuccessDialog.show(
      context,
      title: l.passwordChangedTitle,
      message: l.passwordChangedMessage,
      buttonLabel: l.passwordChangedCta,
      onConfirm: () => context.go(RouteNames.login),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final v = LocalizedValidators(l);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const ZolyaTopBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ZolyaSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: ZolyaSpacing.lg),
              AuthPageHeader(
                title: l.resetPasswordTitle,
                intro: l.resetPasswordIntro,
              ),
              const SizedBox(height: ZolyaSpacing.xxl),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ZolyaTextField(
                      label: l.newPasswordLabel,
                      placeholder: l.passwordHint,
                      controller: _passwordCtrl,
                      validator: v.password,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      leading: const Icon(LucideIcons.lock, size: 16),
                    ),
                    const SizedBox(height: 18),
                    ZolyaTextField(
                      label: l.confirmPasswordLabel,
                      placeholder: l.passwordHint,
                      controller: _confirmCtrl,
                      validator: (val) =>
                          v.confirmPassword(val, _passwordCtrl.text),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      leading: const Icon(LucideIcons.lock, size: 16),
                      onSubmitted: (_) => _submit(),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 350.ms),
              const Spacer(),
              ZolyaButton(
                label: l.continueLabel,
                onPressed: _submit,
                expand: true,
                size: ZolyaButtonSize.lg,
              ),
              const SizedBox(height: ZolyaSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}

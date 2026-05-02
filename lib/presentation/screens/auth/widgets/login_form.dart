import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/i18n/locale_provider.dart';
import '../../../../core/i18n/localized_validators.dart';
import '../../../widgets/zolya/zolya.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.passwordController,
    this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final v = LocalizedValidators(l);
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ZolyaPhoneField(
            label: l.phoneLabel,
            placeholder: l.phoneHint,
            controller: phoneController,
            validator: v.phone,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 18),
          ZolyaTextField(
            label: l.passwordLabel,
            placeholder: l.passwordHint,
            controller: passwordController,
            validator: v.password,
            obscureText: true,
            textInputAction: TextInputAction.done,
            leading: const Icon(LucideIcons.lock, size: 16),
            onSubmitted: (_) => onSubmit?.call(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/i18n/locale_provider.dart';
import '../../../../core/i18n/localized_validators.dart';
import '../../../../theme/zolya_theme.dart';
import '../../../widgets/zolya/zolya.dart';
import 'widgets/auth_page_header.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.hideKeyboard();

    context.go(
        '${RouteNames.forgotPasswordCode}?phone=${_phoneCtrl.text.trim()}');
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
              AuthPageHeader(title: l.forgotTitle, intro: l.forgotIntro),
              const SizedBox(height: ZolyaSpacing.xxl),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ZolyaPhoneField(
                  label: l.phoneLabel,
                  placeholder: l.phoneHint,
                  controller: _phoneCtrl,
                  validator: v.phone,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submit(),
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 350.ms),
              const Spacer(),
              ZolyaButton(
                label: l.forgotSendCode,
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

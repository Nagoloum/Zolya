import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/i18n/locale_provider.dart';
import '../../../../theme/zolya_theme.dart';
import '../../../widgets/zolya/zolya.dart';
import 'widgets/auth_page_header.dart';

class ResetCodeScreen extends StatefulWidget {
  const ResetCodeScreen({super.key, required this.phone});
  final String phone;

  @override
  State<ResetCodeScreen> createState() => _ResetCodeScreenState();
}

class _ResetCodeScreenState extends State<ResetCodeScreen> {
  static const _codeLength = 5;
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_controller.text.length != _codeLength) {
      context.showErrorSnackBar(context.l10n.errorOtpInvalid);
      return;
    }
    context.hideKeyboard();
    context.go(
      '${RouteNames.forgotPasswordReset}?phone=${widget.phone}&code=${_controller.text}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;

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
                title: l.resetCodeTitle,
                intro: '${l.resetCodeIntro} (+237 ${widget.phone}).',
              ),
              const SizedBox(height: ZolyaSpacing.xxl),
              Center(
                child: ZolyaOtpInput(
                  length: _codeLength,
                  controller: _controller,
                  onCompleted: (_) => _submit(),
                ),
              )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 350.ms)
                  .slideY(begin: 0.1, end: 0, duration: 350.ms),
              const SizedBox(height: ZolyaSpacing.xl),
              const _ResendRow(),
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

class _ResendRow extends StatefulWidget {
  const _ResendRow();

  @override
  State<_ResendRow> createState() => _ResendRowState();
}

class _ResendRowState extends State<_ResendRow> {
  static const _cooldownSeconds = 30;
  Timer? _timer;
  int _remaining = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _resend() {
    if (_remaining > 0) return;
    // FakeData phase: pas de backend, on confirme l'envoi et on démarre le cooldown.
    context.showSnackBar(context.l10n.resetCodeResent);
    setState(() => _remaining = _cooldownSeconds);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _remaining--);
      if (_remaining <= 0) timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final waiting = _remaining > 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${l.resetCodeResendQuestion} ',
          style: ZolyaTypography.body.copyWith(color: mutedColor),
        ),
        GestureDetector(
          onTap: waiting ? null : _resend,
          child: Text(
            waiting ? l.resendCodeIn(_remaining) : l.resetCodeResendLink,
            style: ZolyaTypography.body.copyWith(
              color: waiting ? mutedColor : theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

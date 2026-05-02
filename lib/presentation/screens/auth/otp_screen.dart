import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/zolya/zolya.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phone});
  final String phone;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _controller = TextEditingController();

  void _submit() {
    if (_controller.text.length != AppConstants.otpLength) {
      context.showErrorSnackBar(context.l10n.errorOtpInvalid);
      return;
    }
    context.read<AuthBloc>().add(
          AuthVerifyOtpRequested(phone: widget.phone, code: _controller.text),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go(RouteNames.marketplace);
        } else if (state is AuthFailureState) {
          context.showErrorSnackBar(state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final l = context.l10n;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const ZolyaTopBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(ZolyaSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: ZolyaSpacing.xl),
                  Text(
                    l.otpTitle,
                    style: ZolyaTypography.displayMedium.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ).animate().fadeIn(duration: 300.ms),
                  const SizedBox(height: ZolyaSpacing.sm),
                  Builder(builder: (context) {
                    final theme = Theme.of(context);
                    final isLight = theme.brightness == Brightness.light;
                    final mutedColor = isLight
                        ? ZolyaColors.texte2
                        : ZolyaColors.texte2Dark;
                    return Text(
                      '${l.otpSentTo} +237 ${widget.phone}.',
                      style:
                          ZolyaTypography.body.copyWith(color: mutedColor),
                    ).animate().fadeIn(delay: 100.ms, duration: 300.ms);
                  }),
                  const SizedBox(height: ZolyaSpacing.xxl),
                  Center(
                    child: ZolyaOtpInput(
                      length: AppConstants.otpLength,
                      controller: _controller,
                      onCompleted: (_) => _submit(),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 350.ms)
                      .slideY(begin: 0.1, end: 0, duration: 350.ms),
                  const SizedBox(height: ZolyaSpacing.xl),
                  Center(
                    child: ZolyaButton(
                      variant: ZolyaButtonVariant.ghost,
                      label: l.otpResend,
                      onPressed: isLoading
                          ? null
                          : () => context
                              .read<AuthBloc>()
                              .add(AuthSendOtpRequested(phone: widget.phone)),
                    ),
                  ),
                  const Spacer(),
                  ZolyaButton(
                    label: l.otpVerify,
                    onPressed: isLoading ? null : _submit,
                    loading: isLoading,
                    expand: true,
                    size: ZolyaButtonSize.lg,
                  ),
                  const SizedBox(height: ZolyaSpacing.lg),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

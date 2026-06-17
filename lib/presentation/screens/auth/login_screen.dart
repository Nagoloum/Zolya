import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/zolya/zolya.dart';
import 'widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.hideKeyboard();
    context.read<AuthBloc>().add(AuthLoginRequested(
          phone: _phoneCtrl.text.trim(),
          password: _passwordCtrl.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // Revenir à la page demandée avant le guard, sinon marketplace.
          final from = GoRouterState.of(context).uri.queryParameters['from'];
          context.go(
            from != null && from.isNotEmpty
                ? Uri.decodeComponent(from)
                : RouteNames.marketplace,
          );
        } else if (state is AuthFailureState) {
          context.showErrorSnackBar(state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(ZolyaSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: ZolyaSpacing.xxxl),
                  Text(
                    l.loginTitle,
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
                      l.loginSubtitle,
                      style:
                          ZolyaTypography.body.copyWith(color: mutedColor),
                    ).animate().fadeIn(delay: 100.ms, duration: 300.ms);
                  }),
                  const SizedBox(height: ZolyaSpacing.xxl),
                  LoginForm(
                    formKey: _formKey,
                    phoneController: _phoneCtrl,
                    passwordController: _passwordCtrl,
                    onSubmit: _submit,
                  ).animate().fadeIn(delay: 200.ms, duration: 350.ms),
                  const SizedBox(height: ZolyaSpacing.md),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => context.push(RouteNames.forgotPassword),
                      child: Text(
                        l.forgotPassword,
                        style: ZolyaTypography.bodySmall.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: ZolyaSpacing.xl),
                  ZolyaButton(
                    label: l.loginCta,
                    onPressed: isLoading ? null : _submit,
                    loading: isLoading,
                    expand: true,
                    size: ZolyaButtonSize.lg,
                  ),
                  const SizedBox(height: ZolyaSpacing.xl),
                  ZolyaDivider(label: l.dividerOr),
                  const SizedBox(height: ZolyaSpacing.lg),
                  ZolyaSocialButton(
                    provider: ZolyaSocialProvider.google,
                    label: l.signInWithGoogle,
                    onPressed: () =>
                        context.showSnackBar(l.featureComingSoon),
                  ),
                  const SizedBox(height: ZolyaSpacing.sm),
                  ZolyaSocialButton(
                    provider: ZolyaSocialProvider.apple,
                    label: l.signInWithApple,
                    onPressed: () =>
                        context.showSnackBar(l.featureComingSoon),
                  ),
                  const SizedBox(height: ZolyaSpacing.xl),
                  _SignUpLink(onTap: () => context.push(RouteNames.register)),
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

class _SignUpLink extends StatelessWidget {
  const _SignUpLink({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l.noAccount,
          style: ZolyaTypography.body.copyWith(color: mutedColor),
        ),
        const SizedBox(width: ZolyaSpacing.xs),
        GestureDetector(
          onTap: onTap,
          child: Text(
            l.signUp,
            style: ZolyaTypography.body.copyWith(
              color: scheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

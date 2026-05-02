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
import '../../widgets/common/legal_text.dart';
import '../../widgets/zolya/zolya.dart';
import 'widgets/register_footer.dart';
import 'widgets/register_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.hideKeyboard();
    context.read<AuthBloc>().add(AuthRegisterRequested(
          fullName: _fullNameCtrl.text.trim(),
          phone: _phoneCtrl.text.trim(),
          password: _passwordCtrl.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpSent) {
          context.go('${RouteNames.otp}?phone=${state.phone}');
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
                  const SizedBox(height: ZolyaSpacing.xl),
                  Text(
                    l.registerTitle,
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
                      l.registerSubtitle,
                      style:
                          ZolyaTypography.body.copyWith(color: mutedColor),
                    ).animate().fadeIn(delay: 100.ms, duration: 300.ms);
                  }),
                  const SizedBox(height: ZolyaSpacing.xxl),
                  RegisterForm(
                    formKey: _formKey,
                    fullNameController: _fullNameCtrl,
                    phoneController: _phoneCtrl,
                    passwordController: _passwordCtrl,
                    onSubmit: _submit,
                  ).animate().fadeIn(delay: 200.ms, duration: 350.ms),
                  const SizedBox(height: ZolyaSpacing.lg),
                  LegalText(
                    prefix: l.legalPrefix,
                    links: [
                      LegalLink(
                        label: l.legalTermsLink,
                        onTap: () => context.push(RouteNames.legalTerms),
                      ),
                      LegalLink(
                        label: l.legalPrivacyLink,
                        onTap: () => context.push(RouteNames.legalPrivacy),
                      ),
                    ],
                    suffix: l.legalSuffix,
                    trailingLink: LegalLink(
                      label: l.legalCookiesLink,
                      onTap: () => context.push(RouteNames.legalCookies),
                    ),
                  ),
                  const SizedBox(height: ZolyaSpacing.xl),
                  ZolyaButton(
                    label: l.registerCta,
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
                    label: l.signUpWithGoogle,
                    onPressed: () {},
                  ),
                  const SizedBox(height: ZolyaSpacing.sm),
                  ZolyaSocialButton(
                    provider: ZolyaSocialProvider.apple,
                    label: l.signUpWithApple,
                    onPressed: () {},
                  ),
                  const SizedBox(height: ZolyaSpacing.xl),
                  RegisterFooter(onLoginTap: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(RouteNames.login);
                    }
                  }),
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

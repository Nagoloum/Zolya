import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/zolya/zolya.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _bioCtrl = TextEditingController();
  final _cityCtrl = TextEditingController(text: 'Douala');
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<AuthBloc>().state;
    if (state is AuthAuthenticated) {
      _nameCtrl.text = state.user.fullName;
      _emailCtrl.text = state.user.email ?? '';
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _bioCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.editProfileSaved)),
    );
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final mutedColor = isLight ? ZolyaColors.texte2 : ZolyaColors.texte2Dark;
    final l = context.l10n;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state is AuthAuthenticated ? state.user : null;
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: ZolyaTopBar(
            title: l.editProfileTitle,
            centerTitle: true,
          ),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(ZolyaSpacing.lg),
                children: [
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ZolyaAvatar(
                          name: user?.fullName ?? '—',
                          imageUrl: user?.avatarUrl,
                          size: ZolyaAvatarSize.xl,
                        ),
                        Positioned(
                          right: -2,
                          bottom: -2,
                          child: Material(
                            color: scheme.primary,
                            shape: const CircleBorder(),
                            child: InkWell(
                              onTap: () {},
                              customBorder: const CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(ZolyaSpacing.sm),
                                child: Icon(
                                  LucideIcons.camera,
                                  size: 16,
                                  color: scheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: ZolyaSpacing.xl),
                  _SectionHeader(
                      text: l.editProfileSection, mutedColor: mutedColor),
                  const SizedBox(height: ZolyaSpacing.sm),
                  ZolyaTextField(
                    controller: _nameCtrl,
                    label: l.editProfileFullName,
                    placeholder: l.editProfileFullNameHint,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? l.editProfileFieldRequired
                        : null,
                  ),
                  const SizedBox(height: ZolyaSpacing.md),
                  ZolyaTextField(
                    label: l.editProfilePhone,
                    initialValue: user?.phone ?? '',
                    enabled: false,
                  ),
                  const SizedBox(height: ZolyaSpacing.md),
                  ZolyaTextField(
                    controller: _emailCtrl,
                    label: l.editProfileEmail,
                    placeholder: l.editProfileEmailHint,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: ZolyaSpacing.md),
                  ZolyaTextField(
                    controller: _cityCtrl,
                    label: l.editProfileCity,
                    placeholder: l.editProfileCityHint,
                  ),
                  const SizedBox(height: ZolyaSpacing.md),
                  ZolyaTextarea(
                    controller: _bioCtrl,
                    label: l.editProfileBio,
                    placeholder: l.editProfileBioHint,
                    maxLength: 240,
                  ),
                  const SizedBox(height: ZolyaSpacing.xl),
                  ZolyaButton(
                    label: l.commonSave,
                    onPressed: _saving ? null : _save,
                    loading: _saving,
                    expand: true,
                    size: ZolyaButtonSize.lg,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.text, required this.mutedColor});
  final String text;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: ZolyaSpacing.xs),
      child: Text(
        text.toUpperCase(),
        style: ZolyaTypography.label.copyWith(
          color: mutedColor,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

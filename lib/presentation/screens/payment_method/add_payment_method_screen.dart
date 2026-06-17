import 'package:flutter/material.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../core/i18n/localized_validators.dart';
import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';
import 'widgets/payment_tile.dart';

class AddPaymentResult {
  const AddPaymentResult({required this.provider, required this.phone});
  final MomoProvider provider;
  final String phone;
}

class AddPaymentMethodScreen extends StatefulWidget {
  const AddPaymentMethodScreen({super.key});

  @override
  State<AddPaymentMethodScreen> createState() => _AddPaymentMethodScreenState();
}

class _AddPaymentMethodScreenState extends State<AddPaymentMethodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();
  MomoProvider _provider = MomoProvider.mtn;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    context.hideKeyboard();
    final l = context.l10n;
    await ZolyaSuccessDialog.show(
      context,
      title: l.paymentAddedTitle,
      message: l.paymentAddedMessage,
      buttonLabel: l.addressThanks,
      onConfirm: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop(AddPaymentResult(
          provider: _provider,
          phone: _phoneCtrl.text.trim(),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final v = LocalizedValidators(l);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: ZolyaTopBar(title: l.paymentNewAccount, centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l.paymentProviderLabel,
                  style: ZolyaTypography.body
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                ZolyaSegmentedControl<MomoProvider>(
                  value: _provider,
                  segments: [
                    ZolyaSegment(
                        value: MomoProvider.mtn, label: l.paymentMethodMtn),
                    ZolyaSegment(
                        value: MomoProvider.orange,
                        label: l.paymentMethodOrange),
                  ],
                  onChanged: (p) => setState(() => _provider = p),
                ),
                const SizedBox(height: ZolyaSpacing.xl),
                ZolyaPhoneField(
                  label: l.paymentPhoneLabel,
                  placeholder: l.phoneHint,
                  controller: _phoneCtrl,
                  validator: v.phone,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submit(),
                ),
                const Spacer(),
                ZolyaAsyncButton(
                  label: l.paymentAddCta,
                  onPressed: _submit,
                  expand: true,
                  size: ZolyaButtonSize.lg,
                ),
                const SizedBox(height: ZolyaSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

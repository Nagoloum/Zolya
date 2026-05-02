import 'package:flutter/material.dart';

import '../../../core/i18n/locale_provider.dart';
import 'widgets/legal_scaffold.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LegalScaffold(
      title: context.l10n.privacyScreenTitle,
      lastUpdated: 'April 18, 2026',
      intro:
          'This policy describes how Zolya collects, uses, and protects your personal data '
          'when you use our application.',
      sections: const [
        LegalSection(
          title: '1. Data we collect',
          paragraphs: [
            'At signup we collect: full name, phone number, delivery address, and photos of your items.',
            'We also collect technical data: device model, OS version, connection logs.',
          ],
        ),
        LegalSection(
          title: '2. How we use your data',
          paragraphs: [
            'Your data is used to: create and manage your account, process orders, secure payments, and send you notifications related to your orders.',
            'We never sell your personal data to third parties.',
          ],
        ),
        LegalSection(
          title: '3. Sharing with third parties',
          paragraphs: [
            'Some information (address, phone) is shared with the delivery courier assigned to your order so the delivery can proceed.',
            'Mobile Money payments go through our trusted providers (MTN, Orange) who apply their own policies.',
          ],
        ),
        LegalSection(
          title: '4. Data retention',
          paragraphs: [
            'Your data is kept while your account is active. You may request data deletion at any time by contacting us.',
          ],
        ),
        LegalSection(
          title: '5. Security',
          paragraphs: [
            'Your passwords are hashed. Communications with our servers are protected via HTTPS.',
            'Authentication tokens are stored in a secure area on your device.',
          ],
        ),
        LegalSection(
          title: '6. Your rights',
          paragraphs: [
            'You have the right to access, rectify, and delete your personal data. Contact us to exercise these rights.',
          ],
        ),
        LegalSection(
          title: '7. Contact',
          paragraphs: [
            'For any question regarding your personal data: privacy@zolya.cm.',
          ],
        ),
      ],
    );
  }
}

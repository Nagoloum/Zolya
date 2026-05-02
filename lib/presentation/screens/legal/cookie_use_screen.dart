import 'package:flutter/material.dart';

import '../../../core/i18n/locale_provider.dart';
import 'widgets/legal_scaffold.dart';

class CookieUseScreen extends StatelessWidget {
  const CookieUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LegalScaffold(
      title: context.l10n.cookiesScreenTitle,
      lastUpdated: 'April 18, 2026',
      intro:
          'Zolya uses local storage technologies to improve your user experience. '
          'This page explains what is stored on your device and why.',
      sections: const [
        LegalSection(
          title: '1. What is a cookie?',
          paragraphs: [
            'On mobile, we do not use cookies in the classic web sense but equivalent mechanisms: local SharedPreferences and secure storage.',
            'These mechanisms allow the app to remember your session and preferences.',
          ],
        ),
        LegalSection(
          title: '2. Data stored locally',
          paragraphs: [
            'Authentication token (stored securely) to keep your session active.',
            'Display preferences (theme, language, notifications).',
            'Cache of images and viewed listings to speed up the app.',
          ],
        ),
        LegalSection(
          title: '3. Analytics',
          paragraphs: [
            'We use anonymized analytics services to understand how the app is used and to improve it.',
            'No personally identifiable data is sent to these services.',
          ],
        ),
        LegalSection(
          title: '4. Manage your preferences',
          paragraphs: [
            'You can clear local data at any time by uninstalling the app or logging out from the settings.',
          ],
        ),
        LegalSection(
          title: '5. Contact',
          paragraphs: [
            'For any question: privacy@zolya.cm.',
          ],
        ),
      ],
    );
  }
}

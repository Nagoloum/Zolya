import 'package:flutter/material.dart';

import '../../../core/i18n/locale_provider.dart';
import 'widgets/legal_scaffold.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LegalScaffold(
      title: context.l10n.termsScreenTitle,
      lastUpdated: 'April 18, 2026',
      intro:
          'Welcome to Zolya. By using our application, you agree to the following terms. '
          'Please read them carefully before creating an account or listing an item.',
      sections: const [
        LegalSection(
          title: '1. Acceptance of terms',
          paragraphs: [
            'By creating a Zolya account, you confirm that you are at least 18 years old and agree to comply with all of these terms.',
            'If you do not accept these terms, please do not use the application.',
          ],
        ),
        LegalSection(
          title: '2. Nature of the service',
          paragraphs: [
            'Zolya is a C2C marketplace connecting buyers and sellers of second-hand clothing in Douala, Cameroon.',
            'Zolya acts as a trusted intermediary: payments are held in escrow until the parcel is delivered.',
          ],
        ),
        LegalSection(
          title: '3. Seller obligations',
          paragraphs: [
            'Sellers warrant that listed items are legally owned, accurately described, and do not violate any law.',
            'Each listing must include authentic photos and a short video of the item.',
          ],
        ),
        LegalSection(
          title: '4. Buyer obligations',
          paragraphs: [
            'Buyers agree to pay via Mobile Money (MTN or Orange) and to be available for delivery within the agreed timeframe.',
          ],
        ),
        LegalSection(
          title: '5. Commission and payments',
          paragraphs: [
            'Zolya deducts a 15% commission on every sale made through the app, charged after delivery is confirmed.',
            'Delivery partners are paid per completed delivery on a weekly basis.',
          ],
        ),
        LegalSection(
          title: '6. Disputes',
          paragraphs: [
            'In case of a dispute (non-conforming item, parcel not received), users can open a report in the app. Zolya will review evidence and settle the dispute within a reasonable timeframe.',
          ],
        ),
        LegalSection(
          title: '7. Termination',
          paragraphs: [
            'Zolya reserves the right to suspend or delete any account that does not comply with these terms or engages in fraudulent behavior.',
          ],
        ),
        LegalSection(
          title: '8. Contact',
          paragraphs: [
            'For any question regarding these terms, please contact support@zolya.cm.',
          ],
        ),
      ],
    );
  }
}

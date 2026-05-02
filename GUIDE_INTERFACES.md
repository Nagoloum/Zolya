# Guide Zolya — Interfaces, Style & Création de Pages

Ce guide explique comment retrouver, modifier et créer des écrans dans le projet Flutter Zolya.

---

## 1. Architecture des dossiers

Tout le code applicatif est dans [lib/](lib/). Architecture **Clean Architecture + BLoC**.

```
lib/
├── main.dart                   → point d'entrée Flutter
├── app.dart                    → ZolyaApp (MaterialApp + GoRouter + BlocProviders globaux)
├── config/
│   ├── env.dart                → variables d'env (URLs API, clés)
│   └── routes/
│       ├── app_router.dart     → définition GoRouter (toutes les routes)
│       └── route_names.dart    → constantes de chemins ('/login', '/profile', ...)
├── core/
│   ├── constants/              → constantes globales (zones livraison, etc.)
│   ├── di/                     → injection de dépendances (get_it)
│   ├── errors/                 → Failures + Exceptions
│   ├── extensions/             → ContextExtensions (theme, snackbar, keyboard)
│   ├── i18n/                   → traductions FR/EN (app_strings_fr.dart / _en.dart)
│   ├── mixins/
│   ├── network/                → ApiClient (Dio), endpoints
│   ├── usecases/               → UseCase<Output, Params>
│   └── utils/                  → Formatters, Validators
├── data/
│   ├── fake/                   → fake_data.dart (mocks UI), ui_models.dart
│   ├── models/                 → DTOs (fromJson/toJson)
│   └── repositories/           → implémentations concrètes des repos
├── domain/
│   ├── entities/               → user.dart, product.dart, order.dart, ...
│   ├── repositories/           → interfaces (abstract class)
│   └── usecases/               → cas d'usage métier (auth, product, orders)
├── presentation/
│   ├── bloc/                   → 1 dossier par feature (auth, product, orders…)
│   │   └── <feature>/          → <feature>_bloc.dart, _event.dart, _state.dart
│   ├── screens/                → ⭐ TOUTES LES INTERFACES sont ici
│   │   └── <feature>/          → <feature>_screen.dart + sous-dossier widgets/
│   └── widgets/
│       ├── common/             → widgets partagés non-Zolya (ex: filter_bottom_sheet)
│       ├── product/            → widgets liés au produit
│       ├── order/              → widgets liés aux commandes
│       └── zolya/              → ⭐ DESIGN SYSTEM (boutons, inputs, cards, etc.)
├── services/                   → local_storage, payment, notification
└── theme/
    ├── zolya_theme.dart        → ⭐ COULEURS, TYPOGRAPHIE, SPACING, RADIUS
    └── zolya_shad_theme.dart   → thème shadcn_ui synchronisé sur Zolya
```

---

## 2. Où sont les interfaces ?

**Tous les écrans sont dans [lib/presentation/screens/](lib/presentation/screens/)**, organisés par feature :

| Dossier | Écran principal |
|---|---|
| `splash/` | [splash_screen.dart](lib/presentation/screens/splash/splash_screen.dart) — splash de démarrage |
| `get_started/` | écran d'accueil (avant login) |
| `auth/` | login, register, otp, forgot_password/ |
| `home/` | shell principal avec bottom nav |
| `marketplace/` | liste produits + product_detail |
| `search/` | recherche |
| `sell/` | publication d'annonce (create_listing) |
| `orders/` | liste + détail commandes |
| `checkout/` | tunnel de paiement |
| `payment_method/` | méthodes de paiement |
| `address/` | gestion adresses |
| `profile/` | profil utilisateur |
| `delivery/` | dashboard livreur |
| `notifications/` | notifications |
| `reviews/` | avis sur un produit |
| `settings/` | paramètres |
| `legal/` | CGU, confidentialité, cookies |

Chaque feature suit la même convention :

```
screens/<feature>/
├── <feature>_screen.dart       → écran principal (Scaffold + BLoC)
└── widgets/                    → sous-widgets propres à cet écran
    ├── <feature>_form.dart
    ├── <feature>_header.dart
    └── ...
```

Les sous-widgets propres à un écran sont dans `widgets/`. Les widgets **génériques réutilisables** (boutons, inputs, cards…) sont dans [lib/presentation/widgets/zolya/](lib/presentation/widgets/zolya/) — c'est le **design system**.

---

## 3. Le système de thème (couleurs, typo, espaces)

### 3.1 Fichier central — [lib/theme/zolya_theme.dart](lib/theme/zolya_theme.dart)

Quatre classes utilitaires :

#### `ZolyaColors` — palette de couleurs

```dart
// Marque
ZolyaColors.or          // doré principal #DE9E0C
ZolyaColors.noir        // #0A0A0A (couleurs fixes brand)
ZolyaColors.blanc       // #FFFFFF

// Échelle dorée (or50 → or900) pour states/hover
ZolyaColors.or50  ... ZolyaColors.or900

// Neutres clair
ZolyaColors.fond        // background app
ZolyaColors.surface     // cartes
ZolyaColors.surface2    // surface alternée
ZolyaColors.bordure     // outlines
ZolyaColors.texte1      // titres
ZolyaColors.texte2      // body
ZolyaColors.texte3      // placeholders

// Neutres sombre (suffixe Dark)
ZolyaColors.fondDark / surfaceDark / bordureDark / texte1Dark / ...

// Sémantique
ZolyaColors.succes / succesBg
ZolyaColors.erreur / erreurBg
ZolyaColors.avertissement / avertissementBg
ZolyaColors.info / infoBg
```

⚠️ **N'utilise PAS `ZolyaColors.texte1` ou `bordure` directement** dans un widget pour du texte/bordure — ces constantes ne s'adaptent pas au mode sombre. Utilise `Theme.of(context).colorScheme.*` à la place (voir §3.4).

`ZolyaColors.noir` et `ZolyaColors.blanc` restent valides quand le fond est lui-même invariant (fond doré, badge succès vert, badge erreur rouge…).

#### `ZolyaSpacing` — espacements

```dart
ZolyaSpacing.xs   // 4
ZolyaSpacing.sm   // 8
ZolyaSpacing.md   // 12
ZolyaSpacing.lg   // 16
ZolyaSpacing.xl   // 24
ZolyaSpacing.xxl  // 32
ZolyaSpacing.xxxl // 48
```

#### `ZolyaRadius` — rayons

```dart
ZolyaRadius.sm   // 8   → boutons
ZolyaRadius.md   // 12  → cartes
ZolyaRadius.lg   // 16  → bottom sheets
ZolyaRadius.xl   // 24  → dialogs
ZolyaRadius.full // 999 → pills
```

#### `ZolyaTypography` — styles de texte

```dart
ZolyaTypography.displayLarge   // 40, w900 — Montserrat (titres XXL)
ZolyaTypography.displayMedium  // 32, w900
ZolyaTypography.headline       // 24, w800
ZolyaTypography.title          // 18, w700
ZolyaTypography.subtitle       // 16, w600
ZolyaTypography.body           // 15, w400 — Inter (corps)
ZolyaTypography.bodySmall      // 13, w400
ZolyaTypography.caption        // 12, w500
ZolyaTypography.label          // 11, w600
ZolyaTypography.button         // 15, w700 — Montserrat
```

#### `ZolyaGradients`

```dart
ZolyaGradients.or        // dégradé doré (CTA premium, splash)
ZolyaGradients.orSubtil  // dégradé doré subtil (sections)
ZolyaGradients.orNoir    // luxe (or → noir)
```

### 3.2 ThemeData — `ZolyaTheme.light` / `ZolyaTheme.dark`

Configurés dans `_baseTheme()` à la fin de [zolya_theme.dart](lib/theme/zolya_theme.dart) :
- `appBarTheme`, `elevatedButtonTheme`, `outlinedButtonTheme`, `textButtonTheme`
- `cardTheme`, `chipTheme`, `inputDecorationTheme`
- `bottomNavigationBarTheme`, `floatingActionButtonTheme`
- `dividerTheme`, `listTileTheme`, `checkboxTheme`, `radioTheme`

→ Pour modifier l'apparence globale (ex : tous les boutons, tous les inputs), **modifie ce fichier**, pas chaque écran.

### 3.3 Thème shadcn_ui — [zolya_shad_theme.dart](lib/theme/zolya_shad_theme.dart)

Le projet utilise aussi `shadcn_ui` (composants ShadButton, ShadInput…). Son `ShadThemeData` clone les couleurs Zolya. Si tu changes la palette, propage les modifs dans les deux fichiers.

### 3.4 Récupérer une couleur dans un widget

```dart
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final cs = theme.colorScheme;

  return Container(
    color: cs.surface,                              // fond carte
    child: Text(
      'Titre',
      style: ZolyaTypography.title.copyWith(
        color: cs.onSurface,                        // texte principal (auto light/dark)
      ),
    ),
  );
}
```

Mappage utile :

| Besoin | À utiliser |
|---|---|
| Texte principal (titre, body) | `cs.onSurface` |
| Texte secondaire / muted | `cs.onSurface.withValues(alpha: 0.65)` |
| Texte placeholder / disabled | `cs.onSurface.withValues(alpha: 0.45)` |
| Bordure de champ / outline | `cs.outline` |
| Fond d'écran | `theme.scaffoldBackgroundColor` |
| Fond de carte | `cs.surface` |
| Fond muet / surface alternée | `cs.surfaceContainerHighest` |
| Couleur de marque (doré) | `cs.primary` (= `ZolyaColors.or`) |
| Texte sur doré | `cs.onPrimary` (= noir) |
| Erreur | `cs.error` |
| Succès / info / warning | `ZolyaColors.succes`, `info`, `avertissement` (sémantique brand) |

Helpers via `ContextExtensions` ([lib/core/extensions/context_extensions.dart](lib/core/extensions/context_extensions.dart)) :

```dart
context.theme        // = Theme.of(context)
context.colorScheme  // = Theme.of(context).colorScheme
context.textTheme    // = Theme.of(context).textTheme
context.isDark       // bool, brightness == dark
context.hideKeyboard()
context.showSnackBar('Message')
context.showErrorSnackBar('Oups')
```

---

## 4. Le design system Zolya — composants prêts à l'emploi

Tous dans [lib/presentation/widgets/zolya/](lib/presentation/widgets/zolya/), exportés par [zolya.dart](lib/presentation/widgets/zolya/zolya.dart). Importation unique :

```dart
import '../../widgets/zolya/zolya.dart';
```

### Composants principaux

| Widget | Usage |
|---|---|
| `ZolyaTopBar` | AppBar standard avec back-button intelligent (go_router) |
| `ZolyaButton` | Bouton (variants: primary, secondary, outline, ghost, destructive ; sizes: sm/md/lg) |
| `ZolyaTextField` | Champ texte stylé Zolya |
| `ZolyaTextarea` | Zone de texte multi-lignes |
| `ZolyaPhoneField` | Champ téléphone avec préfixe pays |
| `ZolyaSearchField` | Champ recherche avec icône |
| `ZolyaOtpInput` | Saisie code OTP |
| `ZolyaSelect` | Dropdown |
| `ZolyaCheckbox` / `ZolyaRadioCard` / `ZolyaSwitch` | Sélections |
| `ZolyaSegmentedControl` / `ZolyaChip` | Tabs / filtres |
| `ZolyaCard` / `ZolyaGradientCard` | Cartes |
| `ZolyaListTile` | Ligne cliquable |
| `ZolyaProductCard` | Carte produit (image + titre + prix) |
| `ZolyaPriceTag` | Affichage prix |
| `ZolyaAvatar` | Avatar circulaire |
| `ZolyaBadge` | Petit badge coloré |
| `ZolyaAlert` | Bannière info/erreur/succès |
| `ZolyaDialog` / `ZolyaSuccessDialog` | Dialogs |
| `ZolyaSheet` | Bottom sheet |
| `ZolyaEmptyState` | Écran vide (icône + titre + message + CTA) |
| `ZolyaSpinner` | Loader |
| `ZolyaSkeleton` | Squelette de chargement |
| `ZolyaProgress` | Barre de progression |
| `ZolyaDivider` | Séparateur (avec ou sans label) |
| `ZolyaAccordion` | Liste dépliable |
| `ZolyaSocialButton` | Bouton Google/Apple |
| `ZolyaPhotoGrid` | Grille de photos avec ajout/suppression |
| `ZolyaRangeSlider` | Slider double curseur |
| `ZolyaStarsRow` / `ZolyaRatingInline` | Étoiles de note |
| `ZolyaNotificationBell` | Cloche de notif (avec dot rouge) |

Lis le fichier d'un composant avant de l'utiliser pour voir ses paramètres exacts.

---

## 5. Routing — ajouter une route

### Étapes pour une nouvelle page

1. **Créer la classe d'écran** dans `lib/presentation/screens/<feature>/<feature>_screen.dart` (voir §6).

2. **Ajouter une constante de chemin** dans [lib/config/routes/route_names.dart](lib/config/routes/route_names.dart) :
   ```dart
   static const String maNouvellePage = '/ma-nouvelle-page';
   // Avec paramètre :
   static const String monItemDetail = '/items/:id';
   static String monItemDetailPath(String id) => '/items/$id';
   ```

3. **Enregistrer la route** dans [lib/config/routes/app_router.dart](lib/config/routes/app_router.dart) :
   ```dart
   GoRoute(
     path: RouteNames.maNouvellePage,
     builder: (_, __) => const MaNouvellePageScreen(),
   ),
   // Avec paramètre :
   GoRoute(
     path: RouteNames.monItemDetail,
     builder: (context, state) => MonItemDetailScreen(
       id: state.pathParameters['id']!,
     ),
   ),
   ```

4. **Importer** la screen en haut de `app_router.dart`.

### Naviguer depuis un widget

```dart
import 'package:go_router/go_router.dart';
import '../../../config/routes/route_names.dart';

// Push (empile, le bouton retour fonctionne) ✅ Préféré
context.push(RouteNames.maNouvellePage);
context.push(RouteNames.monItemDetailPath('abc123'));

// Go (REMPLACE la stack — pas de back) — réservé aux redirections globales
context.go(RouteNames.marketplace);

// Pop (revenir en arrière)
if (context.canPop()) context.pop();
```

Règle : **utilise `context.push()` quand tu veux que la flèche retour fonctionne**. `context.go()` uniquement pour login → marketplace, splash → home, etc.

---

## 6. Squelette d'une nouvelle page

### 6.1 Page simple (sans BLoC)

`lib/presentation/screens/exemple/exemple_screen.dart` :

```dart
import 'package:flutter/material.dart';

import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';
import '../../widgets/zolya/zolya.dart';

class ExempleScreen extends StatelessWidget {
  const ExempleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: ZolyaTopBar(title: l.exempleTitle, centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ZolyaSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l.exempleHeading,
                style: ZolyaTypography.headline.copyWith(color: cs.onSurface),
              ),
              const SizedBox(height: ZolyaSpacing.md),
              Text(
                l.exempleSubtitle,
                style: ZolyaTypography.body.copyWith(
                  color: cs.onSurface.withValues(alpha: 0.65),
                ),
              ),
              const SizedBox(height: ZolyaSpacing.xl),
              ZolyaButton(
                label: l.exempleCta,
                onPressed: () {},
                expand: true,
                size: ZolyaButtonSize.lg,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 6.2 Page avec BLoC / Cubit

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/i18n/locale_provider.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/exemple/exemple_cubit.dart';
import '../../bloc/exemple/exemple_state.dart';
import '../../widgets/zolya/zolya.dart';

class ExempleScreen extends StatelessWidget {
  const ExempleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExempleCubit>(
      create: (_) => ExempleCubit(repo: sl())..load(),
      child: const _ExempleView(),
    );
  }
}

class _ExempleView extends StatelessWidget {
  const _ExempleView();

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: ZolyaTopBar(title: l.exempleTitle),
      body: SafeArea(
        child: BlocBuilder<ExempleCubit, ExempleState>(
          builder: (context, state) {
            if (state is ExempleLoading) {
              return const Center(child: ZolyaSpinner());
            }
            if (state is ExempleError) {
              return ZolyaEmptyState(
                icon: Icons.error_outline,
                title: state.message,
              );
            }
            final loaded = state as ExempleLoaded;
            return ListView(
              padding: const EdgeInsets.all(ZolyaSpacing.lg),
              children: [
                for (final item in loaded.items)
                  ZolyaListTile(
                    title: item.title,
                    subtitle: item.subtitle,
                    onTap: () {},
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
```

### 6.3 Découper en sous-widgets

Si l'écran dépasse ~150 lignes, extrais des morceaux dans `widgets/` :

```
screens/exemple/
├── exemple_screen.dart
└── widgets/
    ├── exemple_header.dart
    ├── exemple_form.dart
    └── exemple_footer.dart
```

Convention : un sous-widget par fichier, classe `StatelessWidget`/`StatefulWidget` avec ses propres paramètres explicites (pas de "god widget").

---

## 7. Recettes courantes (snippets)

### Bouton plein largeur principal

```dart
ZolyaButton(
  label: 'Continuer',
  onPressed: () {},
  expand: true,
  size: ZolyaButtonSize.lg,
)
```

### Bouton secondaire / contour

```dart
ZolyaButton(
  label: 'Annuler',
  variant: ZolyaButtonVariant.outline,
  onPressed: () {},
)
```

### Champ texte

```dart
ZolyaTextField(
  controller: myController,
  label: 'Email',
  hint: 'exemple@zolya.com',
  prefixIcon: const Icon(Icons.mail_outline),
  validator: (v) => (v?.isEmpty ?? true) ? 'Requis' : null,
)
```

### Carte cliquable

```dart
ZolyaCard(
  onTap: () {},
  padding: const EdgeInsets.all(ZolyaSpacing.lg),
  child: Row(
    children: [
      Icon(Icons.star, color: Theme.of(context).colorScheme.primary),
      const SizedBox(width: ZolyaSpacing.md),
      Expanded(
        child: Text(
          'Mon contenu',
          style: ZolyaTypography.title.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    ],
  ),
)
```

### SnackBar (via extension)

```dart
context.showSnackBar('Sauvegardé');
context.showErrorSnackBar('Une erreur est survenue');
```

### Dialog de succès

```dart
await ZolyaSuccessDialog.show(
  context,
  title: 'Bravo !',
  message: 'Votre annonce est publiée.',
  buttonLabel: 'Voir mes annonces',
  onConfirm: () => context.go(RouteNames.myListings),
);
```

### Bottom sheet

```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (_) => ZolyaSheet(
    title: 'Filtrer',
    child: Column(/* ... */),
  ),
);
```

### Loader plein écran

```dart
const Center(child: ZolyaSpinner())
```

### État vide

```dart
ZolyaEmptyState(
  icon: Icons.inbox_outlined,
  title: 'Aucun élément',
  body: 'Vos commandes apparaîtront ici.',
  actionLabel: 'Découvrir',
  onAction: () => context.go(RouteNames.marketplace),
)
```

---

## 8. Internationalisation (i18n)

Les textes sont dans :
- [lib/core/i18n/app_strings.dart](lib/core/i18n/app_strings.dart) — interface (getters abstraits)
- [lib/core/i18n/app_strings_fr.dart](lib/core/i18n/app_strings_fr.dart) — version française
- [lib/core/i18n/app_strings_en.dart](lib/core/i18n/app_strings_en.dart) — version anglaise

Pour ajouter une nouvelle clé :

1. Dans `app_strings.dart` :
   ```dart
   String get monNouveauTexte;
   ```

2. Dans `app_strings_fr.dart` :
   ```dart
   @override String get monNouveauTexte => 'Mon texte FR';
   ```

3. Dans `app_strings_en.dart` :
   ```dart
   @override String get monNouveauTexte => 'My text EN';
   ```

4. Dans le widget :
   ```dart
   final l = context.l10n;
   Text(l.monNouveauTexte);
   ```

`context.l10n` provient de [lib/core/i18n/locale_provider.dart](lib/core/i18n/locale_provider.dart).

---

## 9. Modifier le style global

| Tu veux changer… | Modifie… |
|---|---|
| Une couleur de marque | `ZolyaColors` dans [zolya_theme.dart](lib/theme/zolya_theme.dart) (et propage dans [zolya_shad_theme.dart](lib/theme/zolya_shad_theme.dart)) |
| L'aspect de **tous** les boutons | `elevatedButtonTheme` / `outlinedButtonTheme` / `textButtonTheme` dans `_baseTheme()` |
| L'aspect de **tous** les inputs | `inputDecorationTheme` dans `_baseTheme()` |
| L'aspect de toutes les cartes | `cardTheme` dans `_baseTheme()` |
| Les rayons d'angle | `ZolyaRadius` |
| Les espacements | `ZolyaSpacing` |
| Les polices | `ZolyaTypography` (utilise `google_fonts`) |
| Le bouton retour des AppBar | [zolya_top_bar.dart](lib/presentation/widgets/zolya/zolya_top_bar.dart) |
| Un composant Zolya précis | son fichier dans [widgets/zolya/](lib/presentation/widgets/zolya/) |

⚠️ Si tu modifies une couleur dans `ZolyaColors`, **vérifie aussi son équivalent shad** dans [zolya_shad_theme.dart](lib/theme/zolya_shad_theme.dart).

---

## 10. Conventions de code

- **Pas de commentaires** dans le code (le projet est volontairement nettoyé). Les noms de variables/classes doivent suffire.
- **Imports ordonnés** : packages externes d'abord, puis imports relatifs (`'../../...'`).
- **Const partout où possible** : `const Padding(...)`, `const SizedBox(...)`, `const ZolyaSpinner()`.
- **Pas de couleurs en dur** dans un widget — passe par `Theme.of(context).colorScheme.*`. Exception : couleurs de marque sur fond fixe (`ZolyaColors.noir` sur dégradé doré, `ZolyaColors.blanc` sur badge succès vert).
- **Sous-widgets privés** : utilise `class _MonWidget extends StatelessWidget` (avec `_`) pour les widgets internes à un fichier.
- **Spacing** : utilise `SizedBox(height: ZolyaSpacing.lg)` plutôt que `SizedBox(height: 16)`.
- **Padding** : `EdgeInsets.all(ZolyaSpacing.lg)`, `EdgeInsets.symmetric(horizontal: ZolyaSpacing.lg)`.

---

## 11. Cycle de dev

```bash
# Flutter SDK local — toujours utiliser ce binaire :
d:/Projets/Zolya/flutter/bin/flutter pub get
d:/Projets/Zolya/flutter/bin/flutter analyze --no-pub
d:/Projets/Zolya/flutter/bin/flutter run -d chrome     # ou -d windows / un device Android
```

`flutter analyze` doit toujours passer sans erreur avant un commit.

---

## 12. Checklist — créer un nouvel écran

- [ ] Créer `lib/presentation/screens/<feature>/<feature>_screen.dart`
- [ ] (Si BLoC) créer `lib/presentation/bloc/<feature>/<feature>_cubit.dart` + `_state.dart`
- [ ] (Si entités) ajouter dans `lib/domain/entities/`
- [ ] (Si données) repo abstrait dans `lib/domain/repositories/` + impl dans `lib/data/repositories/`
- [ ] Ajouter `RouteNames.maRoute` dans [route_names.dart](lib/config/routes/route_names.dart)
- [ ] Ajouter `GoRoute` dans [app_router.dart](lib/config/routes/app_router.dart)
- [ ] Ajouter les chaînes dans `app_strings.dart` + FR + EN
- [ ] Utiliser uniquement `ZolyaSpacing` / `ZolyaRadius` / `ZolyaTypography` / `Theme.of(context).colorScheme.*`
- [ ] Importer `widgets/zolya/zolya.dart` pour le design system
- [ ] Tester en mode clair ET sombre
- [ ] `flutter analyze --no-pub` doit passer

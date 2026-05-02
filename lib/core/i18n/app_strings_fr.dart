import 'app_strings.dart';

class AppStringsFr implements AppStrings {
  const AppStringsFr();

  @override String get appName => 'Zolya';
  @override String get continueLabel => 'Continuer';
  @override String get backLabel => 'Retour';

  @override String get getStartedTitle => 'Bienvenue sur Zolya';
  @override String get getStartedSubtitle => "Achetez et vendez des vêtements d'occasion en toute confiance.";
  @override String get getStartedCta => 'Commencer';
  @override String get alreadyHaveAccount => 'Déjà un compte ? ';
  @override String get logIn => 'Se connecter';

  @override String get registerTitle => 'Créer un compte';
  @override String get registerSubtitle => 'Créons votre compte.';
  @override String get fullNameLabel => 'Nom complet';
  @override String get fullNameHint => 'Entrez votre nom complet';
  @override String get phoneLabel => 'Numéro de téléphone';
  @override String get phoneHint => '6XX XXX XXX';
  @override String get passwordLabel => 'Mot de passe';
  @override String get passwordHint => 'Entrez votre mot de passe';
  @override String get registerCta => 'Créer un compte';
  @override String get signUpWithGoogle => "S'inscrire avec Google";
  @override String get signUpWithApple => "S'inscrire avec Apple";
  @override String get dividerOr => 'Ou';
  @override String get legalPrefix => "En vous inscrivant vous acceptez nos ";
  @override String get legalTermsLink => "Conditions d'utilisation";
  @override String get legalPrivacyLink => 'Politique de confidentialité';
  @override String get legalCookiesLink => 'Utilisation des cookies';
  @override String get legalSuffix => ' et ';

  @override String get loginTitle => 'Bon retour';
  @override String get loginSubtitle => 'Connectez-vous à votre compte.';
  @override String get loginCta => 'Se connecter';
  @override String get signInWithGoogle => 'Se connecter avec Google';
  @override String get signInWithApple => 'Se connecter avec Apple';
  @override String get forgotPassword => 'Mot de passe oublié ?';
  @override String get noAccount => "Pas de compte ? ";
  @override String get signUp => "S'inscrire";

  @override String get otpTitle => 'Code de vérification';
  @override String get otpSentTo => 'Un code a été envoyé au';
  @override String get otpVerify => 'Vérifier';
  @override String get otpResend => 'Renvoyer le code';

  @override String get forgotTitle => 'Mot de passe oublié';
  @override String get forgotIntro => 'Entrez votre numéro de téléphone pour lancer la réinitialisation. Nous enverrons un code par SMS.';
  @override String get forgotSendCode => 'Envoyer le code';
  @override String get resetCodeTitle => 'Entrez le code à 5 chiffres';
  @override String get resetCodeIntro => 'Entrez le code à 5 chiffres reçu par SMS sur votre téléphone';
  @override String get resetCodeResendQuestion => 'Code non reçu ?';
  @override String get resetCodeResendLink => 'Renvoyer le code';
  @override String get resetPasswordTitle => 'Réinitialiser le mot de passe';
  @override String get resetPasswordIntro => 'Définissez un nouveau mot de passe pour votre compte afin de vous reconnecter.';
  @override String get newPasswordLabel => 'Mot de passe';
  @override String get confirmPasswordLabel => 'Mot de passe';
  @override String get passwordChangedTitle => 'Mot de passe modifié !';
  @override String get passwordChangedMessage => 'Vous pouvez maintenant utiliser votre nouveau mot de passe pour vous connecter.';
  @override String get passwordChangedCta => 'Se connecter';

  @override String get errorPhoneRequired => 'Numéro requis';
  @override String get errorPhoneLength => '9 chiffres attendus';
  @override String get errorPhonePrefix => 'Doit commencer par 6';
  @override String get errorPasswordRequired => 'Mot de passe requis';
  @override String get errorPasswordMinLength => 'Minimum 8 caractères';
  @override String get errorFullNameRequired => 'Nom complet requis';
  @override String get errorFullNameTooShort => 'Nom trop court';
  @override String get errorConfirmRequired => 'Confirmation requise';
  @override String get errorPasswordsMismatch => 'Les mots de passe ne correspondent pas';
  @override String get errorOtpInvalid => 'Code invalide';

  @override String get legalLastUpdated => 'Dernière mise à jour';
  @override String get termsScreenTitle => "Conditions d'utilisation";
  @override String get privacyScreenTitle => 'Politique de confidentialité';
  @override String get cookiesScreenTitle => 'Utilisation des cookies';

  @override String get navHome => 'Accueil';
  @override String get navSearch => 'Recherche';
  @override String get navSell => 'Vendre';
  @override String get navOrders => 'Commandes';
  @override String get navAccount => 'Compte';

  @override String get homeTitle => 'Zolya';
  @override String get discoverTitle => 'Découvrir';
  @override String get discoverSearchHint => 'Rechercher un article...';
  @override String get categoryAll => 'Tout';
  @override String get categoryTshirts => 'T-shirts';
  @override String get categoryJeans => 'Jeans';
  @override String get categoryShoes => 'Chaussures';
  @override String get categoryDresses => 'Robes';
  @override String get categoryAccessories => 'Accessoires';

  @override String get notificationsTitle => 'Notifications';
  @override String get notificationsEmptyTitle => "Vous n'avez aucune notification pour l'instant !";
  @override String get notificationsEmptyBody => "Nous vous préviendrons dès qu'il se passe quelque chose.";
  @override String get notifGroupToday => "Aujourd'hui";
  @override String get notifGroupYesterday => 'Hier';

  @override String get searchTitle => 'Recherche';
  @override String get searchRecent => 'Recherches récentes';
  @override String get searchClearAll => 'Tout effacer';
  @override String get searchNoResultsTitle => 'Aucun résultat';
  @override String get searchNoResultsBody => 'Essayez un autre mot ou quelque chose de plus général.';

  @override String get filtersTitle => 'Filtres';
  @override String get filterSortBy => 'Trier par';
  @override String get filterSortRelevance => 'Pertinence';
  @override String get filterSortPriceLowHigh => 'Prix : croissant';
  @override String get filterSortPriceHighLow => 'Prix : décroissant';
  @override String get filterPrice => 'Prix';
  @override String get filterSize => 'Taille';
  @override String get filterApply => 'Appliquer les filtres';
  @override String get filterReset => 'Réinitialiser';

  @override String get settingsTitle => 'Paramètres';
  @override String get settingsLanguage => 'Langue';
  @override String get settingsLanguageEnglish => 'English';
  @override String get settingsLanguageFrench => 'Français';

  @override String get detailsTitle => 'Détails';
  @override String get detailsReviews => 'avis';
  @override String get detailsChooseSize => 'Choisir la taille';
  @override String get detailsPrice => 'Prix';
  @override String get detailsCheckout => 'Commander';

  @override String get reviewsTitle => 'Avis';
  @override String get reviewsRatingsLabel => 'Notes';
  @override String get reviewsCountLabel => 'Avis';
  @override String get reviewsSortMostRelevant => 'Plus pertinents';

  @override String get checkoutTitle => 'Commande';
  @override String get checkoutDeliveryAddress => 'Adresse de livraison';
  @override String get checkoutChange => 'Modifier';
  @override String get checkoutPaymentMethod => 'Moyen de paiement';
  @override String get checkoutOrderSummary => 'Récapitulatif';
  @override String get checkoutSubTotal => 'Sous-total';
  @override String get checkoutVat => 'TVA (%)';
  @override String get checkoutShippingFee => 'Livraison';
  @override String get checkoutTotal => 'Total';
  @override String get checkoutPromoCodeHint => 'Code promo';
  @override String get checkoutPromoAdd => 'Ajouter';
  @override String get checkoutPlaceOrder => 'Commander';
  @override String get checkoutSuccessTitle => 'Félicitations !';
  @override String get checkoutSuccessMessage => 'Votre commande a été passée.';
  @override String get checkoutTrackOrder => 'Suivre ma commande';

  @override String get addressTitle => 'Adresse';
  @override String get addressSaved => 'Adresses enregistrées';
  @override String get addressDefault => 'Défaut';
  @override String get addressAddNew => 'Ajouter une adresse';
  @override String get addressApply => 'Appliquer';
  @override String get addressNicknameLabel => 'Nom';
  @override String get addressNicknameHint => 'Choisir un nom';
  @override String get addressFullLabel => 'Adresse complète';
  @override String get addressFullHint => 'Entrez votre adresse...';
  @override String get addressMakeDefault => 'Définir par défaut';
  @override String get addressAdd => 'Ajouter';
  @override String get addressAddedTitle => 'Félicitations !';
  @override String get addressAddedMessage => 'Votre nouvelle adresse a été ajoutée.';
  @override String get addressThanks => 'Merci';

  @override String get paymentTitle => 'Moyen de paiement';
  @override String get paymentSaved => 'Comptes enregistrés';
  @override String get paymentAddNew => 'Ajouter un compte';
  @override String get paymentMethodMtn => 'MTN Mobile Money';
  @override String get paymentMethodOrange => 'Orange Money';
  @override String get paymentNewAccount => 'Nouveau compte';
  @override String get paymentPhoneLabel => 'Numéro Mobile Money';
  @override String get paymentProviderLabel => 'Opérateur';
  @override String get paymentAddCta => 'Ajouter le compte';
  @override String get paymentAddedTitle => 'Félicitations !';
  @override String get paymentAddedMessage => 'Votre nouveau compte a été ajouté.';

  // Common
  @override String get commonYes => 'Oui';
  @override String get commonNo => 'Non';
  @override String get commonShare => 'Partager';
  @override String get commonEdit => 'Modifier';
  @override String get commonSave => 'Enregistrer';
  @override String get commonCancel => 'Annuler';
  @override String get commonClose => 'Fermer';
  @override String get commonRetry => 'Réessayer';

  // Profile (Account screen)
  @override String get profileTitle => 'Mon profil';
  @override String get sectionMySales => 'Mes ventes';
  @override String get sectionMyPurchases => 'Mes achats';
  @override String get sectionAccount => 'Compte';
  @override String get sectionHelp => 'Aide & support';
  @override String get sectionPreferences => 'Préférences';
  @override String get sectionLegal => 'Légal';
  @override String get menuMyArticles => 'Mes articles';
  @override String get menuMyDiscounts => 'Mes réductions';
  @override String get menuSalesHistory => 'Historique des ventes';
  @override String get menuFavorites => 'Favoris';
  @override String get menuPurchaseHistory => 'Historique des achats';
  @override String get menuMyOffers => 'Mes offres';
  @override String get menuPersonalInfo => 'Informations personnelles';
  @override String get menuMyAddresses => 'Mes adresses';
  @override String get menuPaymentMethods => 'Moyens de paiement';
  @override String get menuWallet => 'Portefeuille';
  @override String get menuNotifications => 'Notifications';
  @override String get menuFaq => "Centre d'aide";
  @override String get menuContactUs => 'Nous contacter';
  @override String get menuRateApp => "Évaluer l'application";
  @override String get menuInviteFriend => 'Inviter un ami';
  @override String get menuInviteEarn => 'Gagne 1000 FCFA';
  @override String get menuSettings => 'Paramètres';
  @override String get menuTerms => "Conditions d'utilisation";
  @override String get menuPrivacy => 'Politique de confidentialité';
  @override String get menuCookies => 'Cookies';
  @override String get menuAboutZolya => 'À propos de Zolya';
  @override String get menuLogout => 'Se déconnecter';
  @override String get walletShortcut => 'Portefeuille';

  // Profile / About tab
  @override String get profileTabListings => 'Annonces';
  @override String get profileTabReviews => 'Évaluations';
  @override String get profileTabAbout => 'À propos';
  @override String get profileNoListingsTitle => "Aucune annonce";
  @override String get profileNoListingsBody => "Vous n'avez encore rien publié. Commencez votre première annonce !";
  @override String get profileNoListingsCta => 'Publier';
  @override String get profileStatArticles => 'Articles';
  @override String get profileStatSales => 'Ventes';
  @override String get profileStatFollowers => 'Abonnés';
  @override String get aboutBioTitle => 'Bio';
  @override String get aboutPersonalInfo => 'Informations personnelles';
  @override String get aboutUsername => "Nom d'utilisateur";
  @override String get aboutPhone => 'Téléphone';
  @override String get aboutEmail => 'Email';
  @override String get aboutLocation => 'Localisation';
  @override String get aboutMemberSince => 'Membre depuis';
  @override String get aboutVerified => 'Compte vérifié';
  @override String get aboutBioDefault => 'Passionnée de mode, je revends mes pièces avec amour et soin. N\'hésitez pas à me faire vos offres !';

  // Edit profile
  @override String get editProfileTitle => 'Modifier le profil';
  @override String get editProfileSection => 'Informations';
  @override String get editProfileFullName => 'Nom complet';
  @override String get editProfileFullNameHint => 'Votre nom';
  @override String get editProfileFieldRequired => 'Champ obligatoire';
  @override String get editProfilePhone => 'Numéro de téléphone';
  @override String get editProfileEmail => 'Email (optionnel)';
  @override String get editProfileEmailHint => 'votre@email.com';
  @override String get editProfileCity => 'Ville';
  @override String get editProfileCityHint => 'Douala';
  @override String get editProfileBio => 'Bio';
  @override String get editProfileBioHint => 'Présentez-vous en quelques mots aux acheteurs…';
  @override String get editProfileSaved => 'Profil mis à jour';

  // Settings — appearance
  @override String get settingsAppearance => 'Apparence';
  @override String get settingsThemeLight => 'Clair';
  @override String get settingsThemeDark => 'Sombre';
  @override String get settingsThemeSystem => 'Système';

  // Notification preferences
  @override String get notifPrefsTitle => 'Notifications';
  @override String get notifPrefGeneral => 'Notifications générales';
  @override String get notifPrefSound => 'Son';
  @override String get notifPrefVibrate => 'Vibration';
  @override String get notifPrefSpecialOffers => 'Offres spéciales';
  @override String get notifPrefPromoDiscounts => 'Promos & Réductions';
  @override String get notifPrefPayments => 'Paiements';
  @override String get notifPrefCashback => 'Cashback';
  @override String get notifPrefAppUpdates => 'Mises à jour';
  @override String get notifPrefNewService => 'Nouveaux services';
  @override String get notifPrefNewTips => 'Nouveaux conseils';

  // Customer service
  @override String get customerServiceTitle => 'Service client';
  @override String get customerServiceWelcome =>
      "Bonjour ! Je suis l'assistant Zolya. Comment puis-je vous aider ?";
  @override String get customerServiceHint => 'Écrivez votre message…';
  @override String get customerServiceSend => 'Envoyer';
  @override String get customerServiceTyping => "L'assistant écrit…";
  @override String get customerServiceQuickHowOrder => 'Comment commander ?';
  @override String get customerServiceQuickRefund => 'Rembourser un produit';
  @override String get customerServiceQuickPayment => 'Problème de paiement';
  @override String get customerServiceQuickHuman => 'Parler à un humain';

  // Comments
  @override String get commentsTitle => 'Commentaires';
  @override String get commentsHint => 'Écrire un commentaire…';
  @override String get commentsAddCta => 'Ajouter un commentaire';
  @override String get commentsValidationTitle => 'Publier votre commentaire ?';
  @override String get commentsValidationMessage =>
      'Votre commentaire sera visible par le vendeur et les autres acheteurs.';
  @override String get commentsValidationConfirm => 'Publier';
  @override String get commentsValidationCancel => 'Annuler';
  @override String get commentsPosted => 'Commentaire publié';
  @override String get commentsEmpty => 'Aucun commentaire pour le moment';

  // Owner mode
  @override String get ownerEditCta => "Modifier l'annonce";

  // Discount actions
  @override String get discountActionEdit => 'Modifier';
  @override String get discountActionCancel => 'Annuler la réduction';

  // Profile menu replacements
  @override String get menuTheme => 'Thème';
  @override String get menuLanguage => 'Langue';

  // FAQ content
  @override String get faqSectionBuying => 'Acheter';
  @override String get faqSectionSelling => 'Vendre';
  @override String get faqSectionDelivery => 'Livraison';
  @override String get faqSectionAccount => 'Compte & Sécurité';
  @override String get faqQ1Question => 'Comment passer une commande ?';
  @override String get faqQ1Answer =>
      "Sélectionnez l'article, choisissez votre adresse de livraison, puis votre moyen de paiement Mobile Money (MTN ou Orange). Validez : le paiement est sécurisé en escrow jusqu'à réception.";
  @override String get faqQ2Question =>
      'Quels sont les modes de paiement acceptés ?';
  @override String get faqQ2Answer =>
      "Zolya accepte MTN Mobile Money et Orange Money. Le paiement est bloqué jusqu'à confirmation de réception de l'article.";
  @override String get faqQ3Question =>
      'Comment fonctionne la protection acheteur ?';
  @override String get faqQ3Answer =>
      "Votre paiement reste en séquestre chez Zolya jusqu'à confirmation de réception. Si l'article n'arrive pas ou ne correspond pas, vous êtes remboursé sous 48h.";
  @override String get faqQ4Question => 'Puis-je faire une proposition de prix ?';
  @override String get faqQ4Answer =>
      "Oui ! Sur chaque fiche article, le bouton « Faire une offre » permet de proposer un prix au vendeur (minimum 50% du prix affiché). Le vendeur a 24h pour accepter ou refuser.";
  @override String get faqQ5Question => 'Comment publier un article ?';
  @override String get faqQ5Answer =>
      "Appuyez sur le bouton « + » au centre de la barre de navigation, ajoutez vos photos, décrivez l'article (marque, taille, état) et fixez votre prix. La publication est instantanée et gratuite.";
  @override String get faqQ6Question => 'Quelle commission Zolya prélève-t-il ?';
  @override String get faqQ6Answer =>
      'Zolya prélève 15% du prix de vente, déduits automatiquement après confirmation de livraison. Aucun frais à la mise en vente.';
  @override String get faqQ7Question => 'Quand suis-je payé ?';
  @override String get faqQ7Answer =>
      "Dès que l'acheteur confirme la réception, le montant net (prix de vente - 15%) est crédité sur votre portefeuille Zolya. Vous pouvez retirer à tout moment vers votre Mobile Money.";
  @override String get faqQ8Question => 'Comment se passe la livraison ?';
  @override String get faqQ8Answer =>
      "Un livreur Zolya récupère l'article chez le vendeur et l'apporte à votre adresse. Délai moyen : 24 à 48h selon la zone.";
  @override String get faqQ9Question => 'Comment vérifier mon compte ?';
  @override String get faqQ9Answer =>
      'Validez votre numéro de téléphone via le code OTP reçu par SMS. Un compte vérifié inspire plus confiance et augmente vos chances de vendre.';
  @override String get faqQ10Question => 'Comment changer mon mot de passe ?';
  @override String get faqQ10Answer =>
      "Dans Paramètres → Sécurité → Mot de passe. Si vous l'avez oublié, utilisez « Mot de passe oublié » sur l'écran de connexion.";
  @override String get faqSearchHint => 'Rechercher une question…';
  @override String get faqEmptyTitle => 'Aucun résultat';
  @override String get faqEmptyBody =>
      'Essayez un autre mot-clé ou contactez le support.';

  // Discounts page
  @override String get discountsTitle => 'Mes réductions';
  @override String get discountsNewCta => 'Nouvelle réduction';
  @override String get discountsEmptyTitle => 'Aucune réduction active';
  @override String get discountsEmptyBody =>
      'Boostez vos ventes en proposant des réductions sur vos articles. Touchez «+» pour démarrer.';
  @override String get discountsInfoBanner =>
      'Les acheteurs voient un badge promo et reçoivent une notification. Une réduction réussie augmente vos chances de vente de +40%.';
  @override
  String discountsExpiresInDays(int days) =>
      days == 1 ? 'Expire dans 1 jour' : 'Expire dans $days jours';
  @override String get discountsNoExpiration => 'Sans date limite';

  // Price offer
  @override String get priceOfferTitle => 'Faire une offre';
  @override String get priceOfferAskingPrice => 'Prix demandé';
  @override String get priceOfferDiscountInfo => 'sous le prix demandé';
  @override String get priceOfferMinLabel => 'Min';
  @override String get priceOfferMaxLabel => 'Max';
  @override String get priceOfferMinError =>
      'Le minimum est 50% du prix demandé';
  @override String get priceOfferMaxError =>
      "L'offre doit être inférieure au prix affiché";
  @override String get priceOfferNote =>
      'Le vendeur a 24h pour accepter ou refuser votre offre. Vous serez notifié de sa réponse.';
  @override String get priceOfferSendCta => "Envoyer l'offre";

  // Share sheet
  @override String get shareSheetTitle => 'Partager';
  @override String get shareSheetCopy => 'Copier';
  @override String get shareSheetCopied => 'Lien copié dans le presse-papier';
  @override String shareSheetSoon(String channel) =>
      'Partage via $channel — bientôt disponible';

  // Comments rating
  @override String get commentsRatingLabel => 'Votre note';
  @override String get commentsRatingTapToRate => 'Touchez pour noter';

  // Contact us
  @override String get contactUsTitle => 'Nous contacter';
  @override String get contactUsForm => 'Envoyez-nous un message';
  @override String get contactUsName => 'Votre nom';
  @override String get contactUsEmail => 'Votre email';
  @override String get contactUsSubject => 'Sujet';
  @override String get contactUsMessage => 'Message';
  @override String get contactUsSend => 'Envoyer';
  @override String get contactUsSent => 'Message envoyé. Réponse sous 24h.';
  @override String get contactUsEmailTile => 'Envoyez-nous un email';
  @override String get contactUsPhoneTile => 'Service client';
  @override String get contactUsPhoneNumber => '+237 6 99 00 00 00';
  @override String get contactUsEmailAddress => 'support@zolya.app';
  @override String get menuContactUsCustom => 'Nous contacter';

  // About — delete account
  @override String get deleteAccountCta => 'Supprimer le compte';
  @override String get deleteAccountConfirmTitle =>
      'Supprimer votre compte ?';
  @override String get deleteAccountConfirmMessage =>
      'Cette action est définitive. Toutes vos données, annonces, offres et solde portefeuille seront effacés.';
  @override String get deleteAccountConfirmYes => 'Supprimer définitivement';
  @override String get deleteAccountConfirmNo => 'Annuler';
  @override String get deleteAccountDone => 'Compte supprimé';

  // Logout
  @override String get logoutConfirmTitle => 'Se déconnecter ?';
  @override String get logoutConfirmMessage =>
      'Vous devrez vous reconnecter pour accéder à votre compte.';
  @override String get logoutConfirmYes => 'Se déconnecter';
  @override String get logoutConfirmNo => 'Annuler';

  // My listings
  @override String get myListingsTitle => 'Mes articles';
  @override String get myListingsTabActive => 'En ligne';
  @override String get myListingsTabSold => 'Vendus';
  @override String get myListingsTabDraft => 'Brouillons';
  @override String get myListingsPublishCta => 'Publier';
  @override String get myListingsEmptyTitle => 'Rien ici';
  @override String get myListingsEmptyBody =>
      "Vous n'avez aucun article dans cette catégorie. Touchez «Publier» pour démarrer.";

  // Orders / status
  @override String get orderStatusPlaced => 'Passée';
  @override String get orderStatusPaid => 'Payée';
  @override String get orderStatusInDelivery => 'En livraison';
  @override String get orderStatusDelivered => 'Livrée';
  @override String get orderStatusCancelled => 'Annulée';
  @override String get orderDetailTitle => 'Commande';
  @override String get orderDetailNumber => 'Numéro de commande';
  @override String get orderDetailDate => 'Date de commande';
  @override String get orderDetailStatus => 'Statut';
  @override String get orderDetailItem => 'Article';
  @override String get orderDetailDeliveryAddress => 'Adresse de livraison';
  @override String get orderDetailPayment => 'Paiement';
  @override String get orderDetailSummary => 'Récapitulatif';
  @override String get orderDetailSubtotal => 'Sous-total';
  @override String get orderDetailDelivery => 'Livraison';
  @override String get orderDetailTotal => 'Total';
  @override String get orderDetailTrackOrder => 'Suivre la commande';
}

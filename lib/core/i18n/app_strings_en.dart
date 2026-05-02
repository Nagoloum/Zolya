import 'app_strings.dart';

class AppStringsEn implements AppStrings {
  const AppStringsEn();

  @override String get appName => 'Zolya';
  @override String get continueLabel => 'Continue';
  @override String get backLabel => 'Back';

  @override String get getStartedTitle => 'Welcome to Zolya';
  @override String get getStartedSubtitle => 'Buy and sell second-hand clothing with confidence.';
  @override String get getStartedCta => 'Get Started';
  @override String get alreadyHaveAccount => 'Already have an account? ';
  @override String get logIn => 'Log In';

  @override String get registerTitle => 'Create an account';
  @override String get registerSubtitle => "Let's create your account.";
  @override String get fullNameLabel => 'Full Name';
  @override String get fullNameHint => 'Enter your full name';
  @override String get phoneLabel => 'Phone Number';
  @override String get phoneHint => '6XX XXX XXX';
  @override String get passwordLabel => 'Password';
  @override String get passwordHint => 'Enter your password';
  @override String get registerCta => 'Create an Account';
  @override String get signUpWithGoogle => 'Sign Up with Google';
  @override String get signUpWithApple => 'Sign Up with Apple';
  @override String get dividerOr => 'Or';
  @override String get legalPrefix => 'By signing up you agree to our ';
  @override String get legalTermsLink => 'Terms';
  @override String get legalPrivacyLink => 'Privacy Policy';
  @override String get legalCookiesLink => 'Cookie Use';
  @override String get legalSuffix => ' and ';

  @override String get loginTitle => 'Welcome back';
  @override String get loginSubtitle => 'Log in to your account.';
  @override String get loginCta => 'Log In';
  @override String get signInWithGoogle => 'Sign In with Google';
  @override String get signInWithApple => 'Sign In with Apple';
  @override String get forgotPassword => 'Forgot password?';
  @override String get noAccount => "Don't have an account? ";
  @override String get signUp => 'Sign Up';

  @override String get otpTitle => 'Verification code';
  @override String get otpSentTo => 'A code has been sent to';
  @override String get otpVerify => 'Verify';
  @override String get otpResend => 'Resend code';

  @override String get forgotTitle => 'Forgot password';
  @override String get forgotIntro => 'Enter your phone number to start the reset process. We will send a code to your phone.';
  @override String get forgotSendCode => 'Send Code';
  @override String get resetCodeTitle => 'Enter 5 digit code';
  @override String get resetCodeIntro => 'Enter the 5 digit code you received on your phone';
  @override String get resetCodeResendQuestion => 'Code not received?';
  @override String get resetCodeResendLink => 'Resend code';
  @override String get resetPasswordTitle => 'Reset Password';
  @override String get resetPasswordIntro => 'Set a new password for your account so you can log in and access all features.';
  @override String get newPasswordLabel => 'Password';
  @override String get confirmPasswordLabel => 'Password';
  @override String get passwordChangedTitle => 'Password Changed!';
  @override String get passwordChangedMessage => 'You can now use your new password to login to your account.';
  @override String get passwordChangedCta => 'Login';

  @override String get errorPhoneRequired => 'Phone number required';
  @override String get errorPhoneLength => '9 digits expected';
  @override String get errorPhonePrefix => 'Must start with 6';
  @override String get errorPasswordRequired => 'Password required';
  @override String get errorPasswordMinLength => 'At least 8 characters';
  @override String get errorFullNameRequired => 'Full name required';
  @override String get errorFullNameTooShort => 'Name too short';
  @override String get errorConfirmRequired => 'Please confirm your password';
  @override String get errorPasswordsMismatch => "Passwords don't match";
  @override String get errorOtpInvalid => 'Invalid code';

  @override String get legalLastUpdated => 'Last updated';
  @override String get termsScreenTitle => 'Terms of Use';
  @override String get privacyScreenTitle => 'Privacy Policy';
  @override String get cookiesScreenTitle => 'Cookie Use';

  @override String get navHome => 'Home';
  @override String get navSearch => 'Search';
  @override String get navSell => 'Sell';
  @override String get navOrders => 'Orders';
  @override String get navAccount => 'Account';

  @override String get homeTitle => 'Zolya';
  @override String get discoverTitle => 'Discover';
  @override String get discoverSearchHint => 'Search for clothes...';
  @override String get categoryAll => 'All';
  @override String get categoryTshirts => 'Tshirts';
  @override String get categoryJeans => 'Jeans';
  @override String get categoryShoes => 'Shoes';
  @override String get categoryDresses => 'Dresses';
  @override String get categoryAccessories => 'Accessories';

  @override String get notificationsTitle => 'Notifications';
  @override String get notificationsEmptyTitle => "You haven't gotten any notifications yet!";
  @override String get notificationsEmptyBody => "We'll alert you when something cool happens.";
  @override String get notifGroupToday => 'Today';
  @override String get notifGroupYesterday => 'Yesterday';

  @override String get searchTitle => 'Search';
  @override String get searchRecent => 'Recent Searches';
  @override String get searchClearAll => 'Clear all';
  @override String get searchNoResultsTitle => 'No Results Found!';
  @override String get searchNoResultsBody => 'Try a similar word or something more general.';

  @override String get filtersTitle => 'Filters';
  @override String get filterSortBy => 'Sort By';
  @override String get filterSortRelevance => 'Relevance';
  @override String get filterSortPriceLowHigh => 'Price: Low - High';
  @override String get filterSortPriceHighLow => 'Price: High - Low';
  @override String get filterPrice => 'Price';
  @override String get filterSize => 'Size';
  @override String get filterApply => 'Apply Filters';
  @override String get filterReset => 'Reset';

  @override String get settingsTitle => 'Settings';
  @override String get settingsLanguage => 'Language';
  @override String get settingsLanguageEnglish => 'English';
  @override String get settingsLanguageFrench => 'Français';

  @override String get detailsTitle => 'Details';
  @override String get detailsReviews => 'reviews';
  @override String get detailsChooseSize => 'Choose size';
  @override String get detailsPrice => 'Price';
  @override String get detailsCheckout => 'Checkout';

  @override String get reviewsTitle => 'Reviews';
  @override String get reviewsRatingsLabel => 'Ratings';
  @override String get reviewsCountLabel => 'Reviews';
  @override String get reviewsSortMostRelevant => 'Most Relevant';

  @override String get checkoutTitle => 'Checkout';
  @override String get checkoutDeliveryAddress => 'Delivery Address';
  @override String get checkoutChange => 'Change';
  @override String get checkoutPaymentMethod => 'Payment Method';
  @override String get checkoutOrderSummary => 'Order Summary';
  @override String get checkoutSubTotal => 'Sub-total';
  @override String get checkoutVat => 'VAT (%)';
  @override String get checkoutShippingFee => 'Shipping fee';
  @override String get checkoutTotal => 'Total';
  @override String get checkoutPromoCodeHint => 'Enter promo code';
  @override String get checkoutPromoAdd => 'Add';
  @override String get checkoutPlaceOrder => 'Place Order';
  @override String get checkoutSuccessTitle => 'Congratulations!';
  @override String get checkoutSuccessMessage => 'Your order has been placed.';
  @override String get checkoutTrackOrder => 'Track Your Order';

  @override String get addressTitle => 'Address';
  @override String get addressSaved => 'Saved Address';
  @override String get addressDefault => 'Default';
  @override String get addressAddNew => 'Add New Address';
  @override String get addressApply => 'Apply';
  @override String get addressNicknameLabel => 'Address Nickname';
  @override String get addressNicknameHint => 'Choose one';
  @override String get addressFullLabel => 'Full Address';
  @override String get addressFullHint => 'Enter your full address...';
  @override String get addressMakeDefault => 'Make this as a default address';
  @override String get addressAdd => 'Add';
  @override String get addressAddedTitle => 'Congratulations!';
  @override String get addressAddedMessage => 'Your new address has been added.';
  @override String get addressThanks => 'Thanks';

  @override String get paymentTitle => 'Payment Method';
  @override String get paymentSaved => 'Saved Accounts';
  @override String get paymentAddNew => 'Add New Account';
  @override String get paymentMethodMtn => 'MTN Mobile Money';
  @override String get paymentMethodOrange => 'Orange Money';
  @override String get paymentNewAccount => 'New Account';
  @override String get paymentPhoneLabel => 'Mobile Money number';
  @override String get paymentProviderLabel => 'Provider';
  @override String get paymentAddCta => 'Add Account';
  @override String get paymentAddedTitle => 'Congratulations!';
  @override String get paymentAddedMessage => 'Your new account has been added.';
}

abstract class RouteNames {

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String getStarted = '/get-started';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgot-password';
  static const String forgotPasswordCode = '/forgot-password/code';
  static const String forgotPasswordReset = '/forgot-password/reset';

  static const String home = '/home';
  static const String marketplace = '/marketplace';
  static const String search = '/search';
  static const String account = '/account';
  static const String productDetail = '/product/:id';
  static const String createListing = '/sell/create';
  static const String editListing = '/sell/edit/:id';
  static const String myListings = '/sell/listings';

  static const String checkout = '/checkout/:productId';
  static const String orders = '/orders';
  static const String orderDetail = '/orders/:id';
  static const String productReviews = '/product/:id/reviews';
  static const String addressList = '/addresses';
  static const String paymentMethods = '/payment-methods';

  static String productReviewsPath(String id) => '/product/$id/reviews';

  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String wallet = '/wallet';
  static const String settings = '/settings';
  static const String notifications = '/notifications';

  static const String deliveryDashboard = '/delivery';
  static const String deliveryDetail = '/delivery/:id';

  static const String legalTerms = '/legal/terms';
  static const String legalPrivacy = '/legal/privacy';
  static const String legalCookies = '/legal/cookies';

  static String productDetailPath(String id) => '/product/$id';
  static String checkoutPath(String productId) => '/checkout/$productId';
  static String orderDetailPath(String id) => '/orders/$id';
  static String deliveryDetailPath(String id) => '/delivery/$id';
  static String editListingPath(String id) => '/sell/edit/$id';
}

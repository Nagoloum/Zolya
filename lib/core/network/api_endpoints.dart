abstract class ApiEndpoints {
  static const String baseUrl = 'https://api.zolya.com/v1';

  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String sendOtp = '/auth/otp/send';
  static const String verifyOtp = '/auth/otp/verify';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';

  static const String me = '/users/me';
  static const String updateProfile = '/users/me';
  static const String uploadAvatar = '/users/me/avatar';

  static const String products = '/products';
  static String productById(String id) => '/products/$id';
  static const String myProducts = '/products/me';
  static String uploadProductMedia(String id) => '/products/$id/media';

  static const String orders = '/orders';
  static String orderById(String id) => '/orders/$id';
  static const String myOrders = '/orders/me';
  static const String myPurchases = '/orders/purchases';
  static String confirmDelivery(String id) => '/orders/$id/confirm';
  static String reportIssue(String id) => '/orders/$id/report';

  static const String initiatePayment = '/payments/initiate';
  static String paymentStatus(String id) => '/payments/$id/status';
  static const String wallet = '/payments/wallet';
  static const String withdrawalHistory = '/payments/withdrawals';

  static const String deliveries = '/deliveries';
  static String deliveryById(String id) => '/deliveries/$id';
  static const String availableDeliveries = '/deliveries/available';
  static String acceptDelivery(String id) => '/deliveries/$id/accept';
  static String updateDeliveryStatus(String id) => '/deliveries/$id/status';
  static const String delivererEarnings = '/deliveries/earnings';

  static const String categories = '/categories';
}

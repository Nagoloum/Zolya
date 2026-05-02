import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/get_started/get_started_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/auth/otp_screen.dart';
import '../../presentation/screens/auth/forgot_password/forgot_password_screen.dart';
import '../../presentation/screens/auth/forgot_password/reset_code_screen.dart';
import '../../presentation/screens/auth/forgot_password/reset_password_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/marketplace/marketplace_screen.dart';
import '../../presentation/screens/marketplace/product_detail_screen.dart';
import '../../presentation/screens/search/search_screen.dart';
import '../../presentation/screens/sell/create_listing_screen.dart';
import '../../presentation/screens/orders/orders_screen.dart';
import '../../presentation/screens/orders/order_detail_screen.dart';
import '../../presentation/screens/checkout/checkout_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/delivery/delivery_screen.dart';
import '../../presentation/screens/legal/terms_screen.dart';
import '../../presentation/screens/legal/privacy_policy_screen.dart';
import '../../presentation/screens/legal/cookie_use_screen.dart';
import '../../presentation/screens/notifications/notifications_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/reviews/reviews_screen.dart';
import '../../presentation/screens/address/address_list_screen.dart';
import '../../presentation/screens/payment_method/payment_method_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteNames.getStarted,
      builder: (_, __) => const GetStartedScreen(),
    ),
    GoRoute(
      path: RouteNames.login,
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteNames.register,
      builder: (_, __) => const RegisterScreen(),
    ),
    GoRoute(
      path: RouteNames.otp,
      builder: (context, state) {
        final phone = state.uri.queryParameters['phone'] ?? '';
        return OtpScreen(phone: phone);
      },
    ),
    GoRoute(
      path: RouteNames.forgotPassword,
      builder: (_, __) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: RouteNames.forgotPasswordCode,
      builder: (context, state) {
        final phone = state.uri.queryParameters['phone'] ?? '';
        return ResetCodeScreen(phone: phone);
      },
    ),
    GoRoute(
      path: RouteNames.forgotPasswordReset,
      builder: (context, state) {
        final phone = state.uri.queryParameters['phone'] ?? '';
        final code = state.uri.queryParameters['code'] ?? '';
        return ResetPasswordScreen(phone: phone, code: code);
      },
    ),
    ShellRoute(
      builder: (context, state, child) => HomeScreen(child: child),
      routes: [
        GoRoute(
          path: RouteNames.marketplace,
          builder: (_, __) => const MarketplaceScreen(),
        ),
        GoRoute(
          path: RouteNames.search,
          builder: (_, __) => const SearchScreen(),
        ),
        GoRoute(
          path: RouteNames.orders,
          builder: (_, __) => const OrdersScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => OrderDetailScreen(
                orderId: state.pathParameters['id']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: RouteNames.profile,
          builder: (_, __) => const ProfileScreen(),
        ),
        GoRoute(
          path: RouteNames.deliveryDashboard,
          builder: (_, __) => const DeliveryScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/checkout/:productId',
      builder: (context, state) => CheckoutScreen(
        productId: state.pathParameters['productId']!,
      ),
    ),
    GoRoute(
      path: RouteNames.createListing,
      builder: (_, __) => const CreateListingScreen(),
    ),
    GoRoute(
      path: RouteNames.legalTerms,
      builder: (_, __) => const TermsScreen(),
    ),
    GoRoute(
      path: RouteNames.legalPrivacy,
      builder: (_, __) => const PrivacyPolicyScreen(),
    ),
    GoRoute(
      path: RouteNames.legalCookies,
      builder: (_, __) => const CookieUseScreen(),
    ),
    GoRoute(
      path: RouteNames.notifications,
      builder: (_, __) => const NotificationsScreen(),
    ),
    GoRoute(
      path: RouteNames.settings,
      builder: (_, __) => const SettingsScreen(),
    ),
    GoRoute(
      path: RouteNames.productDetail,
      builder: (context, state) => ProductDetailScreen(
        productId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: RouteNames.productReviews,
      builder: (context, state) => ReviewsScreen(
        productId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: RouteNames.addressList,
      builder: (_, __) => const AddressListScreen(),
    ),
    GoRoute(
      path: RouteNames.paymentMethods,
      builder: (_, __) => const PaymentMethodScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('Page introuvable: ${state.error}')),
  ),
);

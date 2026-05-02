import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import 'page_transition.dart';
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
import '../../presentation/screens/seller/seller_profile_screen.dart';
import '../../presentation/screens/favorites/favorites_screen.dart';
import '../../presentation/screens/wallet/wallet_screen.dart';
import '../../presentation/screens/help/faq_screen.dart';
import '../../presentation/screens/help/contact_support_screen.dart';
import '../../presentation/screens/discounts/discounts_screen.dart';
import '../../presentation/screens/profile/edit_profile_screen.dart';
import '../../presentation/screens/profile/my_profile_screen.dart';
import '../../presentation/screens/sell/my_listings_screen.dart';
import '../../presentation/screens/offers/my_offers_screen.dart';
import '../../presentation/screens/about/about_zolya_screen.dart';
import '../../presentation/screens/invite/invite_friends_screen.dart';
import '../../presentation/screens/help/customer_service_screen.dart';
import '../../presentation/screens/help/contact_us_screen.dart';
import '../../presentation/screens/notifications/notification_preferences_screen.dart';

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
      pageBuilder: zolyaPageBuilderSimple(() => const LoginScreen()),
    ),
    GoRoute(
      path: RouteNames.register,
      pageBuilder: zolyaPageBuilderSimple(() => const RegisterScreen()),
    ),
    GoRoute(
      path: RouteNames.otp,
      pageBuilder: zolyaPageBuilder((context, state) {
        final phone = state.uri.queryParameters['phone'] ?? '';
        return OtpScreen(phone: phone);
      }),
    ),
    GoRoute(
      path: RouteNames.forgotPassword,
      pageBuilder:
          zolyaPageBuilderSimple(() => const ForgotPasswordScreen()),
    ),
    GoRoute(
      path: RouteNames.forgotPasswordCode,
      pageBuilder: zolyaPageBuilder((context, state) {
        final phone = state.uri.queryParameters['phone'] ?? '';
        return ResetCodeScreen(phone: phone);
      }),
    ),
    GoRoute(
      path: RouteNames.forgotPasswordReset,
      pageBuilder: zolyaPageBuilder((context, state) {
        final phone = state.uri.queryParameters['phone'] ?? '';
        final code = state.uri.queryParameters['code'] ?? '';
        return ResetPasswordScreen(phone: phone, code: code);
      }),
    ),
    ShellRoute(
      builder: (context, state, child) => HomeScreen(child: child),
      routes: [
        GoRoute(
          path: RouteNames.marketplace,
          pageBuilder: zolyaPageBuilderSimple(() => const MarketplaceScreen()),
        ),
        GoRoute(
          path: RouteNames.search,
          pageBuilder: zolyaPageBuilderSimple(() => const SearchScreen()),
        ),
        GoRoute(
          path: RouteNames.orders,
          pageBuilder: zolyaPageBuilderSimple(() => const OrdersScreen()),
          routes: [
            GoRoute(
              path: ':id',
              pageBuilder: zolyaPageBuilder(
                (context, state) => OrderDetailScreen(
                  orderId: state.pathParameters['id']!,
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          path: RouteNames.profile,
          pageBuilder: zolyaPageBuilderSimple(() => const ProfileScreen()),
        ),
        GoRoute(
          path: RouteNames.deliveryDashboard,
          pageBuilder: zolyaPageBuilderSimple(() => const DeliveryScreen()),
        ),
      ],
    ),
    GoRoute(
      path: '/checkout/:productId',
      pageBuilder: zolyaPageBuilder(
        (context, state) => CheckoutScreen(
          productId: state.pathParameters['productId']!,
        ),
      ),
    ),
    GoRoute(
      path: RouteNames.createListing,
      pageBuilder: zolyaPageBuilderSimple(() => const CreateListingScreen()),
    ),
    GoRoute(
      path: RouteNames.legalTerms,
      pageBuilder: zolyaPageBuilderSimple(() => const TermsScreen()),
    ),
    GoRoute(
      path: RouteNames.legalPrivacy,
      pageBuilder: zolyaPageBuilderSimple(() => const PrivacyPolicyScreen()),
    ),
    GoRoute(
      path: RouteNames.legalCookies,
      pageBuilder: zolyaPageBuilderSimple(() => const CookieUseScreen()),
    ),
    GoRoute(
      path: RouteNames.notifications,
      pageBuilder: zolyaPageBuilderSimple(() => const NotificationsScreen()),
    ),
    GoRoute(
      path: RouteNames.settings,
      pageBuilder: zolyaPageBuilderSimple(() => const SettingsScreen()),
    ),
    GoRoute(
      path: RouteNames.productDetail,
      pageBuilder: zolyaPageBuilder(
        (context, state) => ProductDetailScreen(
          productId: state.pathParameters['id']!,
        ),
      ),
    ),
    GoRoute(
      path: RouteNames.productReviews,
      pageBuilder: zolyaPageBuilder(
        (context, state) => ReviewsScreen(
          productId: state.pathParameters['id']!,
        ),
      ),
    ),
    GoRoute(
      path: RouteNames.addressList,
      pageBuilder: zolyaPageBuilderSimple(() => const AddressListScreen()),
    ),
    GoRoute(
      path: RouteNames.paymentMethods,
      pageBuilder: zolyaPageBuilderSimple(() => const PaymentMethodScreen()),
    ),
    GoRoute(
      path: RouteNames.sellerProfile,
      pageBuilder: zolyaPageBuilder(
        (context, state) => SellerProfileScreen(
          sellerId: state.pathParameters['id']!,
        ),
      ),
    ),
    GoRoute(
      path: RouteNames.favorites,
      pageBuilder: zolyaPageBuilderSimple(() => const FavoritesScreen()),
    ),
    GoRoute(
      path: RouteNames.wallet,
      pageBuilder: zolyaPageBuilderSimple(() => const WalletScreen()),
    ),
    GoRoute(
      path: RouteNames.faq,
      pageBuilder: zolyaPageBuilderSimple(() => const FaqScreen()),
    ),
    GoRoute(
      path: RouteNames.discounts,
      pageBuilder: zolyaPageBuilderSimple(() => const DiscountsScreen()),
    ),
    GoRoute(
      path: RouteNames.contactSupport,
      pageBuilder: zolyaPageBuilderSimple(() => const ContactSupportScreen()),
    ),
    GoRoute(
      path: RouteNames.editProfile,
      pageBuilder: zolyaPageBuilderSimple(() => const EditProfileScreen()),
    ),
    GoRoute(
      path: RouteNames.myProfile,
      pageBuilder: zolyaPageBuilderSimple(() => const MyProfileScreen()),
    ),
    GoRoute(
      path: RouteNames.myListings,
      pageBuilder: zolyaPageBuilderSimple(() => const MyListingsScreen()),
    ),
    GoRoute(
      path: RouteNames.myOffers,
      pageBuilder: zolyaPageBuilderSimple(() => const MyOffersScreen()),
    ),
    GoRoute(
      path: RouteNames.aboutZolya,
      pageBuilder: zolyaPageBuilderSimple(() => const AboutZolyaScreen()),
    ),
    GoRoute(
      path: RouteNames.inviteFriends,
      pageBuilder: zolyaPageBuilderSimple(() => const InviteFriendsScreen()),
    ),
    GoRoute(
      path: RouteNames.customerService,
      pageBuilder: zolyaPageBuilderSimple(() => const CustomerServiceScreen()),
    ),
    GoRoute(
      path: RouteNames.contactUs,
      pageBuilder: zolyaPageBuilderSimple(() => const ContactUsScreen()),
    ),
    GoRoute(
      path: RouteNames.notificationPreferences,
      pageBuilder: zolyaPageBuilderSimple(
        () => const NotificationPreferencesScreen(),
      ),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('Page not found: ${state.error}')),
  ),
);

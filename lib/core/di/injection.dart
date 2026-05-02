import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/env.dart';
import '../network/api_client.dart';
import '../../data/fake/fake_address_book_repository.dart';
import '../../data/fake/fake_auth_repository.dart';
import '../../data/fake/fake_delivery_repository.dart';
import '../../data/fake/fake_discount_repository.dart';
import '../../data/fake/fake_favorite_repository.dart';
import '../../data/fake/fake_notification_feed_repository.dart';
import '../../data/fake/fake_offer_repository.dart';
import '../../data/fake/fake_order_repository.dart';
import '../../data/fake/fake_payment_methods_repository.dart';
import '../../data/fake/fake_product_repository.dart';
import '../../data/fake/fake_product_reviews_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/delivery_repository_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/address_book_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/delivery_repository.dart';
import '../../domain/repositories/discount_repository.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../../domain/repositories/notification_feed_repository.dart';
import '../../domain/repositories/offer_repository.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/repositories/payment_methods_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/product_reviews_repository.dart';
import '../../domain/usecases/auth/send_otp_usecase.dart';
import '../../domain/usecases/auth/verify_otp_usecase.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/register_usecase.dart';
import '../../domain/usecases/products/get_products_usecase.dart';
import '../../domain/usecases/orders/create_order_usecase.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {

  try {
    final prefs = await SharedPreferences.getInstance();
    sl.registerSingleton<SharedPreferences>(prefs);
  } catch (_) {

  }

  try {
    sl.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  } catch (_) {}

  if (!Env.useStaticData) {
    sl.registerSingleton<ApiClient>(ApiClient());
  }

  if (Env.useStaticData) {
    sl.registerSingleton<AuthRepository>(FakeAuthRepository());
    sl.registerSingleton<ProductRepository>(FakeProductRepository());
    sl.registerSingleton<OrderRepository>(FakeOrderRepository());
    sl.registerSingleton<DeliveryRepository>(FakeDeliveryRepository());
  } else {
    sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(apiClient: sl<ApiClient>()));
    sl.registerSingleton<ProductRepository>(ProductRepositoryImpl(apiClient: sl<ApiClient>()));
    sl.registerSingleton<OrderRepository>(OrderRepositoryImpl(apiClient: sl<ApiClient>()));
    sl.registerSingleton<DeliveryRepository>(DeliveryRepositoryImpl(apiClient: sl<ApiClient>()));
  }

  sl.registerSingleton<AddressBookRepository>(FakeAddressBookRepository());
  sl.registerSingleton<PaymentMethodsRepository>(FakePaymentMethodsRepository());
  sl.registerSingleton<NotificationFeedRepository>(FakeNotificationFeedRepository());
  sl.registerSingleton<ProductReviewsRepository>(FakeProductReviewsRepository());
  sl.registerSingleton<FavoriteRepository>(FakeFavoriteRepository());
  sl.registerSingleton<OfferRepository>(FakeOfferRepository());
  sl.registerSingleton<DiscountRepository>(FakeDiscountRepository());

  sl.registerFactory(() => SendOtpUseCase(sl<AuthRepository>()));
  sl.registerFactory(() => VerifyOtpUseCase(sl<AuthRepository>()));
  sl.registerFactory(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerFactory(() => RegisterUseCase(sl<AuthRepository>()));

  sl.registerFactory(() => GetProductsUseCase(sl<ProductRepository>()));

  sl.registerFactory(() => CreateOrderUseCase(sl<OrderRepository>()));
}

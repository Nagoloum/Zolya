import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'config/routes/app_router.dart';
import 'core/di/injection.dart';
import 'theme/zolya_shad_theme.dart';
import 'theme/zolya_theme.dart';
import 'core/i18n/locale_provider.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/delivery_repository.dart';
import 'domain/repositories/discount_repository.dart';
import 'domain/repositories/favorite_repository.dart';
import 'domain/repositories/offer_repository.dart';
import 'domain/repositories/order_repository.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/auth/send_otp_usecase.dart';
import 'domain/usecases/auth/verify_otp_usecase.dart';
import 'domain/usecases/auth/login_usecase.dart';
import 'domain/usecases/auth/register_usecase.dart';
import 'domain/usecases/products/get_products_usecase.dart';
import 'domain/usecases/orders/create_order_usecase.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/comments/comments_cubit.dart';
import 'presentation/bloc/delivery/delivery_bloc.dart';
import 'presentation/bloc/discounts/discounts_cubit.dart';
import 'presentation/bloc/favorites/favorites_cubit.dart';
import 'presentation/bloc/follow/follow_cubit.dart';
import 'presentation/bloc/notification_prefs/notification_prefs_cubit.dart';
import 'presentation/bloc/offers/offers_cubit.dart';
import 'presentation/bloc/order/order_bloc.dart';
import 'presentation/bloc/product/product_bloc.dart';
import 'presentation/bloc/theme/theme_cubit.dart';

class ZolyaApp extends StatelessWidget {
  const ZolyaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            sendOtp: sl<SendOtpUseCase>(),
            verifyOtp: sl<VerifyOtpUseCase>(),
            login: sl<LoginUseCase>(),
            register: sl<RegisterUseCase>(),
            authRepository: sl<AuthRepository>(),
          ),
        ),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(
            getProducts: sl<GetProductsUseCase>(),
            productRepository: sl<ProductRepository>(),
          ),
        ),
        BlocProvider<OrderBloc>(
          create: (_) => OrderBloc(
            orderRepository: sl<OrderRepository>(),
            createOrder: sl<CreateOrderUseCase>(),
          ),
        ),
        BlocProvider<DeliveryBloc>(
          create: (_) => DeliveryBloc(
            deliveryRepository: sl<DeliveryRepository>(),
          ),
        ),
        BlocProvider<FavoritesCubit>(
          create: (_) => FavoritesCubit(repo: sl<FavoriteRepository>())..load(),
        ),
        BlocProvider<OffersCubit>(
          create: (_) => OffersCubit(repo: sl<OfferRepository>()),
        ),
        BlocProvider<DiscountsCubit>(
          create: (_) => DiscountsCubit(repo: sl<DiscountRepository>()),
        ),
        BlocProvider<FollowCubit>(
          create: (_) => FollowCubit(),
        ),
        BlocProvider<CommentsCubit>(
          create: (_) => CommentsCubit(),
        ),
        BlocProvider<NotificationPrefsCubit>(
          create: (_) => NotificationPrefsCubit()..load(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit()..load(),
        ),
      ],
      child: const LocaleProvider(
        initial: AppLocale.en,
        child: _ZolyaMaterialApp(),
      ),
    );
  }
}

class _ZolyaMaterialApp extends StatelessWidget {
  const _ZolyaMaterialApp();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        return ShadApp.custom(
          theme: ZolyaShadTheme.light,
          darkTheme: ZolyaShadTheme.dark,
          themeMode: mode,
          appBuilder: (context) => MaterialApp.router(
            title: 'Zolya',
            debugShowCheckedModeBanner: false,
            theme: ZolyaTheme.light,
            darkTheme: ZolyaTheme.dark,
            themeMode: mode,
            routerConfig: appRouter,
            builder: (context, child) => ShadAppBuilder(child: child),
          ),
        );
      },
    );
  }
}

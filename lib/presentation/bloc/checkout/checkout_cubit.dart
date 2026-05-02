import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/delivery_zones.dart';
import '../../../data/fake/fake_data.dart';
import '../../../data/fake/ui_models.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/repositories/address_book_repository.dart';
import '../../../domain/repositories/payment_methods_repository.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({
    required this.addressRepo,
    required this.paymentRepo,
    required int subtotal,
    this.productId,
  }) : super(CheckoutState.initial(subtotal));

  final AddressBookRepository addressRepo;
  final PaymentMethodsRepository paymentRepo;
  final String? productId;

  Future<void> initDefaults() async {
    final addrRes = await addressRepo.getDefault();
    final methodRes = await paymentRepo.getDefault();

    addrRes.fold((_) {}, (a) {
      if (a != null) emit(state.copyWith(address: a));
    });
    methodRes.fold((_) {}, (m) {
      if (m != null) {
        emit(state.copyWith(
          method: m,
          payment: m.provider == MomoProvider.mtn
              ? CheckoutPaymentKind.mtn
              : CheckoutPaymentKind.orange,
        ));
      }
    });
  }

  void changeAddress(AddressUi a) => emit(state.copyWith(address: a));

  void changeMethod(PaymentMethodUi m) {
    emit(state.copyWith(
      method: m,
      payment: m.provider == MomoProvider.mtn
          ? CheckoutPaymentKind.mtn
          : CheckoutPaymentKind.orange,
    ));
  }

  Future<void> changePaymentKind(CheckoutPaymentKind kind) async {
    final wantedProvider =
        kind == CheckoutPaymentKind.mtn ? MomoProvider.mtn : MomoProvider.orange;
    final methods = await paymentRepo.getMethods();
    methods.fold((_) {}, (list) {
      final match =
          list.where((m) => m.provider == wantedProvider).firstOrNull;
      emit(state.copyWith(
        payment: kind,
        method: match ?? state.method,
      ));
    });
  }

  void setPromoCode(String code) => emit(state.copyWith(promoCode: code));

  Future<bool> placeOrder() async {
    emit(state.copyWith(status: CheckoutStatus.placing, clearError: true));
    await Future.delayed(const Duration(milliseconds: 600));

    if (productId != null) {
      final product = FakeData.products.firstWhere(
        (p) => p.id == productId,
        orElse: () => FakeData.products.first,
      );
      final user = FakeData.currentUser;
      final addressLabel = state.address?.fullAddress ?? 'Douala';
      final commission = (product.price * 0.15).round();
      final order = Order(
        id: 'o-${DateTime.now().microsecondsSinceEpoch}',
        orderNumber:
            'ZLY-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        buyerId: user.id,
        sellerId: product.sellerId,
        productId: product.id,
        productTitle: product.title,
        productImageUrl: product.mainImageUrl,
        articlePrice: state.subtotal,
        deliveryFee: state.shippingFee,
        totalAmount: state.total,
        zolyaCommission: commission,
        sellerReceives: product.price - commission,
        status: OrderStatus.paid,
        deliveryAddress: DeliveryAddress(
          neighborhood: addressLabel.split(',').first.trim(),
          street: addressLabel,
          phone: user.phone,
          zone: DeliveryZone.zone2,
        ),
        createdAt: DateTime.now(),
        paidAt: DateTime.now(),
      );
      FakeData.addPurchase(order);
    }

    emit(state.copyWith(status: CheckoutStatus.success));
    return true;
  }
}

extension _FirstOrNullExt<T> on Iterable<T> {
  T? get firstOrNull {
    final it = iterator;
    return it.moveNext() ? it.current : null;
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/fake/ui_models.dart';
import '../../../domain/repositories/payment_methods_repository.dart';
import 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit({required this.repo}) : super(const PaymentMethodsState());

  final PaymentMethodsRepository repo;

  Future<void> load({String? initialSelectedId}) async {
    emit(state.copyWith(loading: true, clearError: true));
    final result = await repo.getMethods();
    result.fold(
      (f) => emit(state.copyWith(loading: false, error: f.toString())),
      (list) {
        final selected = initialSelectedId ??
            state.selectedId ??
            (list.isNotEmpty ? list.first.id : null);
        emit(state.copyWith(
          methods: list,
          selectedId: selected,
          loading: false,
        ));
      },
    );
  }

  void select(String id) => emit(state.copyWith(selectedId: id));

  Future<PaymentMethodUi?> addMethod({
    required MomoProvider provider,
    required String phone,
  }) async {
    final result = await repo.addMethod(provider: provider, phone: phone);
    return result.fold(
      (f) {
        emit(state.copyWith(error: f.toString()));
        return null;
      },
      (added) {
        emit(state.copyWith(
          methods: [...state.methods, added],
          selectedId: added.id,
        ));
        return added;
      },
    );
  }
}

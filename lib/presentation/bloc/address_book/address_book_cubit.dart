import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/fake/ui_models.dart';
import '../../../domain/repositories/address_book_repository.dart';
import 'address_book_state.dart';

class AddressBookCubit extends Cubit<AddressBookState> {
  AddressBookCubit({required this.repo}) : super(const AddressBookState());

  final AddressBookRepository repo;

  Future<void> load({String? initialSelectedId}) async {
    emit(state.copyWith(loading: true, clearError: true));
    final result = await repo.getAddresses();
    result.fold(
      (f) => emit(state.copyWith(loading: false, error: f.toString())),
      (list) {
        final selected = initialSelectedId ??
            state.selectedId ??
            (list.firstWhere((a) => a.isDefault,
                    orElse: () => list.isNotEmpty ? list.first : list.first))
                .id;
        emit(state.copyWith(
          addresses: list,
          selectedId: selected,
          loading: false,
        ));
      },
    );
  }

  void select(String id) => emit(state.copyWith(selectedId: id));

  Future<AddressUi?> addAddress({
    required String label,
    required String fullAddress,
    required bool isDefault,
  }) async {
    final result = await repo.addAddress(
      label: label,
      fullAddress: fullAddress,
      isDefault: isDefault,
    );
    return result.fold(
      (f) {
        emit(state.copyWith(error: f.toString()));
        return null;
      },
      (added) {

        repo.getAddresses().then((res) {
          res.fold((_) {}, (list) {
            emit(state.copyWith(addresses: list, selectedId: added.id));
          });
        });
        return added;
      },
    );
  }
}

import 'package:dartz/dartz.dart';

import '../../config/env.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/address_book_repository.dart';
import 'fake_data.dart';
import 'ui_models.dart';

class FakeAddressBookRepository implements AddressBookRepository {
  final List<AddressUi> _addresses = [...FakeData.addresses];

  Future<void> _latency() =>
      Future.delayed(const Duration(milliseconds: Env.fakeLatencyMs));

  @override
  Future<Either<Failure, List<AddressUi>>> getAddresses() async {
    await _latency();
    return Right(List.unmodifiable(_addresses));
  }

  @override
  Future<Either<Failure, AddressUi?>> getDefault() async {
    await _latency();
    final defaultAddr = _addresses.firstWhere(
      (a) => a.isDefault,
      orElse: () => _addresses.isNotEmpty
          ? _addresses.first
          : FakeData.defaultAddress,
    );
    return Right(defaultAddr);
  }

  @override
  Future<Either<Failure, AddressUi>> addAddress({
    required String label,
    required String fullAddress,
    required bool isDefault,
  }) async {
    await _latency();
    if (isDefault) {
      for (var i = 0; i < _addresses.length; i++) {
        _addresses[i] = _addresses[i].copyWith(isDefault: false);
      }
    }
    final created = AddressUi(
      id: 'a-${DateTime.now().millisecondsSinceEpoch}',
      label: label,
      fullAddress: fullAddress,
      isDefault: isDefault,
    );
    _addresses.add(created);
    return Right(created);
  }
}

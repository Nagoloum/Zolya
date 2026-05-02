import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/address.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<Address>>> getMyAddresses();
  Future<Either<Failure, Address>> addAddress(Address address);
  Future<Either<Failure, Address>> updateAddress(Address address);
  Future<Either<Failure, void>> deleteAddress(String id);
  Future<Either<Failure, void>> setDefault(String id);
}

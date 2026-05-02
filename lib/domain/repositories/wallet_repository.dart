import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/payment.dart';
import '../entities/wallet.dart';

abstract class WalletRepository {
  Future<Either<Failure, Wallet>> getMyWallet();
  Future<Either<Failure, List<WalletTransaction>>> getTransactions({int limit = 50});
  Future<Either<Failure, Withdrawal>> requestWithdrawal({
    required int amount,
    required PaymentProvider provider,
    required String phoneNumber,
  });
  Future<Either<Failure, List<Withdrawal>>> getMyWithdrawals();
}

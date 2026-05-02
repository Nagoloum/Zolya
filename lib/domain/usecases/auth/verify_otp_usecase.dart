import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

class VerifyOtpUseCase extends UseCase<User, VerifyOtpParams> {
  final AuthRepository repository;
  VerifyOtpUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(VerifyOtpParams params) {
    return repository.verifyOtp(params.phone, params.code);
  }
}

class VerifyOtpParams {
  final String phone;
  final String code;
  const VerifyOtpParams({required this.phone, required this.code});
}

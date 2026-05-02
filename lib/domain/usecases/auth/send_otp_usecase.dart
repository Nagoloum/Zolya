import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/auth_repository.dart';

class SendOtpUseCase extends UseCase<void, SendOtpParams> {
  final AuthRepository repository;
  SendOtpUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SendOtpParams params) {
    return repository.sendOtp(params.phone);
  }
}

class SendOtpParams {
  final String phone;
  const SendOtpParams({required this.phone});
}

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

class RegisterUseCase extends UseCase<User, RegisterParams> {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) {
    return repository.register(
      fullName: params.fullName,
      phone: params.phone,
      password: params.password,
    );
  }
}

class RegisterParams {
  final String fullName;
  final String phone;
  final String password;
  const RegisterParams({required this.fullName, required this.phone, required this.password});
}

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

class LoginUseCase extends UseCase<User, LoginParams> {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return repository.login(phone: params.phone, password: params.password);
  }
}

class LoginParams {
  final String phone;
  final String password;
  const LoginParams({required this.phone, required this.password});
}

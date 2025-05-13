import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:fpdart/src/either.dart';

class SignOutParams {}

class SignOutUseCase implements Usecase<void, SignOutParams> {
  SignOutUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call(SignOutParams signOutParams) async {
    return await authRepository.signOut();
  }
}

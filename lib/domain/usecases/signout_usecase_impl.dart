import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:fpdart/src/either.dart';

class SignOutUseCase implements Usecase<void, NoParams> {
  SignOutUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call(NoParams noParams) async {
    return await authRepository.signOut();
  }
}

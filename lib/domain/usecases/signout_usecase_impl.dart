import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class SignOutUseCase implements Usecase<void, NoParams> {
  SignOutUseCase({required this.localHostAuthRepository});

  final LocalHostAuthRepository localHostAuthRepository;

  @override
  Future<Either<Failure, void>> call(NoParams noParams) async {
    return await localHostAuthRepository.signOut();
  }
}

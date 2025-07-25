import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class AlreadySignedIn implements Usecase<UserModel, NoParams> {
  AlreadySignedIn({required this.localHostAuthRepository});

  final LocalHostAuthRepository localHostAuthRepository;
  @override
  Future<Either<Failure, UserModel>> call(NoParams noParams) async {
    return await localHostAuthRepository.getUserSession();
  }
}

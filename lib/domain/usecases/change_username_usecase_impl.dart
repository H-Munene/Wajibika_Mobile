import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class ChangeUsernameUsecaseImpl implements Usecase<void, ChangeUsernameParams> {
  ChangeUsernameUsecaseImpl({
    required LocalHostAuthRepository localHostAuthRepository,
  }) : _localHostAuthRepository = localHostAuthRepository;

  final LocalHostAuthRepository _localHostAuthRepository;

  @override
  Future<Either<Failure, void>> call(
    ChangeUsernameParams changeUsernameParams,
  ) async {
    return await _localHostAuthRepository.changeUsername(
      new_username: changeUsernameParams.newUsername,
    );
  }
}

class ChangeUsernameParams {
  ChangeUsernameParams({required this.newUsername});

  final String newUsername;
}

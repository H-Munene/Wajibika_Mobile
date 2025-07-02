import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class ChangeEmailUsernameUsecaseImpl
    implements Usecase<void, ChangeEmailUsernameParams> {
  ChangeEmailUsernameUsecaseImpl({
    required LocalHostAuthRepository localHostAuthRepository,
  }) : _localHostAuthRepository = localHostAuthRepository;

  final LocalHostAuthRepository _localHostAuthRepository;

  @override
  Future<Either<Failure, void>> call(
    ChangeEmailUsernameParams changeEmailUsernameParams,
  ) async {
    return await _localHostAuthRepository.changeEmailUsername(
      new_username: changeEmailUsernameParams.new_username,
      new_email: changeEmailUsernameParams.new_email,
      current_password: changeEmailUsernameParams.current_password,
    );
  }
}

class ChangeEmailUsernameParams {
  const ChangeEmailUsernameParams({
    required this.new_username,
    required this.new_email,
    required this.current_password,
  });

  final String new_username;
  final String new_email;
  final String current_password;
}

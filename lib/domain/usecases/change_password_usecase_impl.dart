import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class ChangePasswordParams {
  const ChangePasswordParams({
    required this.current_email,
    required this.terminal_token,
    required this.new_password,
  });

  final String current_email;
  final String terminal_token;
  final String new_password;
}

class ChangePasswordUsecaseImpl implements Usecase<void, ChangePasswordParams> {
  const ChangePasswordUsecaseImpl({
    required LocalHostAuthRepository localHostAuthRepository,
  }) : _localHostAuthRepository = localHostAuthRepository;

  final LocalHostAuthRepository _localHostAuthRepository;
  @override
  Future<Either<Failure, void>> call(
    ChangePasswordParams changePasswordParams,
  ) async {
    return await _localHostAuthRepository.changePassword(
      current_email: changePasswordParams.current_email,
      terminal_token: changePasswordParams.terminal_token,
      new_password: changePasswordParams.new_password,
    );
  }
}

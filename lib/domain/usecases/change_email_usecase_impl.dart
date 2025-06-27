import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class ChangeEmailParams {
  const ChangeEmailParams({
    required this.current_password,
    required this.newEmail,
  });

  final String newEmail;
  final String current_password;
}

class ChangeEmailUsecaseImpl implements Usecase<void, ChangeEmailParams> {
  const ChangeEmailUsecaseImpl({
    required LocalHostAuthRepository localHostAuthRepository,
  }) : _localHostAuthRepository = localHostAuthRepository;

  final LocalHostAuthRepository _localHostAuthRepository;
  @override
  Future<Either<Failure, void>> call(
    ChangeEmailParams changeEmailParams,
  ) async {
    return _localHostAuthRepository.changeEmail(
      new_email: changeEmailParams.newEmail,
      current_password: changeEmailParams.current_password,
    );
  }
}

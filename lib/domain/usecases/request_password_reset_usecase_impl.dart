import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class RequestPasswordResetParams {
  const RequestPasswordResetParams({required this.current_email});

  final String current_email;
}

class RequestPasswordResetUsecaseImpl
    implements Usecase<int, RequestPasswordResetParams> {
  const RequestPasswordResetUsecaseImpl({
    required LocalHostAuthRepository localHostAuthRepository,
  }) : _localHostAuthRepository = localHostAuthRepository;

  final LocalHostAuthRepository _localHostAuthRepository;
  @override
  Future<Either<Failure, int>> call(
    RequestPasswordResetParams requestPasswordResetParams,
  ) async {
    final response = await _localHostAuthRepository.requestPasswordReset(
      current_email: requestPasswordResetParams.current_email,
    );

    if (response != 200) {
      return left(Failure('This email is not recognised in our system'));
    }

    return right(response);
  }
}

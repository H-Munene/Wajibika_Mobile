import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class GetHomeFeedUseCase implements Usecase<HomeFeedModel, NoParams> {
  GetHomeFeedUseCase({required LocalHostAuthRepository localHostAuthRepository})
    : _localHostAuthRepository = localHostAuthRepository;

  final LocalHostAuthRepository _localHostAuthRepository;

  @override
  Future<Either<Failure, HomeFeedModel>> call(NoParams noParams) async {
    return await _localHostAuthRepository.getHomeFeed();
  }
}

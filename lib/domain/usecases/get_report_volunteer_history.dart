import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class GetReportVolunteerHistoryUseCase
    implements Usecase<ReportVolunteerHistoryModel, NoParams> {
  GetReportVolunteerHistoryUseCase({
    required LocalHostAuthRepository localHostAuthRepository,
  }) : _localHostAuthRepository = localHostAuthRepository;

  final LocalHostAuthRepository _localHostAuthRepository;
  @override
  Future<Either<Failure, ReportVolunteerHistoryModel>> call(NoParams p) async {
    return await _localHostAuthRepository.getReportandVolunteerHistory();
  }
}

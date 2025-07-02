import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class GetReportHistoryOnSpecifiDateUsecase
    implements
        Usecase<ReportListSpecificDateModel, GetReportHistoryOnSpecificDate> {
  GetReportHistoryOnSpecifiDateUsecase({
    required LocalHostAuthRepository localHostAuthRepository,
  }) : _localHostAuthRepository = localHostAuthRepository;

  final LocalHostAuthRepository _localHostAuthRepository;

  @override
  Future<Either<Failure, ReportListSpecificDateModel>> call(
    GetReportHistoryOnSpecificDate getReportHistoryOnSpecific,
  ) async {
    return await _localHostAuthRepository.getReportHistorySpecificDate(
      date: getReportHistoryOnSpecific.date,
    );
  }
}

class GetReportHistoryOnSpecificDate {
  const GetReportHistoryOnSpecificDate({required this.date});

  final String date;
}

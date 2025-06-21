import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class ReportSubmissionParams {
  const ReportSubmissionParams({
    required this.imagePath,
    required this.category,
    required this.description,
  });

  final String imagePath;
  final String category;
  final String description;
}

class SubmitReportUsecaseImpl implements Usecase<void, ReportSubmissionParams> {
  SubmitReportUsecaseImpl({
    required LocalHostAuthRepository localHostAuthRepository,
  }) : _localHostAuthRepository = localHostAuthRepository;

  final LocalHostAuthRepository _localHostAuthRepository;
  @override
  Future<Either<Failure, void>> call(
    ReportSubmissionParams reportSubmissionParams,
  ) async {
    return await _localHostAuthRepository.submitReport(
      imagePath: reportSubmissionParams.imagePath,
      category: reportSubmissionParams.category,
      description: reportSubmissionParams.description,
    );
  }
}

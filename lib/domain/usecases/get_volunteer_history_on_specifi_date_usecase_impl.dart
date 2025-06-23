import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class GetVolunteerHistoryOnSpecifiDateUsecase
    implements
        Usecase<
          ReportVolunteerListSpecificDateModel,
          GetVolunteerHistoryOnSpecificDate
        > {
  GetVolunteerHistoryOnSpecifiDateUsecase({
    required LocalHostAuthRepository localHostAuthRepository,
  }) : _localHostAuthRepository = localHostAuthRepository;

  final LocalHostAuthRepository _localHostAuthRepository;

  @override
  Future<Either<Failure, ReportVolunteerListSpecificDateModel>> call(
    GetVolunteerHistoryOnSpecificDate getVolunteerHistoryOnSpecific,
  ) async {
    return await _localHostAuthRepository.getVolunteerHistorySpecificDate(
      date: getVolunteerHistoryOnSpecific.date,
    );
  }
}

class GetVolunteerHistoryOnSpecificDate {
  const GetVolunteerHistoryOnSpecificDate({required this.date});

  final String date;
}

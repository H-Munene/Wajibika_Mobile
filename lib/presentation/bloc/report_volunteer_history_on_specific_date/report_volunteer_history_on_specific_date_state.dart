part of 'report_volunteer_history_on_specific_date_bloc.dart';

final class ReportVolunteerHistoryOnSpecificDateState extends Equatable {
  const ReportVolunteerHistoryOnSpecificDateState({
    required this.isLoading,
    required this.reportVolunteerListSpecificDateModel,
  });

  final bool isLoading;
  final ReportVolunteerListSpecificDateModel
  reportVolunteerListSpecificDateModel;

  ReportVolunteerHistoryOnSpecificDateState copyWith({
    bool? updatedIsLoading,
    ReportVolunteerListSpecificDateModel?
    newReportVolunteerListSpecificDateModel,
  }) {
    return ReportVolunteerHistoryOnSpecificDateState(
      reportVolunteerListSpecificDateModel:
          newReportVolunteerListSpecificDateModel ??
          reportVolunteerListSpecificDateModel,
      isLoading: updatedIsLoading ?? isLoading,
    );
  }

  @override
  List<Object> get props => [reportVolunteerListSpecificDateModel];
}

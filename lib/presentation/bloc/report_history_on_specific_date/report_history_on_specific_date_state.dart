part of 'report_history_on_specific_date_bloc.dart';

final class ReportVolunteerHistoryOnSpecificDateState extends Equatable {
  const ReportVolunteerHistoryOnSpecificDateState({
    required this.volunteerListSpecificDate,
    required this.isLoading,
    required this.reportListSpecificDateModel,
  });

  final bool isLoading;
  final ReportListSpecificDateModel reportListSpecificDateModel;
  final VolunteerListSpecificDateModel volunteerListSpecificDate;

  ReportVolunteerHistoryOnSpecificDateState copyWith({
    ReportListSpecificDateModel? newReportListSpecificDateModel,
    VolunteerListSpecificDateModel? newVolunteereListSpecificDate,
    bool? updatedIsLoading,
  }) {
    return ReportVolunteerHistoryOnSpecificDateState(
      volunteerListSpecificDate:
          newVolunteereListSpecificDate ?? volunteerListSpecificDate,
      isLoading: updatedIsLoading ?? isLoading,
      reportListSpecificDateModel:
          newReportListSpecificDateModel ?? reportListSpecificDateModel,
    );
  }

  @override
  List<Object> get props => [
    reportListSpecificDateModel,
    volunteerListSpecificDate,
  ];
}

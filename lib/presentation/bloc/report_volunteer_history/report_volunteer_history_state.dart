part of 'report_volunteer_history_bloc.dart';

class ReportVolunteerHistoryState {
  const ReportVolunteerHistoryState({
    required this.reportHistoryCount,
    required this.volunteerHistoryCount,
    required this.reportHistoryDataset,
    required this.volunteerHistoryDataset,
  });

  // final ReportVolunteerHistoryModel reportVolunteerHistoryModel;

  final Map<DateTime, int> reportHistoryDataset;
  final Map<DateTime, int> volunteerHistoryDataset;
  final int reportHistoryCount;
  final int volunteerHistoryCount;

  ReportVolunteerHistoryState copyWith({
    Map<DateTime, int>? updatedReportHistoryDataset,
    Map<DateTime, int>? updatedVolunteerHistoryDataset,
    int? updatedReportHistoryCount,
    int? updatedVolunteerHistoryCount,
  }) {
    return ReportVolunteerHistoryState(
      reportHistoryDataset: updatedReportHistoryDataset ?? reportHistoryDataset,
      volunteerHistoryDataset:
          updatedVolunteerHistoryDataset ?? volunteerHistoryDataset,
      reportHistoryCount: updatedReportHistoryCount ?? volunteerHistoryCount,
      volunteerHistoryCount:
          updatedVolunteerHistoryCount ?? volunteerHistoryCount,
    );
  }
}

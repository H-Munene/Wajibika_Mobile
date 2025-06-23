part of 'report_volunteer_history_on_specific_date_bloc.dart';

sealed class ReportVolunteerHistoryOnSpecificDateEvent extends Equatable {
  const ReportVolunteerHistoryOnSpecificDateEvent();

  @override
  List<Object> get props => [];
}

final class VolunteerHistoryOnSpecificDateRequest
    extends ReportVolunteerHistoryOnSpecificDateEvent {
  const VolunteerHistoryOnSpecificDateRequest({required this.date});

  final String date;
}

final class ReportHistoryOnSpecificDateRequest
    extends ReportVolunteerHistoryOnSpecificDateEvent {
  const ReportHistoryOnSpecificDateRequest({required this.date});

  final String date;
}

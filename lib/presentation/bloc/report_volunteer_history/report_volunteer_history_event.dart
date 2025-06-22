part of 'report_volunteer_history_bloc.dart';

sealed class ReportVolunteerHistoryEvent extends Equatable {
  const ReportVolunteerHistoryEvent();

  @override
  List<Object> get props => [];
}

final class ReportVolunteerHistoryEventRequest
    extends ReportVolunteerHistoryEvent {}

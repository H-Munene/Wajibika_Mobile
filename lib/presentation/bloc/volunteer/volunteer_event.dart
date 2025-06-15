part of 'volunteer_bloc.dart';

sealed class VolunteerEvent extends Equatable {
  const VolunteerEvent();

  @override
  List<Object> get props => [];
}

final class VolunteerEventToggleVolunteerPresence extends VolunteerEvent {
  const VolunteerEventToggleVolunteerPresence({required this.reportModel});

  final ReportModel reportModel;
}

final class VolunteerEventFetchInitialRegisteredVolunteerEvents
    extends VolunteerEvent {}

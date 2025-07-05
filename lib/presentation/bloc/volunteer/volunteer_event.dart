part of 'volunteer_bloc.dart';

sealed class VolunteerEvent extends Equatable {
  const VolunteerEvent();

  @override
  List<Object> get props => [];
}

final class VolunteerEventToggleVolunteerPresence extends VolunteerEvent {
  const VolunteerEventToggleVolunteerPresence({
    required this.reportHomeFeedModel,
  });

  final ReportHomeFeedModel reportHomeFeedModel;
}

final class VolunteerEventFetchInitialRegisteredVolunteerEvents
    extends VolunteerEvent {
  const VolunteerEventFetchInitialRegisteredVolunteerEvents({
    required this.homeFeedModel,
  });

  final HomeFeedModel homeFeedModel;
}

final class VolunteerEventClear extends VolunteerEvent {}

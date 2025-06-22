part of 'volunteer_bloc.dart';

class VolunteerState extends Equatable {
  const VolunteerState({required this.registeredVolunteerEvents});

  VolunteerState copyWith({
    List<ReportHomeFeedModel>? initialRegisteredVolunteerEvents,
  }) {
    return VolunteerState(
      registeredVolunteerEvents:
          initialRegisteredVolunteerEvents ?? registeredVolunteerEvents,
    );
  }

  final List<ReportHomeFeedModel> registeredVolunteerEvents;

  bool registeredAsVolunteerForThisReport({
    required ReportHomeFeedModel reportHomeFeedModel,
  }) => registeredVolunteerEvents.contains(reportHomeFeedModel);

  VolunteerState _addToVolunteerEvents({
    required ReportHomeFeedModel reportHomeFeedModel,
  }) {
    final updatedregisteredVolunteerEvents = List.of(registeredVolunteerEvents)
      ..add(reportHomeFeedModel);

    return VolunteerState(
      registeredVolunteerEvents: updatedregisteredVolunteerEvents,
    );
  }

  VolunteerState _removeFromVolunteerEvents({
    required ReportHomeFeedModel reportHomeFeedModel,
  }) {
    final updatedregisteredVolunteerEvents = List.of(registeredVolunteerEvents)
      ..remove(reportHomeFeedModel);

    return VolunteerState(
      registeredVolunteerEvents: updatedregisteredVolunteerEvents,
    );
  }

  VolunteerState togglePresenceinVolunteerEvents({
    required ReportHomeFeedModel reportHomeFeedModel,
  }) {
    // registered as volunteer for event, hence remove
    if (registeredAsVolunteerForThisReport(
      reportHomeFeedModel: reportHomeFeedModel,
    )) {
      return _removeFromVolunteerEvents(
        reportHomeFeedModel: reportHomeFeedModel,
      );
    }

    // not registered as volunteer for event, hence add
    return _addToVolunteerEvents(reportHomeFeedModel: reportHomeFeedModel);
  }

  @override
  List<Object> get props => [registeredVolunteerEvents];
}

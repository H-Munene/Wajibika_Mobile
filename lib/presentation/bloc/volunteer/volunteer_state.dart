part of 'volunteer_bloc.dart';

class VolunteerState extends Equatable {
  const VolunteerState({required this.registeredVolunteerEvents});

  VolunteerState copyWith({
    List<ReportModel>? initialRegisteredVolunteerEvents,
  }) {
    return VolunteerState(
      registeredVolunteerEvents:
          initialRegisteredVolunteerEvents ?? registeredVolunteerEvents,
    );
  }

  final List<ReportModel> registeredVolunteerEvents;

  bool registeredAsVolunteerForThisReport({required ReportModel reportModel}) =>
      registeredVolunteerEvents.contains(reportModel);

  VolunteerState _addToVolunteerEvents({required ReportModel reportModel}) {
    final updatedregisteredVolunteerEvents = List.of(registeredVolunteerEvents)
      ..add(reportModel);

    return VolunteerState(
      registeredVolunteerEvents: updatedregisteredVolunteerEvents,
    );
  }

  VolunteerState _removeFromVolunteerEvents({
    required ReportModel reportModel,
  }) {
    final updatedregisteredVolunteerEvents = List.of(registeredVolunteerEvents)
      ..remove(reportModel);

    return VolunteerState(
      registeredVolunteerEvents: updatedregisteredVolunteerEvents,
    );
  }

  VolunteerState togglePresenceinVolunteerEvents({
    required ReportModel reportModel,
  }) {
    // registered as volunteer for event, hence remove
    if (registeredAsVolunteerForThisReport(reportModel: reportModel)) {
      return _removeFromVolunteerEvents(reportModel: reportModel);
    }

    // not registered as volunteer for event, hence add
    return _addToVolunteerEvents(reportModel: reportModel);
  }

  @override
  List<Object> get props => [registeredVolunteerEvents];
}

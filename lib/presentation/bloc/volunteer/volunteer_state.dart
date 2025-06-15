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

  factory VolunteerState.fromJson(Map<String, dynamic> json) =>
      _$VolunteerStateFromJson(json);

  @override
  List<Object> get props => [registeredVolunteerEvents];
}

VolunteerState _$VolunteerStateFromJson(Map<String, dynamic> json) =>
    VolunteerState(
      registeredVolunteerEvents:
          (json['registeredVolunteerEvents'] as List<dynamic>)
              .map((e) => ReportModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$VolunteerStateToJson(VolunteerState instance) =>
    <String, dynamic>{
      'registeredVolunteerEvents':
          instance.registeredVolunteerEvents.map((e) => e.toJson()).toList(),
    };

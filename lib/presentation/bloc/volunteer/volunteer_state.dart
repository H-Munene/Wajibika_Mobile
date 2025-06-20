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

  factory VolunteerState.fromJson(Map<String, dynamic> json) =>
      _$VolunteerStateFromJson(json);

  @override
  List<Object> get props => [registeredVolunteerEvents];
}

VolunteerState _$VolunteerStateFromJson(Map<String, dynamic> json) =>
    VolunteerState(
      registeredVolunteerEvents:
          (json['registeredVolunteerEvents'] as List<dynamic>)
              .map(
                (e) => ReportHomeFeedModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );

Map<String, dynamic> _$VolunteerStateToJson(VolunteerState instance) =>
    <String, dynamic>{
      'registeredVolunteerEvents':
          instance.registeredVolunteerEvents.map((e) => e.toJson()).toList(),
    };

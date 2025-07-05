import 'package:bloc_clean_arch/data/models/registered_volunteer_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registered_list_volunteer_events.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisteredListVolunteerEvents {
  RegisteredListVolunteerEvents({required this.registered_volunteer_events});

  final List<RegisteredVolunteerModel> registered_volunteer_events;

  factory RegisteredListVolunteerEvents.fromJson(Map<String, dynamic> json) =>
      _$RegisteredListVolunteerEventsFromJson(json);

  Map<String, dynamic> toJson() => _$RegisteredListVolunteerEventsToJson(this);
}

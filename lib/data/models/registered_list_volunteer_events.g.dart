// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registered_list_volunteer_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisteredListVolunteerEvents _$RegisteredListVolunteerEventsFromJson(
  Map<String, dynamic> json,
) => RegisteredListVolunteerEvents(
  registered_volunteer_events:
      (json['registered_volunteer_events'] as List<dynamic>)
          .map(
            (e) => RegisteredVolunteerModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$RegisteredListVolunteerEventsToJson(
  RegisteredListVolunteerEvents instance,
) => <String, dynamic>{
  'registered_volunteer_events':
      instance.registered_volunteer_events.map((e) => e.toJson()).toList(),
};

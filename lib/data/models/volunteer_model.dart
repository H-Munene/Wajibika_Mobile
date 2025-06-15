import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'volunteer_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VolunteerModel extends VolunteerEntity {
  VolunteerModel({
    required super.imageUrl,
    required super.volunteerCount,
    required super.username,
    required super.time,
    required super.description,
    required super.scheduleDate,
  });

  factory VolunteerModel.fromJson(Map<String, dynamic> json) =>
      _$VolunteerModelFromJson(json);

  Map<String, dynamic> toJson() => _$VolunteerModelToJson(this);

  // only update the volunteer count
  VolunteerModel copyWith({int? updatedvolunteerCount}) => VolunteerModel(
    imageUrl: imageUrl,
    volunteerCount: updatedvolunteerCount ?? volunteerCount,
    username: username,
    time: time,
    description: description,
    scheduleDate: scheduleDate,
  );
}

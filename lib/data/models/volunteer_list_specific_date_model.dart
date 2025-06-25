import 'package:bloc_clean_arch/data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'volunteer_list_specific_date_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VolunteerListSpecificDateModel extends Equatable {
  const VolunteerListSpecificDateModel({required this.events});

  final List<VolunteerSpecificDateModel> events;

  factory VolunteerListSpecificDateModel.fromJson(Map<String, dynamic> json) =>
      _$VolunteerListSpecificDateModelFromJson(json);

  Map<String, dynamic> toJson() => _$VolunteerListSpecificDateModelToJson(this);

  @override
  List<Object?> get props => [events];
}

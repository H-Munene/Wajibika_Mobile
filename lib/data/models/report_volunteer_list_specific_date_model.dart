import 'package:bloc_clean_arch/data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_volunteer_list_specific_date_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportVolunteerListSpecificDateModel extends Equatable {
  const ReportVolunteerListSpecificDateModel({
    required this.reportVolunteerSpecificDateModel,
  });

  final List<ReportVolunteerSpecificDateModel> reportVolunteerSpecificDateModel;

  factory ReportVolunteerListSpecificDateModel.fromJson(
    Map<String, dynamic> json,
  ) => _$ReportVolunteerListSpecificDateModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ReportVolunteerListSpecificDateModelToJson(this);

  @override
  List<Object?> get props => [reportVolunteerSpecificDateModel];
}

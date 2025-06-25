import 'package:equatable/equatable.dart';

class VolunteerEntity extends Equatable {
  const VolunteerEntity({
    required this.imageUrl,
    required this.volunteerCount,
    required this.username,
    required this.time,
    required this.description,
    required this.scheduleDate,
  });

  final String imageUrl;
  final int volunteerCount;
  final String username;
  final String time;
  final String description;
  final String scheduleDate;

  @override
  List<Object?> get props => [
    imageUrl,
    volunteerCount,
    username,
    time,
    description,
    scheduleDate,
  ];
}

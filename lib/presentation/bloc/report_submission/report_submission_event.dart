part of 'report_submission_bloc.dart';

sealed class ReportSubmissionEvent extends Equatable {
  const ReportSubmissionEvent();

  @override
  List<Object> get props => [];
}

final class ReportSubmissionSubmit extends ReportSubmissionEvent {
  const ReportSubmissionSubmit({
    required this.imagePath,
    required this.category,
    required this.description,
  });

  final String imagePath;
  final String category;
  final String description;
}

final class ReportSubmissionCancel extends ReportSubmissionEvent {}

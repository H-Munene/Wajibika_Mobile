part of 'report_submission_bloc.dart';

sealed class ReportSubmissionState extends Equatable {
  const ReportSubmissionState();

  @override
  List<Object> get props => [];
}

final class ReportSubmissionNoSubmission extends ReportSubmissionState {}

final class ReportSubmissionSuccess extends ReportSubmissionState {}

final class ReportSubmissionFailed extends ReportSubmissionState {
  const ReportSubmissionFailed({required this.message});

  final String message;
}

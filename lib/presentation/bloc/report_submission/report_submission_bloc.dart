import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'report_submission_event.dart';
part 'report_submission_state.dart';

class ReportSubmissionBloc
    extends Bloc<ReportSubmissionEvent, ReportSubmissionState> {
  final SubmitReportUsecaseImpl _submitReportUsecaseImpl;

  ReportSubmissionBloc({
    required SubmitReportUsecaseImpl submitReportUsecaseImpl,
  }) : _submitReportUsecaseImpl = submitReportUsecaseImpl,
       super(ReportSubmissionNoSubmission()) {
    on<ReportSubmissionSubmit>(_onReportSubmission);
    on<ReportSubmissionCancel>(_onReportSubmissionCancel);
  }

  Future<void> _onReportSubmission(
    ReportSubmissionSubmit event,
    Emitter<ReportSubmissionState> emit,
  ) async {
    final submitReport = await _submitReportUsecaseImpl.call(
      ReportSubmissionParams(
        imagePath: event.imagePath,
        category: event.category,
        description: event.description,
      ),
    );

    submitReport.fold(
      (error) {
        // will be used by snackbar
        emit(ReportSubmissionFailed(message: error.message));

        // go back to initialstate
        emit(ReportSubmissionNoSubmission());
      },
      (_) {
        // success
        emit(ReportSubmissionSuccess());

        // go back to inital state
        emit(ReportSubmissionNoSubmission());
      },
    );
  }

  Future<void> _onReportSubmissionCancel(
    ReportSubmissionCancel event,
    Emitter<ReportSubmissionState> emit,
  ) async {
    emit(ReportSubmissionNoSubmission());
  }
}

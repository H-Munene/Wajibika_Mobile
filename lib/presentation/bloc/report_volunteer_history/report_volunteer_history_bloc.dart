import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'report_volunteer_history_event.dart';
part 'report_volunteer_history_state.dart';

class ReportVolunteerHistoryBloc
    extends Bloc<ReportVolunteerHistoryEvent, ReportVolunteerHistoryState> {
  final GetReportVolunteerHistoryUseCase _getReportVolunteerHistoryUseCase;
  ReportVolunteerHistoryBloc({
    required GetReportVolunteerHistoryUseCase getReportVolunteerHistoryUseCase,
  }) : _getReportVolunteerHistoryUseCase = getReportVolunteerHistoryUseCase,
       super(
         const ReportVolunteerHistoryState(
           reportHistoryDataset: {},
           volunteerHistoryDataset: {},
           reportHistoryCount: 0,
           volunteerHistoryCount: 0,
         ),
       ) {
    on<ReportVolunteerHistoryEventRequest>(
      _onRequestReportsandVolunteerHistory,
    );
  }

  Future<void> _onRequestReportsandVolunteerHistory(
    ReportVolunteerHistoryEventRequest event,
    Emitter<ReportVolunteerHistoryState> emit,
  ) async {
    final response = await _getReportVolunteerHistoryUseCase.call(NoParams());

    response.fold((error) => emit(state), (reportVolunteerHistoryModel) {
      final reportHistoryCount =
          reportVolunteerHistoryModel.report_history.total_reports_count;

      final volunteerHistoryCount =
          reportVolunteerHistoryModel
              .volunteer_history
              .total_volunteer_events_count;

      final List<DailyCounts> reportHistoryDateTimeCountIterable =
          reportVolunteerHistoryModel.report_history.daily_counts;

      final List<DailyCounts> volunteerHistoryDateTimeCountIterable =
          reportVolunteerHistoryModel.volunteer_history.daily_counts;

      final Map<DateTime, int> reportHistoryDataset =
          Map<DateTime, int>.fromIterable(
            reportHistoryDateTimeCountIterable,
            key: (item) {
              final datum = item as DailyCounts;
              return DateTime.parse(datum.date);
            },
            value: (item) {
              final datum = item as DailyCounts;
              return datum.count;
            },
          );

      final Map<DateTime, int> volunteerHistoryDataset =
          Map<DateTime, int>.fromIterable(
            volunteerHistoryDateTimeCountIterable,
            key: (item) {
              final datum = item as DailyCounts;
              return DateTime.parse(datum.date);
            },
            value: (item) {
              final datum = item as DailyCounts;
              return datum.count;
            },
          );

      emit(
        state.copyWith(
          updatedReportHistoryDataset: reportHistoryDataset,
          updatedVolunteerHistoryDataset: volunteerHistoryDataset,
          updatedReportHistoryCount: reportHistoryCount,
          updatedVolunteerHistoryCount: volunteerHistoryCount,
        ),
      );
    });
  }
}

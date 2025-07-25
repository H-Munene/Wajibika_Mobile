import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'report_history_on_specific_date_event.dart';
part 'report_history_on_specific_date_state.dart';

class ReportVolunteerHistoryOnSpecificDateBloc
    extends
        Bloc<
          ReportVolunteerHistoryOnSpecificDateEvent,
          ReportVolunteerHistoryOnSpecificDateState
        > {
  final GetReportHistoryOnSpecifiDateUsecase
  _getReportHistoryOnSpecifiDateUsecase;
  final GetVolunteerHistoryOnSpecifiDateUsecase
  _getVolunteerHistoryOnSpecificDateUsecase;

  ReportVolunteerHistoryOnSpecificDateBloc({
    required GetVolunteerHistoryOnSpecifiDateUsecase
    getVolunteerHistoryOnSpecificDateUsecase,
    required GetReportHistoryOnSpecifiDateUsecase
    getReportHistoryOnSpecifiDateUsecase,
  }) : _getVolunteerHistoryOnSpecificDateUsecase =
           getVolunteerHistoryOnSpecificDateUsecase,
       _getReportHistoryOnSpecifiDateUsecase =
           getReportHistoryOnSpecifiDateUsecase,
       super(
         const ReportVolunteerHistoryOnSpecificDateState(
           isLoading: false,
           reportListSpecificDateModel: ReportListSpecificDateModel(
             reports: [],
           ),
           volunteerListSpecificDate: VolunteerListSpecificDateModel(
             events: [],
           ),
         ),
       ) {
    on<ReportHistoryOnSpecificDateRequest>(
      _onRequestReportHistoryOnSpecificDate,
    );
    on<ReportVolunteerHistoryClearState>(_onClearState);
    on<VolunteerHistoryOnSpecificDateRequest>(
      _onRequestVolunteerHistoryOnSpecificDate,
    );
  }

  Future<void> _onRequestReportHistoryOnSpecificDate(
    ReportHistoryOnSpecificDateRequest event,
    Emitter<ReportVolunteerHistoryOnSpecificDateState> emit,
  ) async {
    emit(state.copyWith(updatedIsLoading: true));

    final response = await _getReportHistoryOnSpecifiDateUsecase.call(
      GetReportHistoryOnSpecificDate(date: event.date),
    );

    response.fold(
      (error) {
        emit(state.copyWith(updatedIsLoading: false));
      },
      (history) {
        emit(
          state.copyWith(
            updatedIsLoading: false,
            newReportListSpecificDateModel: history,
          ),
        );
      },
    );
  }

  Future<void> _onRequestVolunteerHistoryOnSpecificDate(
    VolunteerHistoryOnSpecificDateRequest event,
    Emitter<ReportVolunteerHistoryOnSpecificDateState> emit,
  ) async {
    emit(state.copyWith(updatedIsLoading: true));

    final response = await _getVolunteerHistoryOnSpecificDateUsecase.call(
      GetVolunteerHistoryOnSpecificDate(date: event.date),
    );

    response.fold(
      (error) {
        emit(state.copyWith(updatedIsLoading: false));
      },
      (history) {
        emit(
          state.copyWith(
            updatedIsLoading: false,
            newVolunteereListSpecificDate: history,
          ),
        );
      },
    );
  }

  Future<void> _onClearState(
    ReportVolunteerHistoryClearState event,
    Emitter<ReportVolunteerHistoryOnSpecificDateState> emit,
  ) async {
    emit(
      const ReportVolunteerHistoryOnSpecificDateState(
        isLoading: false,
        reportListSpecificDateModel: ReportListSpecificDateModel(reports: []),
        volunteerListSpecificDate: VolunteerListSpecificDateModel(events: []),
      ),
    );
  }
}

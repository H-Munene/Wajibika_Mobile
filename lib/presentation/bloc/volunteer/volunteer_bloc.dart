import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:equatable/equatable.dart';

part 'volunteer_event.dart';
part 'volunteer_state.dart';

class VolunteerBloc extends Bloc<VolunteerEvent, VolunteerState> {
  VolunteerBloc() : super(const VolunteerState(registeredVolunteerEvents: [])) {
    on<VolunteerEventToggleVolunteerPresence>(_onToggleVolunteerEventStatus);
    on<VolunteerEventFetchInitialRegisteredVolunteerEvents>(
      _onFetchInitialRegisteredVolunteerEvents,
    );
  }

  Future<void> _onToggleVolunteerEventStatus(
    VolunteerEventToggleVolunteerPresence event,
    Emitter<VolunteerState> emit,
  ) async {
    emit(state.togglePresenceinVolunteerEvents(reportModel: event.reportModel));

    emit(state);
  }

  Future<void> _onFetchInitialRegisteredVolunteerEvents(
    VolunteerEventFetchInitialRegisteredVolunteerEvents event,
    Emitter<VolunteerState> emit,
  ) async {
    final List<ReportModel> fetchedVolunteerEvents = [];

    emit(
      state.copyWith(
        initialRegisteredVolunteerEvents: [
          ...state.registeredVolunteerEvents,
          ...fetchedVolunteerEvents,
        ],
      ),
    );
  }
}

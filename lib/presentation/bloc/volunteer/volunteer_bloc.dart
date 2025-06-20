import 'dart:async';

import 'package:bloc_clean_arch/data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'volunteer_event.dart';
part 'volunteer_state.dart';

class VolunteerBloc extends HydratedBloc<VolunteerEvent, VolunteerState> {
  VolunteerBloc() : super(const VolunteerState(registeredVolunteerEvents: [])) {
    on<VolunteerEventToggleVolunteerPresence>(_onToggleVolunteerEventStatus);
    on<VolunteerEventFetchInitialRegisteredVolunteerEvents>(
      _onFetchInitialRegisteredVolunteerEvents,
    );
    on<VolunteerEventClear>(_onClear);
  }

  Future<void> _onToggleVolunteerEventStatus(
    VolunteerEventToggleVolunteerPresence event,
    Emitter<VolunteerState> emit,
  ) async {
    emit(
      state.togglePresenceinVolunteerEvents(
        reportHomeFeedModel: event.reportHomeFeedModel,
      ),
    );

    emit(state);
  }

  Future<void> _onFetchInitialRegisteredVolunteerEvents(
    VolunteerEventFetchInitialRegisteredVolunteerEvents event,
    Emitter<VolunteerState> emit,
  ) async {
    final List<ReportHomeFeedModel> fetchedVolunteerEvents = [];

    emit(
      state.copyWith(
        initialRegisteredVolunteerEvents: [
          ...state.registeredVolunteerEvents,
          ...fetchedVolunteerEvents,
        ],
      ),
    );
  }

  Future<void> _onClear(
    VolunteerEventClear event,
    Emitter<VolunteerState> emit,
  ) async {
    emit(state.copyWith(initialRegisteredVolunteerEvents: []));
  }

  @override
  VolunteerState? fromJson(Map<String, dynamic> json) =>
      VolunteerState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(VolunteerState state) =>
      _$VolunteerStateToJson(state);
}

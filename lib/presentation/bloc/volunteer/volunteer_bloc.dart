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
    print('✅✅✅fetch initial volunteer events✅✅✅');
    final homeFeedModel = event.homeFeedModel;

    // final fetchedVolunteerEvents = [
    //   ...homeFeedModel.clogged_drain.where(
    //     (cloggedDrain) => cloggedDrain.is_volunteer,
    //   ),
    //   ...homeFeedModel.negligent_dumping.where(
    //     (negligentDumping) => negligentDumping.is_volunteer,
    //   ),
    // ];

    final List<ReportHomeFeedModel> fetchedCloggedDrains =
        []; // will combine both clogged and negligent dumping
    final List<ReportHomeFeedModel> fetchedNegligentDumping = [];

    homeFeedModel.clogged_drain.map((cloggedDrain) {
      if (cloggedDrain.is_volunteer) {
        fetchedCloggedDrains.add(cloggedDrain);
      }
    }).toList();

    homeFeedModel.negligent_dumping.map((negligentDumping) {
      if (negligentDumping.is_volunteer) {
        fetchedNegligentDumping.add(negligentDumping);
      }
    }).toList();

    fetchedCloggedDrains.addAll(fetchedNegligentDumping);

    print('✅✅Fetched events: ${fetchedCloggedDrains.toString()}');

    emit(
      state.copyWith(
        initialRegisteredVolunteerEvents: [
          ...state.registeredVolunteerEvents,
          ...fetchedCloggedDrains,
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
}

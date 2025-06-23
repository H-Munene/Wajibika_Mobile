import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'report_volunteer_history_on_specific_date_event.dart';
part 'report_volunteer_history_on_specific_date_state.dart';

class ReportVolunteerHistoryOnSpecificDateBloc
    extends
        Bloc<
          ReportVolunteerHistoryOnSpecificDateEvent,
          ReportVolunteerHistoryOnSpecificDateState
        > {
  ReportVolunteerHistoryOnSpecificDateBloc()
    : super(ReportVolunteerHistoryOnSpecificDateInitial()) {
    on<ReportVolunteerHistoryOnSpecificDateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

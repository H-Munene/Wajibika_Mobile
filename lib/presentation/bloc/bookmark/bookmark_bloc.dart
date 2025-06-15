import 'dart:async';

import 'package:bloc_clean_arch/data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends HydratedBloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(const BookmarkState(bookMarkedReports: [])) {
    on<BookmarkEventToggleReportBookmarksPresence>(
      _toggleReportBookmarkPresence,
    );
    on<BookmarkEventClear>(_clearBookmarks);
  }

  Future<void> _toggleReportBookmarkPresence(
    BookmarkEventToggleReportBookmarksPresence event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(state.toggleReportBookmarkPresence(reportModel: event.reportModel));
  }

  Future<void> _clearBookmarks(
    BookmarkEventClear event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(const BookmarkState(bookMarkedReports: []));
  }

  @override
  BookmarkState? fromJson(Map<String, dynamic> json) =>
      BookmarkState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(BookmarkState state) =>
      _$BookmarkStateToJson(state);
}

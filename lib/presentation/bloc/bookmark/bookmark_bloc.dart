import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
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
    emit(
      state.toggleReportBookmarkPresence(
        reportHomeFeedModel: event.reportHomeFeedModel,
      ),
    );
  }

  Future<void> _clearBookmarks(
    BookmarkEventClear event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(const BookmarkState(bookMarkedReports: []));
  }
}

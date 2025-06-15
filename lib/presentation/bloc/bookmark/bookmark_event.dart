part of 'bookmark_bloc.dart';

sealed class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

final class BookmarkEventToggleReportBookmarksPresence extends BookmarkEvent {
  const BookmarkEventToggleReportBookmarksPresence({required this.reportModel});

  final ReportModel reportModel;
}

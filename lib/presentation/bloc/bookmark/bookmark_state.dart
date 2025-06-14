part of 'bookmark_bloc.dart';

enum BookMarkStatus { hasBookmark, noBookmark }

class BookmarkState {
  BookmarkState({
    this.bookMarkStatus = BookMarkStatus.noBookmark,
    this.bookMarks = const [],
  });

  final BookMarkStatus bookMarkStatus;
  final List<WajibikaReportFeedCard> bookMarks;

  BookmarkState copyWith({
    BookMarkStatus? newBookmarkStatus,
    WajibikaReportFeedCard? newBookmark,
  }) {
    if (newBookmark != null) {
      bookMarks.add(newBookmark);
    }
    return BookmarkState(
      bookMarkStatus: newBookmarkStatus ?? bookMarkStatus,
      bookMarks: bookMarks,
    );
  }
}

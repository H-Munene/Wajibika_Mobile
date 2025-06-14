part of 'bookmark_bloc.dart';

class BookmarkState extends Equatable {
  const BookmarkState({required this.bookMarkedReports});

  final List<ReportModel> bookMarkedReports;

  // determine if a report is bookmarked
  bool isReportBookMarked({required ReportModel reportModel}) =>
      bookMarkedReports.contains(reportModel);

  // add report to bookmarks
  BookmarkState _addReportToBookmarks({required ReportModel reportModel}) {
    final updatedBookmarks = List.of(bookMarkedReports)..add(reportModel);
    return BookmarkState(bookMarkedReports: updatedBookmarks);
  }

  // remove report from bookmarks
  BookmarkState _removeReportFromBookmarks({required ReportModel reportModel}) {
    final updatedBookmarks = List.of(bookMarkedReports)..remove(reportModel);

    return BookmarkState(bookMarkedReports: updatedBookmarks);
  }

  // primary method used in bookmarks_bloc
  BookmarkState toggleReportBookmarkPresence({
    required ReportModel reportModel,
  }) {
    // remove report if bookmarked
    if (isReportBookMarked(reportModel: reportModel)) {
      return _removeReportFromBookmarks(reportModel: reportModel);
    }

    // add report as its not bookmarked
    return _addReportToBookmarks(reportModel: reportModel);
  }

  @override
  List<Object?> get props => [bookMarkedReports];
}

part of 'bookmark_bloc.dart';

@JsonSerializable(explicitToJson: true)
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

  factory BookmarkState.fromJson(Map<String, dynamic> json) =>
      _$BookmarkStateFromJson(json);
  @override
  List<Object?> get props => [bookMarkedReports];
}

BookmarkState _$BookmarkStateFromJson(Map<String, dynamic> json) =>
    BookmarkState(
      bookMarkedReports:
          (json['bookMarkedReports'] as List<dynamic>)
              .map((e) => ReportModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$BookmarkStateToJson(BookmarkState instance) =>
    <String, dynamic>{
      'bookMarkedReports':
          instance.bookMarkedReports.map((e) => e.toJson()).toList(),
    };

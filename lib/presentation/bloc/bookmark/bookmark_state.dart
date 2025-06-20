part of 'bookmark_bloc.dart';

@JsonSerializable(explicitToJson: true)
class BookmarkState extends Equatable {
  const BookmarkState({required this.bookMarkedReports});

  final List<ReportHomeFeedModel> bookMarkedReports;

  // determine if a report is bookmarked
  bool isReportBookMarked({required ReportHomeFeedModel reportHomeFeedModel}) =>
      bookMarkedReports.contains(reportHomeFeedModel);

  // add report to bookmarks
  BookmarkState _addReportToBookmarks({
    required ReportHomeFeedModel reportHomeFeedModel,
  }) {
    final updatedBookmarks = List.of(bookMarkedReports)
      ..add(reportHomeFeedModel);
    return BookmarkState(bookMarkedReports: updatedBookmarks);
  }

  // remove report from bookmarks
  BookmarkState _removeReportFromBookmarks({
    required ReportHomeFeedModel reportHomeFeedModel,
  }) {
    final updatedBookmarks = List.of(bookMarkedReports)
      ..remove(reportHomeFeedModel);

    return BookmarkState(bookMarkedReports: updatedBookmarks);
  }

  // primary method used in bookmarks_bloc
  BookmarkState toggleReportBookmarkPresence({
    required ReportHomeFeedModel reportHomeFeedModel,
  }) {
    // remove report if bookmarked
    if (isReportBookMarked(reportHomeFeedModel: reportHomeFeedModel)) {
      return _removeReportFromBookmarks(
        reportHomeFeedModel: reportHomeFeedModel,
      );
    }

    // add report as its not bookmarked
    return _addReportToBookmarks(reportHomeFeedModel: reportHomeFeedModel);
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
              .map(
                (e) => ReportHomeFeedModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );

Map<String, dynamic> _$BookmarkStateToJson(BookmarkState instance) =>
    <String, dynamic>{
      'bookMarkedReports':
          instance.bookMarkedReports.map((e) => e.toJson()).toList(),
    };

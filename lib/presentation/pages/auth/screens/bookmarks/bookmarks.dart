import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookMarksPage extends StatelessWidget {
  const BookMarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      builder: (context, state) {
        final bookMarks = state.bookMarkedReports;

        return bookMarks.isEmpty
            ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.bookmark),
                  Text('Your Bookmarks will appear here'),
                ],
              ),
            )
            : ListView.separated(
              itemCount: bookMarks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemBuilder:
                  (context, index) => WajibikaBookmarkCard(
                    onBookmarkIconPressed:
                        () => context.read<BookmarkBloc>().add(
                          BookmarkEventToggleReportBookmarksPresence(
                            reportModel: bookMarks[index],
                          ),
                        ),
                    imageUrl: bookMarks[index].imageUrl,
                    description: bookMarks[index].description,
                    reportCategory: bookMarks[index].reportCategory,
                  ),
            );
      },
    );
  }
}

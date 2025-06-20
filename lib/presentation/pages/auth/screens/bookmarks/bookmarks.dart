import 'package:bloc_clean_arch/core/core.dart';
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
                  Text(
                    Globals.emptyBookmarksPageText,
                    textAlign: TextAlign.center,
                  ),
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
                            reportHomeFeedModel: bookMarks[index],
                          ),
                        ),
                    imageUrl: bookMarks[index].report_image_url,
                    description: bookMarks[index].description,
                  ),
            );
      },
    );
  }
}

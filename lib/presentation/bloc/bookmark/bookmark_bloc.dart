import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:equatable/equatable.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(BookmarkState()) {
    on<BookmarkEvent>((event, emit) {
    });
  }
}

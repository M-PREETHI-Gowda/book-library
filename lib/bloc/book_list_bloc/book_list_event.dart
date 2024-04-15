part of 'book_list_bloc.dart';

@immutable
abstract class BookListEvent extends Equatable{
  const BookListEvent();
  @override
  List<Object> get props => [];
}

class LibraryBookList extends BookListEvent{
  const LibraryBookList();
  @override
  List<Object> get props => [];
}
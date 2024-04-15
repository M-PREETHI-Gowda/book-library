part of 'book_list_bloc.dart';

@immutable
abstract class BookListState extends Equatable{
  const BookListState();
  @override
  List<Object> get props => [];
}

class BookListInitial extends BookListState {}

class BookListLoading extends BookListState {
  const BookListLoading();
  @override
  List<Object> get props => [];
}

class BookListSuccess extends BookListState {
  List<BookList> bookList = [];
  BookListSuccess({required this.bookList});

  @override
  List<Object> get props => [bookList];
}

class BookListFailed extends BookListState {
  String message;
  BookListFailed({required this.message});
  @override
  List<Object> get props => [message];
}
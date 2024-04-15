import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:book_library/dao/book_list_dao.dart';
import 'package:book_library/models/book_list_mobel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'book_list_event.dart';
part 'book_list_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  late BookListDao bookListDao;
  BookListBloc() : super(BookListInitial()) {
    bookListDao = BookListDao();
    on<LibraryBookList>((event, emit) async{
      await mapFetchCustomerList(event, emit);
    });
  }

  Future<void> mapFetchCustomerList(
      LibraryBookList event, Emitter<BookListState> emit) async {
    try{
      print("object");
      emit(const BookListLoading());

      var response = await bookListDao.bookList();
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);
      if(response.statusCode == 200){
        List<BookList> bookList = [];

        for (var i in jsonDecoded["works"]) {
          bookList.add(BookList.fromJson(i));
        }
        emit(BookListSuccess(bookList: bookList));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(BookListFailed(message: message));

      }else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(BookListFailed(message: message));
      }

    }catch(error){
      print("The error : $error");
      emit(BookListFailed(message: "Something went wrong"));
    }
  }

}

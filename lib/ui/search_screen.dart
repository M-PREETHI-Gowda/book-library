import 'dart:convert';
import 'package:book_library/components/colors.dart';
import 'package:book_library/components/size_config.dart';
import 'package:book_library/helpers/reuse_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Book> books = [];
  TextEditingController _searchController = TextEditingController();
  bool _isMounted = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _fetchBooks('');
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  void _fetchBooks(String query) async {
    if (query.isEmpty) {
      setState(() {
        books.clear();
      });
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(Uri.parse('https://openlibrary.org/search.json?q=$query'));
    if (response.statusCode == 200 && _isMounted) {
      setState(() {
        final List<dynamic> bookJsonList = json.decode(response.body)['docs'];
        final List<Book> fetchedBooks = bookJsonList
            .map((bookJson) => Book.fromJson(bookJson))
            .take(10)
            .toList();
        books = fetchedBooks;
        _isLoading = false;
      });
    } else {
      if (_isMounted) {
        setState(() {
          _isLoading = false;
        });
        throw Exception('Failed to load books');
      }
    }
  }

  void toggleIsRead(int index) {
    setState(() {
      books[index].isRead = !books[index].isRead;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLORS.white,
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 2,
                  vertical: SizeConfig.blockHeight * 2),
              alignment: Alignment.center,
              height: SizeConfig.blockHeight * 6,
              child: TextField(
                controller: _searchController,
                onChanged: (value) => _fetchBooks(value),
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: COLORS.primary,
                    fontSize: SizeConfig.blockWidth * 3,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Lato',
                  ),
                  prefixIcon: Icon(Icons.search, color: COLORS.primary),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(SizeConfig.blockWidth * 10),
                      borderSide: BorderSide(
                        color: COLORS.primary,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(SizeConfig.blockWidth * 10),
                      borderSide: BorderSide(
                        color: COLORS.primary,
                      )),
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(SizeConfig.blockWidth * 10),
                      borderSide: BorderSide(
                        color: COLORS.primary,
                      )),
                ),
              ),
            ),
            if (_isLoading)
              CircularProgressIndicator(),
            if (!books.isEmpty && !_isLoading)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                  ),
                  itemCount: books.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      child: GestureDetector(
                        onTap: () {
                          toggleIsRead(index);
                        },
                        child: cardContainer(
                          title: books[index].title!,
                          image:
                          "https://covers.openlibrary.org/b/id/${books[index].coverId}-M.jpg",
                          txt: books[index].author,
                          year: books[index].firstPublishYear,
                          isRead: books[index].isRead,
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (books.isEmpty && !_isLoading)
              Container(
                height: SizeConfig.blockHeight * 60,
                width: SizeConfig.screenWidth,
                alignment: Alignment.center,
                child: Text(
                  "Nothing is Here",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: COLORS.primary,
                    fontSize: SizeConfig.blockWidth * 8,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


class Book {
  final String title;
  final String author;
  final int coverId;
  int firstPublishYear;
  bool isRead;

  Book({
    required this.title,
    required this.author,
    required this.coverId,
    required this.firstPublishYear,
    this.isRead = false, // Default value is false
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? "",
      coverId: json['cover_i'] ?? 0,
      author: json['author_name'] != null ? json['author_name'][0] : 'Unknown',
      firstPublishYear: json["first_publish_year"] ?? 0 ,
    );
  }
}
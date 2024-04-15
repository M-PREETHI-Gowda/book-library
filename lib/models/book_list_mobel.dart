
import 'dart:convert';

List<BookList> bookListFromJson(String str) => List<BookList>.from(json.decode(str).map((x) => BookList.fromJson(x)));

String bookListToJson(List<BookList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookList {
  String key;
  String title;
  int editionCount;
  int coverId;
  List<Author> authors;
  int firstPublishYear;
  bool isRead;

  BookList({
    required this.key,
    required this.title,
    required this.editionCount,
    required this.coverId,
    required this.authors,
    required this.firstPublishYear,
    this.isRead = false,
  });

  factory BookList.fromJson(Map<String, dynamic> json) => BookList(
    key: json["key"],
    title: json["title"],
    editionCount: json["edition_count"],
    coverId: json["cover_id"],
    authors: List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
    firstPublishYear: json["first_publish_year"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "title": title,
    "edition_count": editionCount,
    "cover_id": coverId,
    "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
    "first_publish_year": firstPublishYear,
    "isRead": isRead,
  };
}

class Author {
  String key;
  String name;

  Author({
    required this.key,
    required this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    key: json["key"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
  };
}


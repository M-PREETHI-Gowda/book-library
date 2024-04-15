import 'package:http/http.dart' as http;

class BookListDao {
  Future bookList() async {
    var url = 'https://openlibrary.org/subjects/fiction.json?limit=20';

    final response = await http.get(
      Uri.parse(url),
    );
    print("Response Status Code : ${response.statusCode}");
    print("Response body : ${response.body}");
    return response;
  }
}

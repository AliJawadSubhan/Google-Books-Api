import 'package:complexjson/model/Books.dart';

class BookResponse {
  List<Boooks>? items;
  int? totalItems;
  BookResponse({this.items, this.totalItems});

  factory BookResponse.fromJson(Map<String, dynamic> json) {
    BookResponse bookrespose = BookResponse();
    bookrespose.totalItems = json['totalItems'];
    bookrespose.items = [];
    for (var bookJson in (json['items'] as List<dynamic>)) {
      var bookMap = bookJson as Map<String, dynamic>;
      bookrespose.items?.add(Boooks.fromJson(bookMap));
    }
    return bookrespose;
  }
}

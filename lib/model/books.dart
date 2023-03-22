import 'package:complexjson/model/vol_info.dart';

class Boooks {
  VolumneInfo? volumneInfo;

  Boooks({this.volumneInfo});

  factory Boooks.fromJson(Map<String, dynamic> json) {
    var books = Boooks();
    books.volumneInfo = json['volumeInfo'];
    return books;
  }
}

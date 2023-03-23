import 'package:complexjson/model/images.dart';

class VolumneInfo {
  String? title;
  List<String>? authors;
  ImageLinks? images;
  VolumneInfo({this.title, this.authors, this.images});

  factory VolumneInfo.fromJson(Map<String, dynamic> json) {
    var volumeInfo = VolumneInfo();
    volumeInfo.title = json['title'];
    volumeInfo.authors = [];

    if (json['authors'] != null) {
      for (var i in (json['authors'])) {
        volumeInfo.authors?.add(i);
      }
    }

    volumeInfo.images = ImageLinks.fromJson(json['images']);

    return volumeInfo;
  }
}

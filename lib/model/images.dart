// import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

class ImageLinks {
  String? thumbNails;

  ImageLinks({this.thumbNails});

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    var image = ImageLinks();
    image.thumbNails = json['thumbnail'];
    return image;
  }
}

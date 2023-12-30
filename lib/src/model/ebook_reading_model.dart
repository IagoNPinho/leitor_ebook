import 'package:vocsy_epub_viewer/epub_viewer.dart';
import 'ebook_model.dart';

class EBookReadingModel extends EBookModel {
  final EpubLocator locator;
  final String path;

  EBookReadingModel({
    required super.id,
    required super.title,
    required super.author,
    required super.coverUrl,
    required super.bookUrl,
    required this.path,
    required this.locator,
  });

  static EBookReadingModel fromJson(Map json) {
    return EBookReadingModel(
      id: json["id"],
      title: json["title"],
      author: json["author"],
      coverUrl: json["cover_url"],
      bookUrl: json["download_url"],
      path: json["path"],
      locator: json["locator"]
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "title": title,
      "author": author,
      "coverUrl": coverUrl,
      "bookUrl": bookUrl,
      "path": path,
      "locator": locator,
    };
    return map;
  }
}

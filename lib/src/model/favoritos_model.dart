import 'ebook_model.dart';

class FavoritosModel extends EBookModel {
  final String path;

  FavoritosModel({
    required super.id,
    required super.title,
    required super.author,
    required super.coverUrl,
    required super.bookUrl,
    required this.path,
  });

  static FavoritosModel fromJson(Map json) {
    return FavoritosModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      coverUrl: json['coverUrl'],
      bookUrl: json['bookUrl'],
      path: json['path'],
    );
  }

  static FavoritosModel fromDownload(EBookModel eBook, String path) {
    return FavoritosModel(
      id: eBook.id,
      title: eBook.title,
      author: eBook.author,
      coverUrl: eBook.coverUrl,
      bookUrl: eBook.bookUrl,
      path: path,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map;
    map = {
      "id": id,
      "title": title,
      "author": author,
      "coverUrl": coverUrl,
      "bookUrl": bookUrl,
      "path": path,
    };
    return map;
  }
}

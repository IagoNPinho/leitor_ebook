class EBookModel {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String bookUrl;

  EBookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.bookUrl,
  });

  static EBookModel fromJson(Map json) {
    return EBookModel(
      id: json["id"],
      title: json["title"],
      author: json["author"],
      coverUrl: json["cover_url"],
      bookUrl: json["download_url"],
    );
  }
}

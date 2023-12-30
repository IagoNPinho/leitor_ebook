import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class EBookController {
  Future<Directory> downloadsDirectory() async{
    List<Directory>? directories = await getExternalStorageDirectories(type: StorageDirectory.downloads);
      Directory directory;
    if(directories == null){
      directories = await getExternalStorageDirectories(type: StorageDirectory.documents);
      directory = directories![0];
    } else {
      directory = directories[0];
    }
    return directory;
  }


  Future<String> downloadBook(String title, String bookUrl) async {
    Dio dio = Dio();
    Directory appDocDir = Platform.isAndroid
        ? await downloadsDirectory()
        : await getApplicationDocumentsDirectory();

    String path = '${appDocDir.path}/$title.epub';
    File file = File(path);

    if (!file.existsSync()) {
      await file.create();
      await dio.download(
        bookUrl,
        path,
        deleteOnError: true,
      );
      return path;
    } else {
      return path;
    }
  }

  Future<List> callAPI() async {
    String url = "https://escribo.com/books.json";
    try {
      var response = await http.get(Uri.parse(url));
      String body = response.body;
      List booksList = convert.jsonDecode(body);
      booksList.removeAt(3);
      return booksList;
    } catch (e) {
      return [];
    }
  }
}

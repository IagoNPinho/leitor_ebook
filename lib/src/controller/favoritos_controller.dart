import 'dart:io';
import 'package:leitor_ebook/src/controller/ebook_controller.dart';
import 'package:leitor_ebook/src/model/ebook_model.dart';
import 'package:path_provider/path_provider.dart';
import '../model/favoritos_model.dart';

class FavoritosController extends EBookController {
  Future<FavoritosModel> saveFavorito(EBookModel eBook) async {
    String path = await downloadBook(
      eBook.title,
      eBook.bookUrl,
    );
    FavoritosModel favorito = FavoritosModel.fromDownload(eBook, path);
    return favorito;
  }

  Future<FavoritosModel> removeFavorito(EBookModel eBook) async {
    Directory appDocDir = Platform.isAndroid
        ? await downloadsDirectory()
        : await getApplicationDocumentsDirectory();

    String path = '${appDocDir.path}/${eBook.title}.epub';

    FavoritosModel favorito = FavoritosModel.fromDownload(
      eBook,
      path,
    );
    return favorito;
  }

  bool isFavorito(EBookModel eBook, List<Map> favoritos) {
    for (var favorito in favoritos) {
      if (favorito["id"] == eBook.id) {
        return true;
      }
    }
    return false;
  }
}

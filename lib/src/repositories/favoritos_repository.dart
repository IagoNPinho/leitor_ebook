import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:leitor_ebook/src/database/db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:leitor_ebook/src/model/favoritos_model.dart';

class FavoritosRepository extends ChangeNotifier {
  late Database db;
  List<Map> _ebooks = [];

  UnmodifiableListView<Map> get ebooks => UnmodifiableListView(_ebooks);

  FavoritosRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getAllEbook();
  }

  _getAllEbook() async {
    db = await DB.instance.db;
    List<Map> favoritos = await db.query(
      'favoritos',
      distinct: true,
    );
    favoritos.map(
      (favorito) {
        print(favorito);
        _ebooks.add(favorito);
      },
    );
    notifyListeners();
  }

  setFavorito(FavoritosModel favorito) async {
    db = await DB.instance.db;
    Map<String, dynamic> json = favorito.toMap();
    db.update('favoritos', json);
    _ebooks.add(json);
    notifyListeners();
  }

  removeFavorito(FavoritosModel favorito) async {
    db = await DB.instance.db;
    await db.delete(
      'favoritos',
      where: 'id = ?',
      whereArgs: [favorito.id],
    );
    _ebooks.removeWhere((map) => map["id"] == favorito.id);
    notifyListeners();
  }
}

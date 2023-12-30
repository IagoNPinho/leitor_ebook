import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String favoritosTable = 'favoritos';
const String idColumn = 'id';
const String titleColumn = 'title';
const String authorColumn = 'author';
const String coverUrlColumn = 'coverUrl';
const String bookUrlColumn = 'bookUrl';
const String pathColumn = 'path';

class DB {
  DB._();
  static final DB instance = DB._();
  static Database? _db;


  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'ebook.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (
        Database db,
        int newerVersion,
      ) async {
        await db.execute(_favoritos);
      },
    );
  }

  String get _favoritos => '''
    CREATE TABLE $favoritosTable(
      $idColumn INTEGER PRIMARY KEY,
      $titleColumn TEXT,
      $authorColumn TEXT,
      $coverUrlColumn TEXT,
      $bookUrlColumn TEXT,
      $pathColumn TEXT
    );
  ''';
}
import 'package:mobilefirst/models/news/article.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHeler {
  static final DbHeler instance = DbHeler._init();
  static Database? _database;
  DbHeler._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDb('news.db');
    return _database!;
  }

  Future<Database> initDb(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE articles (
          id INTEGER PRIMARY KEY,
          title TEXT,
          urlToImage TEXT,
          bookmarked INTEGER
        )
      ''');
    });
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<List<Articles>> getBookmarkedArticles() async {
    final db = await instance.database;
    var response =
        await db.query('articles', where: 'bookmarked = ?', whereArgs: [1]);
    return response.map((article) => Articles.fromJson(article)).toList();
  }

  Future<Articles> insertBookmark(Articles article) async {
    final db = await instance.database;
    final id = await db.insert('articles', article.toJson());
    //article.id = id;
    return article;
  }

  Future<Articles> getArticles(int id) async {
    final db = await instance.database;
    var response = await db.query('articles', where: 'id = ?', whereArgs: [id]);
    return response.isNotEmpty
        ? Articles.fromJson(response.first)
        : throw Exception('Article not found');
  }

  Future<Articles> updateBookmark(Articles article) async {
    final db = await instance.database;
    await db.update('articles', article.toJson(),
        where: 'title = ?', whereArgs: [article.title]);
    return article;
  }

  Future<int> deleteBookmark(int id) async {
    final db = await instance.database;
    return await db.delete('articles', where: 'id = ?', whereArgs: [id]);
  }
}

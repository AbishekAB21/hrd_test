import 'package:hrd_test/models/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'posts.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE posts(id INTEGER PRIMARY KEY, title TEXT, body TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertPost(Post post) async {
    final db = await database();
    await db.insert(
      'posts',
      post.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Post>> getPosts() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query('posts');
    return List.generate(
      maps.length,
      (i) => Post(
        id: maps[i]['id'],
        title: maps[i]['title'],
        body: maps[i]['body'],
      ),
    );
  }
}



import 'package:sqflite/sqflite.dart';

import 'main.dart';


abstract class Immo{
  static String accessToken = '';
  // static const host = 'http://192.168.43.19:3000';
  // static const host = 'http://192.168.1.145:3000';
  static const host = 'http://localhost:3000';
  late String id='';
  late String chemin;

  toJson();
  String getTableName();

  Future<int> save() async {
    final db = await database;
    return await db.insert(
      getTableName(),
      toJson(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<int> update() async {
    final db = await database;
    return await db.update(
        getTableName(),
        toJson(),
        where: 'id=?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.ignore
    );
  }

  Future<void> orther() async {
    final db = await database;
    await db.update(
        getTableName(),
        toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore
    );
  }

  Future<void> deleteDepence() async {
    final db = await database;

    await db.delete(getTableName(), where: 'id=?', whereArgs: [id]).then((value) {
      /*if (image.isNotEmpty) {
        File f = File(image);
        f.delete();
      }*/
    });
  }



  Immo(this.id);

  static Future<List<Map<String, Object?>>>? getAll(String table) async {
    final db = await database;
    List<Map<String, Object?>> res = await db.query(
        table,
    );
    return res;
  }

  static Future<List<Map<String, Object?>>>? getAllByFK(String table, Map<String, String> keyValue) async {
    final db = await database;
    List<Map<String, Object?>> res = await db.query(
      table,
      whereArgs: [keyValue['value']],
      where: '${keyValue['key']}=?'
    );
    return res;
  }

  static Future<List<Map<String, Object?>>>? getOneById(String table, String id) async {
    final db = await database;
    List<Map<String, Object?>> res = await db.query(
      table,
      where: 'id=?',
      whereArgs: [id]
    );
    return res;
  }
  Future<int> delete() async {
    final db = await database;
    return await db.delete(
        getTableName(),
        where: 'id=?',
      whereArgs: [int.parse(id)]
    );
  }



}
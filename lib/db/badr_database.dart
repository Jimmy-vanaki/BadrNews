import 'dart:io';
import 'package:badrnews/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? db;

class InitializeDB {
  Future initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "badrDB.sqlite");

    final exist = await databaseExists(path);

    if (exist) {
      debugPrint("db already exists");
      await openDatabase(path);
    } else {
      debugPrint("creating a copy from assets");
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("Assets", "badrDB.sqlite"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
      debugPrint("db copied");
    }
    await openDatabase(path);
    // open the database
    db = await openDatabase(path, readOnly: true);
  }
}

class GetBookMark {
  Future query() async {
    Constants.bookMarkContent.clear();
    List<Map> result = await db!.rawQuery('SELECT * FROM bookmark');

    for (var row in result) {
      Constants.bookMarkContent.add({
        'id': row['id'],
        'title': row['title'],
        'data': row['data'],
        'image': row['image'],
      });
    }
    debugPrint(
        "${Constants.bookMarkContent.length}<------Constants.bookMarkContent.length");
  }
}

class AddBookmark {
  void add(int id, String title, String data, String image) {
    db?.rawInsert(
        'INSERT INTO bookmark(id, title, data,image) VALUES($id,"$title","$data","$image")');
    // _query();
  }
}

import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tmween/model/user_local_model.dart';

class DBHelper {
  static Database? _db = null;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "tmween.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE userLocalModel(id INTEGER PRIMARY KEY,userId TEXT, fullname TEXT, countryName TEXT, stateName TEXT,"
        "cityName TEXT,largeImageUrl TEXT,mobile1 TEXT,zip TEXT,phone TEXT,email TEXT,yourName TEXT,image TEXT )");
    print("Created tables");
  }

  void saveUser(UserLocalModel userLocalModel) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO userLocalModel(userId, fullname, countryName, stateName,cityName ,largeImageUrl,mobile1,zip,phone,email,yourName,image) VALUES(' +
              '\'' +
              userLocalModel.id! +
              '\'' +
              ',' +
              '\'' +
              userLocalModel.fullname! +
              '\'' +
              ',' +
              '\'' +
              userLocalModel.countryName! +
              '\'' +
              ',' +
              '\'' +
              userLocalModel.stateName! +
              '\'' +
              ',' +
              '\'' +
              userLocalModel.cityName! +
              '\'' +
              ',' +
              '\'' +
              userLocalModel.largeImageUrl! +
              '\'' +
              ',' +
              '\'' +
              userLocalModel.mobile1! +
              '\'' +
              ',' +
              '\'' +
              userLocalModel.zip! +
              '\'' +
              ',' +
              '\'' +
              userLocalModel.phone! +
              '\'' +
              ',' +
              '\'' +
              userLocalModel.email! +
              '\'' +
              ',' +
              '\'' +
              userLocalModel.yourName! +
              '\'' +
              ',' +
              '\'' +
              userLocalModel.image! +
              '\'' +
              ')');
    });
  }

  Future<List<UserLocalModel>> getuserLocalModels() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM userLocalModel');
    List<UserLocalModel> userLocalModels = [];

    for (int i = 0; i < list.length; i++) {
      userLocalModels.add(new UserLocalModel(
        id: list[i]["userId"],
        fullname: list[i]["fullname"],
        countryName: list[i]["countryName"],
        stateName: list[i]["stateName"],
        cityName: list[i]["cityName"],
        largeImageUrl: list[i]["largeImageUrl"],
        mobile1: list[i]["mobile1"],
        zip: list[i]["zip"],
        phone: list[i]["phone"],
        email: list[i]["email"],
        yourName: list[i]["yourName"],
        image: list[i]["image"],
      ));
    }
    print(userLocalModels.length);
    return userLocalModels;
  }
}

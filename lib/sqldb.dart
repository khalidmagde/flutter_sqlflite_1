import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?>? get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

// connect with sql
  intialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'khalid.db');
    Database mydb = await openDatabase(path,
        onCreate: _oncreate, version: 5, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldver, int newver) async {
    print("Onupgrade=======================");
    await db.execute("ALTER TABLE notes ADD COLUMN color TEXT");
  }

  _oncreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute(
        '''CREATE TABLE "notes" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "title" TEXT NOT NULL, "note" TEXT NOT NULL)''');

    await batch.commit();
    /*  await db.execute(
        '''CREATE TABLE "notes" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "title" TEXT NOT NULL, "note" TEXT NOT NULL)'''); */

    // ignore: avoid_print
    print("Create Database AND TABLE =======================");
  }

  //function dealing with select
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  //function dealing with insert
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  //function dealing with update
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  //function dealing with delete
  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  mydeleteDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'khalid.db');
    await deleteDatabase(path);
  }
}

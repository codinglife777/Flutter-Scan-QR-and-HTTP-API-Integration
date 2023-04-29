import 'package:avensys_srl/global.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  final String dbName = "errorData.db";
  final String tableName = "ErrorListing";
  final String colId = "id";
  final String colError = "error";

  Database? db;

  Future<void> initDB() async {
    String directory = await getDatabasesPath();
    String path = join(directory, dbName);

    db = await openDatabase(path, version: 1, onCreate: (db, version) {});
    await db!.execute(
        "CREATE TABLE IF NOT EXISTS $tableName($colId TEXT, $colError TEXT)");
  }

  insertRecords() async {
    await initDB();

    // String query = "INSERT INTO $tableName($colId,$colError) VALUES(?,?)";
    // // List args = [dataAsJson];

    // await db!.rawInsert(query, args);
    // await db!.query(tableName, columns: ['code', 'description']);
  }

  fetchRecords() async {
    await initDB();

    String query = "SELECT * FROM $tableName";
  }
}

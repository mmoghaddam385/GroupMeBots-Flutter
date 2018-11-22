
import 'package:groupme_bots/db/DatabaseEntity.dart';
import 'package:groupme_bots/model/BotMessage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const _DB_VERSION = 1;
const _DB_NAME = "geoffrey.db";

final List<DatabaseEntity> _ENTITIES = [BotMessageEntity()];

// Lazily initialized!
final DatabaseWrapper dbWrapper = DatabaseWrapper._create();

class DatabaseWrapper {

  Database _db;

  DatabaseWrapper._create();

  Future init() async {
    var dbDir = await getDatabasesPath();
    dbDir = join(dbDir, _DB_NAME);

    _db = await openDatabase(dbDir, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    var batch = db.batch();

    // Add all entities to the DB
    _ENTITIES.forEach((entity) {
      batch.execute(entity.getTableCreateStatement());
    });

    await batch.commit(noResult: true);
  }

  Future<T> insertEntity<T>(DatabaseEntity<T> entity, T value) async {
    var id = await _db.insert(entity.getTableName(), entity.toMap(value));
    entity.onInsert(value, id);

    return value;
  }

  Future<int> updateEntity<T>(DatabaseEntity<T> entity, T value, {String where, List<dynamic> whereArgs}) async {
    return await _db.update(entity.getTableName(), entity.toMap(value), where: where, whereArgs: whereArgs);
  }

  Future<List<T>> getAll<T>(DatabaseEntity<T> entity) async {
    List<Map<String, dynamic>> rawResults = await _db.query(entity.getTableName());
    return rawResults.map((raw) => entity.fromMap(raw));
  }

}
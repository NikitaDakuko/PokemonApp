import 'package:pokemon_application/Cache/pokemon_db.dart';
import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:sqflite/sqflite.dart';

Pokemon snapshotToPokemon(Map<String, dynamic> snapshot) {
  return Pokemon.fromMap(snapshot);
}

class LocalDBProvider {
  static const String dbName = 'pokemon.db';
  static const int version = 1;
  String columnId = 'id';
  String columnName = 'name';
  String columnWeight = 'weight';
  String columnHeight = 'height';
  String tableName = 'Pokemon';

  late final DatabaseFactory dbFactory;
  late final Database? database;

  LocalDBProvider(this.dbFactory);

  Future openPath(String path) async {
    database = await dbFactory.openDatabase(path,
        options: OpenDatabaseOptions(
          onCreate: (db, version) {
            return db.execute(
              'CREATE TABLE pokemon(id INTEGER PRIMARY KEY, name TEXT, pictureURL TEXT, height INTEGER, weight INTEGER)',
            );
          },
          version: version,
        ));
  }

  Future getListPokemon({int? offset, int? limit, bool? descending}) async {
    var list = (await database!.query(tableName,
        columns: [columnId, columnName, columnWeight, columnHeight],
        limit: limit,
        offset: offset));
    return PokemonDB(list);
  }

  Future close() async {
    await database!.close();
  }

  Future deleteDb() async {
    await dbFactory.deleteDatabase(database!.path);
  }
}

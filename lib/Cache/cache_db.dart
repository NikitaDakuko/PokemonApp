import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheDB {
  static const String dbName = 'pokemonDB';
  late Box<Pokemon> database;

  Future openDB() async {
    database = await Hive.openBox<Pokemon>(dbName);
  }

  Future<List<Pokemon>> getListPokemon({int? offset, int? limit}) async {
    await openDB();
    return [for (Pokemon p in database.values) p];
  }

  Future<Pokemon> getPokemon(int id) async {
    await openDB();
    return database.get(id)!;
  }

  Future insertPokemon(Pokemon pokemon) async {
    await openDB();
    await database.put(pokemon.id, pokemon);
  }

  Future insertAllPokemon(List<Pokemon> pokemon) async {
    await openDB();
    for (Pokemon p in pokemon) {
      await insertPokemon(p);
    }
  }

  Future close() async {
    await openDB();
    await database.close();
  }
}

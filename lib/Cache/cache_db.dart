import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheDB {
  static const String dbName = 'pokemonDB';
  static final Box<Pokemon> cache = Hive.box(dbName);

  static Future<List<Pokemon>> getListPokemon({int? offset, int? limit}) async {
    return [for (Pokemon p in cache.values) p];
  }

  static Future<Pokemon> getPokemon(int id) async {
    return cache.get(id)!;
  }

  static Future<void> insertPokemon(Pokemon pokemon) async {
    await cache.put(pokemon.id, pokemon);
  }

  static Future<void> insertAllPokemon(List<Pokemon> pokemon) async {
    for (Pokemon p in pokemon) {
      await insertPokemon(p);
    }
  }

  static Future<void> close() async {
    await cache.close();
  }
}

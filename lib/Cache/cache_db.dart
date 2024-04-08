import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheDB {
  static const String dbName = 'pokemonDB';
  final Box<Pokemon> cache = Hive.box(dbName);

  Future<List<Pokemon>> getListPokemon({int? offset, int? limit}) async {
    return [for (Pokemon p in cache.values) p];
  }

  Future<Pokemon> getPokemon(int id) async {
    return cache.get(id)!;
  }

  Future<void> insertPokemon(Pokemon pokemon) async {
    await cache.put(pokemon.id, pokemon);
  }

  Future<void> insertAllPokemon(List<Pokemon> pokemon) async {
    for (Pokemon p in pokemon) {
      await insertPokemon(p);
    }
  }

  Future<void> close() async {
    await cache.close();
  }
}

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

  void insertPokemon(Pokemon pokemon) async {
    await cache.put(pokemon.id, pokemon);
  }

  Future<void> insertAllPokemon(Map<String, dynamic> pokemon) async {
    for (MapEntry<String, dynamic> p in pokemon.entries) {
      insertPokemon(Pokemon(
        id: p.value,
        name: p.key,
        pictureURL:"",
        types: [],
        weight: 0,
        height: 0,
      ));
    }
  }

  Future<void> close() async {
    await cache.close();
  }
}

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_application/Cache/cache_db.dart';
import 'package:pokemon_application/Entity/pokemon.dart';

class PokemonInteractor {
  final getIt = GetIt.instance;

  Future<Pokemon> fetchPokemon(id) async {
    final response =
        await getIt<Dio>().get('https://pokeapi.co/api/v2/pokemon/$id/');

    return Pokemon.fromJson(response.data);
  }

  Future<Map<String, dynamic>> fetchListOfPokemon(int limit, int offset) async {
    final response = await getIt<Dio>().get(
      'https://pokeapi.co/api/v2/pokemon',
      queryParameters: {'limit': limit, 'offset': offset},
    );

    return parseListOfPokemon(response.data);
  }

  Map<String, dynamic> parseListOfPokemon(responseBody) {
    final parsed =
        (responseBody['results'] as List).cast<Map<String, dynamic>>();

    final Map<String, dynamic> result = Map.fromIterables(
      parsed.map<String>((json) => json['name']).toList(),
      parsed.map<int>((json) {
        String s = json['url'];
        return int.parse(s.substring(34, s.length - 1));
      }).toList(),
    );

    insertAllPokemonIntoDB(result);

    return result;
  }

  Future<Pokemon> fetchPokemonFromDB(id) async {
    return await getIt<CacheDB>().getPokemon(id);
  }

  Future<Map<String, dynamic>> fetchListOfPokemonFromDB(
      int limit, int offset) async {
    List<Pokemon> list =
        await getIt<CacheDB>().getListPokemon(limit: limit, offset: offset);
    return {for (var p in list) p.name: p.id};
  }

  void insertPokemonIntoDB(Pokemon p) {
    getIt<CacheDB>().insertPokemon(p);
  }

  void insertAllPokemonIntoDB(pl) {
    getIt<CacheDB>().insertAllPokemon(pl);
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_application/Cache/cache_db.dart';
import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonInteractor {
  final getIt = GetIt.instance;

  Future<Pokemon> fetchPokemon(http.Client client, id) async {
    final response =
        await client.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id/'));

    final parsedJson = (jsonDecode(response.body));
    final Pokemon pokemon = Pokemon.fromJson(parsedJson);
    return pokemon;
  }

  Future<Map<String, dynamic>> fetchListOfPokemon(
      http.Client client, int limit, int offset) async {
    final response = await client.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$limit'));

    return parseListOfPokemon(response.body);
  }

  Map<String, dynamic> parseListOfPokemon(String responseBody) {
    final parsed = (jsonDecode(responseBody)['results'] as List)
        .cast<Map<String, dynamic>>();

    return Map.fromIterables(
      parsed.map<String>((json) => json['name']).toList(),
      parsed.map<int>((json) {
        String s = json['url'];
        return int.parse(s.substring(34, s.length - 1));
      }).toList(),
    );
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

  void insertAllPokemonIntoDB(List<Pokemon> pl) {
    getIt<CacheDB>().insertAllPokemon(pl);
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonInteractor {
  Future<Pokemon> fetchPokemon(http.Client client, String url) async {
    final response = await client.get(Uri.parse(url));

    final parsedJson = (jsonDecode(response.body));
    return Pokemon.fromJson(parsedJson);
  }

  Future<Map<String, String>> fetchListOfPokemon(
      http.Client client, int limit, int offset) async {
    final response = await client.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$limit'));

    return compute(parseListOfPokemon, response.body);
  }

  Map<String, String> parseListOfPokemon(String responseBody) {
    //maxCount = jsonDecode(responseBody)['count'];
    final parsed = (jsonDecode(responseBody)['results'] as List)
        .cast<Map<String, dynamic>>();

    return Map.fromIterables(
      parsed.map<String>((json) => json['name']).toList(),
      parsed.map<String>((json) => json['url']).toList(),
    );
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonInteractor {
  late Pokemon pokemon;

  Future<Pokemon> fetchPokemon(http.Client client, int id) async {
    final response =
        await client.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id/'));

    final parsedJson = (jsonDecode(response.body));
    return Pokemon.fromJson(parsedJson);
  }

  Future<List<String>> fetchListOfPokemon(http.Client client) async {
    final response =
    await client.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/'));

    return compute(parseListOfPokemon, response.body);
  }

  List<String> parseListOfPokemon(String responseBody) {
    final parsed =
    (jsonDecode(responseBody)['results'] as List).cast<Map<String, dynamic>>();
    return parsed.map<String>((json) => json['name']).toList();
  }
}

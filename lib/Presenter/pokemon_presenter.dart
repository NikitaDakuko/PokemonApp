import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:pokemon_application/Interactor/pokemon_interactor.dart';
import 'package:pokemon_application/router.dart';

class PokemonPresenter {
  int offset = 0;

  Future<Map<String, String>> nextPage(int limit) async{
    final pl = await pokemonList(limit, offset);
    offset += limit;
    return pl;
  }


  Future<Map<String, String>> pokemonList(int limit, int offset) async {
    return await PokemonInteractor().fetchListOfPokemon(http.Client(), limit, offset);
  }

  Future<Pokemon> getPokemon(String url) async {
    return await PokemonInteractor().fetchPokemon(http.Client(), url);
  }

  void presentPokemon(BuildContext context, String url) async {
    Pokemon pokemon = await getPokemon(url);
    if (context.mounted) {
      PokemonRouter().presentPokemon(context, pokemon);
    }
  }
}

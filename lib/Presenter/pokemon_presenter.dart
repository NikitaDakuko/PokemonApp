import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:pokemon_application/Interactor/pokemon_interactor.dart';
import 'package:pokemon_application/router.dart';

class PokemonPresenter {
  PokemonPresenter();

  Future<Map<String, String>> pokemonlist() async {
    return await PokemonInteractor().fetchListOfPokemon(http.Client());
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

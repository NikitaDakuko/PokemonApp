import 'package:flutter/material.dart';
import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:pokemon_application/Interactor/pokemon_interactor.dart';
import 'package:http/http.dart' as http;

import '../Entity/enum_poke_type.dart';
import '../router.dart';

class PokemonPresenter {
  PokemonPresenter();

  Future<List<PokeType>> getTypes(String url)async {
    Pokemon p = await getPokemon(url);
    return p.types!;
  }

  Future<Map<String, String>> pokemonlist() async {
    return await PokemonInteractor().fetchListOfPokemon(http.Client());
  }

  Future<Pokemon> getPokemon(String url) async {
    return await PokemonInteractor().fetchPokemon(http.Client(), url);
  }

  void presentPokemon(BuildContext context, String url) async {
    Pokemon pokemon = await getPokemon(url);
    if (context.mounted){
      PokemonRouter().presentPokemon(context, pokemon);
    }
  }
}

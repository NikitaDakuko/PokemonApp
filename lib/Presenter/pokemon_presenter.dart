import 'package:collection/collection.dart' show mergeMaps;
import 'package:http/http.dart';
import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:pokemon_application/Interactor/pokemon_interactor.dart';
import 'package:pokemon_application/router.dart';

class PokemonPresenter {
  final PokemonInteractor pokemonInteractor = PokemonInteractor();
  Map<String, dynamic> currentList = {};
  int offset = 0;

  Future<Map<String, dynamic>> nextPage(int limit) async {
    currentList = mergeMaps<String, dynamic>(
        currentList, await getPokemonList(limit, offset));
    offset = currentList.length;
    return currentList;
  }

  Future<Map<String, dynamic>> getPokemonList(int limit, int offset) async {
    try {
      return await pokemonInteractor.fetchListOfPokemon(
          Client(), limit, offset);
    } on ClientException catch (_) {
      return await pokemonInteractor.fetchListOfPokemonFromDB(limit, offset);
    }
  }

  Future<Pokemon> getPokemon(id) async {
    try {
      return await pokemonInteractor.fetchPokemon(Client(), id);
    } on ClientException catch (_) {
      return pokemonInteractor.fetchPokemonFromDB(id);
    }
  }

  void presentPokemon(context, id) async {
    Pokemon pokemon = await getPokemon(id);
    if (context.mounted) {
      PokemonRouter().presentPokemon(context, pokemon);
    }
  }
}

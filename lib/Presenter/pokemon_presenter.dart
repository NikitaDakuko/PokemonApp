import 'package:http/http.dart' as http;
import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:pokemon_application/Interactor/pokemon_interactor.dart';
import 'package:pokemon_application/router.dart';

class PokemonPresenter {
  int offset = 0;

  Future<Map<String, dynamic>> nextPage(int limit) async{
    final pl = await pokemonList(limit, offset);
    offset += limit;
    return pl;
  }

  Future<Map<String, dynamic>> pokemonList(int limit, int offset) async {
    return await PokemonInteractor().fetchListOfPokemon(http.Client(), limit, offset);
  }

  Future<Pokemon> getPokemon(id) async {
    return await PokemonInteractor().fetchPokemon(http.Client(), id);
  }

  void presentPokemon(context, id) async {
    Pokemon pokemon = await getPokemon(id);
    if (context.mounted) {
      PokemonRouter().presentPokemon(context, pokemon);
    }
  }
}

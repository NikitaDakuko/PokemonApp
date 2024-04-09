import 'package:collection/collection.dart' show mergeMaps;
import 'package:get_it/get_it.dart';
import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:pokemon_application/Interactor/pokemon_interactor.dart';
import 'package:pokemon_application/router.dart';

class PokemonPresenter {
  final getIt = GetIt.instance;
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
      return await getIt<PokemonInteractor>()
          .fetchListOfPokemon(limit, offset);
    } catch (_) {
      return await getIt<PokemonInteractor>()
          .fetchListOfPokemonFromDB(limit, offset);
    }
  }

  Future<Pokemon> getPokemon(id) async {
    try {
      final result =
          await getIt<PokemonInteractor>().fetchPokemon(id);
      getIt<PokemonInteractor>().insertPokemonIntoDB(result);
      return result;
    } catch (_) {
      return getIt<PokemonInteractor>().fetchPokemonFromDB(id);
    }
  }

  void presentPokemon(context, id) async {
    Pokemon pokemon = await getPokemon(id);
    if (context.mounted) {
      getIt<PokemonRouter>().presentPokemon(context, pokemon);
    }
  }
}

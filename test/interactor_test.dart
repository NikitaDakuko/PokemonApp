import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_application/Interactor/pokemon_interactor.dart';
import 'test_data.dart';

void main() async {
  final getIt = GetIt.instance;

  getIt.registerSingleton<PokemonInteractor>(PokemonInteractor());
  getIt.registerSingleton<Dio>(Dio());

  final data = TestData();

  group('PokemonInteractor testing start', () {
    test('JSON should be parsed', () {
      expect(getIt<PokemonInteractor>().parseListOfPokemon(data.listResponse),
          data.pokemonListResult);
    });

    test('List of Pokemon should be fetched and parsed', () async {
      expect(await getIt<PokemonInteractor>().fetchListOfPokemon(3, 0),
          data.pokemonListResult);
    });

    test('Pokemon should be fetched and parsed', () async {
      expect((await getIt<PokemonInteractor>().fetchPokemon(69)).toString(),
          data.pokemonResult.toString());
    });
  });
}

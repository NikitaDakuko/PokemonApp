import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_application/Interactor/pokemon_interactor.dart';
import 'interactor_test.mocks.dart';
import 'test_data.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
void main() async {
  final PokemonInteractor pokemonInteractor = PokemonInteractor();

  final data = TestData();

  final client = MockClient();
  when(client.get(Uri.parse(data.pokemonURL)))
      .thenAnswer((_) async => http.Response(data.pokemonResponse, 200));
  when(client.get(Uri.parse(data.pokemonListURL)))
      .thenAnswer((_) async => http.Response(data.listResponse, 200));

  group('PokemonInteractor testing start', () {
    test('JSON should be parsed', () {
      expect(pokemonInteractor.parseListOfPokemon(data.listResponse),
          data.pokemonListResult);
    });

    test('List of Pokemon should be fetched and parsed', () async {
      expect(await pokemonInteractor.fetchListOfPokemon(client, 3, 0),
          data.pokemonListResult);
    });

    test('Pokemon should be fetched and parsed', () async {
      expect((await pokemonInteractor.fetchPokemon(client, 69)).toString(),
          data.pokemonResult.toString());
    });
  });
}

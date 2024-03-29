import 'package:flutter/material.dart';
import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:pokemon_application/Interactor/pokemon_interactor.dart';
import 'package:http/http.dart' as http;

class PokemonPresenter {
  PokemonPresenter({required this.pokemonInteractor, required this.context});

  final BuildContext context;
  final PokemonInteractor pokemonInteractor;

  List<Widget> getTypes(Pokemon p) {
    List<Widget> w = [];

    for (var t in p.types!) {
      w.add(Container(
        decoration: BoxDecoration(
          color: t.color,
        ),
        child: Text(t.name),
      ));
    }
    return w;
  }

  Future<Widget> pokemonlist() async {
    List<String> pl = await pokemonInteractor.fetchListOfPokemon(http.Client());
    return Wrap(
      children: [
        for (String s in pl)
          SizedBox(
            width: 100,
            child: FloatingActionButton(
              onPressed: () => present(1),
              child: Text(s),
            ),
          ),
      ],
    );
  }

  Future<Future> present(int id) async {
    Pokemon p = await pokemonInteractor.fetchPokemon(http.Client(), id);

    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: Column(
          children: [
            Text('Name: ${p.name}'),
            Text('Weight: ${p.weight}'),
            Text('Height: ${p.height}'),
          ],
        ),
      );
    });
  }
}

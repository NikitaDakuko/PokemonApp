import 'package:flutter/material.dart';
import 'package:pokemon_application/Presenter/pokemon_presenter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PokemonPresenter pokemonPresenter = PokemonPresenter();
  late Widget pm = const Text("this is where I'd put my data");

  void _getPokemon(context) async {
    Map<String, String> pl = await pokemonPresenter.pokemonlist();
    pm = Wrap(
      children: [
        for (MapEntry<String, String> s in pl.entries)
          SizedBox(
            width: 100,
            child: FloatingActionButton(
              onPressed: () =>
                  {pokemonPresenter.presentPokemon(context, s.value)},
              child: Text(s.key),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pm,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _getPokemon(context);
        }),
      ),
    );
  }
}

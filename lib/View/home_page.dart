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
  late List<Widget> pokemonList = [];

  void _getPokemon(BuildContext context, int limit) async {
    Map<String, dynamic> pl = await pokemonPresenter.nextPage(limit);
    setState(() {
      List<Widget> newList = [];
      for (MapEntry<String, dynamic> s in pl.entries) {
        newList.add(SizedBox(
            width: 500,
            child: TextButton(
                onPressed: () =>
                    {pokemonPresenter.presentPokemon(context, s.value)},
                child: Text(
                  s.key,
                  style: const TextStyle(fontSize: 32),
                ))));
      }
      pokemonList = newList;
    });
  }

  @override
  void initState() {
    super.initState();
    _getPokemon(context, 20);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: pokemonList,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          _getPokemon(context, 20);
        },
      ),
    );
  }
}

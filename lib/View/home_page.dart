import 'package:flutter/material.dart';
import 'package:pokemon_application/Interactor/pokemon_interactor.dart';
import 'package:pokemon_application/Presenter/pokemon_presenter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Widget pm = const Text("this is where I'd put my data");

  void _getPokemon(context) async{
    pm = await PokemonPresenter(pokemonInteractor: PokemonInteractor(), context: context).pokemonlist();
    setState(() {});
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
        onPressed: () => _getPokemon(context),
      ),
    );
  }
}

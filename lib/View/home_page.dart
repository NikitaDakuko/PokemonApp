import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_application/BLoC/home_page_bloc.dart';
import 'package:pokemon_application/Presenter/pokemon_presenter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final homePageBloc = BlocProvider.of<HomePageBloc>(context)
      ..add(HomePagePokemonLoaded());

    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= 20.0) {
        homePageBloc.add(HomePagePokemonLoaded());
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: BlocBuilder<HomePageBloc, Map<String, dynamic>>(
            builder: (context, pl) {
              return Column(children: [
                for (MapEntry s in pl.entries)
                  SizedBox(
                      width: 500,
                      child: TextButton(
                          onPressed: () => {
                                GetIt.instance<PokemonPresenter>()
                                  ..presentPokemon(context, s.value)
                              },
                          child: Text(
                            s.key,
                            style: const TextStyle(fontSize: 32),
                          )))
              ]);
            },
          ),
        ),
      ),
    );
  }
}

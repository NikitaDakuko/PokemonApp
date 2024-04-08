import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:pokemon_application/Interactor/pokemon_interactor.dart';
import 'package:pokemon_application/Presenter/pokemon_presenter.dart';

import 'Cache/cache_db.dart';
import 'Cache/poke_type_adapter.dart';
import 'Cache/pokemon_adapter.dart';
import 'View/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PokemonAdapter());
  Hive.registerAdapter(PokeTypeAdapter());
  await Hive.openBox<Pokemon>(CacheDB.dbName);

  final getIt = GetIt.instance;
  getIt.registerSingleton<CacheDB>(CacheDB());
  getIt.registerSingleton<PokemonInteractor>(PokemonInteractor());
  getIt.registerSingleton<PokemonPresenter>(PokemonPresenter());
  getIt.registerSingleton<Dio>(Dio());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pokemon app'),
    );
  }
}

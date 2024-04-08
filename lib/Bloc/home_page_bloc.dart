import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_application/Presenter/pokemon_presenter.dart';

class HomePagePokemonLoaded {}

class HomePageBloc extends Bloc<HomePagePokemonLoaded, Map<String, dynamic>> {
  final getIt = GetIt.instance;

  HomePageBloc() : super({}) {
    on<HomePagePokemonLoaded>((event, emit) async {
      emit(await getIt<PokemonPresenter>().nextPage(20));
    });
  }
}

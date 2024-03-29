import 'enum_poke_type.dart';

class Pokemon {
  Pokemon(this.id, this.name, this.types, this.weight, this.height);

  String name;
  int id;
  List<PokeType> types;
  int weight;
  int height;

}
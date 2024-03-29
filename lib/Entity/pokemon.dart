import 'enum_poke_type.dart';

class Pokemon {
  Pokemon({
    required this.name,
    required this.weight,
    this.types,
    required this.height});

  String name;
  List<PokeType>? types;
  int weight;
  int height;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        name: json['name'],
        //types: json['types.type'],
        weight: json['weight'],
        height: json['height']);
  }
}

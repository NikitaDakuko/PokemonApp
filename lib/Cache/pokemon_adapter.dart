import 'package:hive/hive.dart';
import 'package:pokemon_application/Entity/pokemon.dart';

class PokemonAdapter extends TypeAdapter<Pokemon> {
  @override
  final typeId = 0;

  @override
  Pokemon read(BinaryReader reader) {
    final id = reader.read();
    final name = reader.read();
    final pictureURL = reader.read();
    final weight = reader.read();
    final height = reader.read();
    return Pokemon(id: id, name: name, pictureURL: pictureURL, types: [], weight: weight, height: height);
  }

  @override
  void write(BinaryWriter writer, Pokemon obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.pictureURL);
    writer.write(obj.weight);
    writer.write(obj.height);
  }
}

import 'package:hive/hive.dart';
import 'package:pokemon_application/Entity/pokemon.dart';

class PokemonAdapter extends TypeAdapter<Pokemon> {
  @override
  final typeId = 0;

  @override
  Pokemon read(BinaryReader reader) {
    return Pokemon(
      id: reader.read(),
      name: reader.read(),
      pictureURL: reader.read(),
      types: reader.readList(),
      weight: reader.read(),
      height: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Pokemon obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.pictureURL);
    writer.writeList(obj.types);
    writer.write(obj.weight);
    writer.write(obj.height);
  }
}

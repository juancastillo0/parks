import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class Place {
  int key;
  String name;
  double latitud;
  double longitud;
  String description;
  double rating;
  String address;

  Place({
    this.key,
    this.name,
    this.latitud,
    this.longitud,
    this.description,
    this.rating,
    this.address,
  });
}

var places = [
  Place(
    key: 1,
    name: "National Park",
    description:
        "Sed culpa consequuntur labore in. Quis quia recusandae amet. Consectetur doloribus sit omnis temporibus officia. Earum ipsum tempora occaecati fugit. Deserunt facilis autem occaecati consequatur iure maxime ut.",
    address: "Calle 45 # 7 - 12",
    rating: 4.2,
    latitud: 4.669515485820514,
    longitud: -74.05895933919157,
  ),
  Place(
    key: 2,
    name: "Local Park",
    description:
        "Qui ratione officiis repellat. Et maiores facilis optio excepturi animi. Ut consequatur consequatur non omnis. Omnis ut ad enim quia in sit. Facere temporibus ipsam nesciunt recusandae ex qui dolores eos.",
    rating: 3.5,
    address: "Calle 80 # 11 - 38",
    latitud: 4.610515485820514,
    longitud: -74.07895933919157,
  ),
  Place(
    key: 3,
    name: "Virrey Park",
    description:
        "Voluptas placeat quia itaque consequatur reprehenderit sunt ipsa eligendi. Sed est pariatur consequatur voluptas sunt omnis non numquam veritatis. Praesentium est molestiae aut et. Quos nobis dolor enim est.",
    rating: 4.0,
    address: "Carrera 15 # 87 - 67",
    latitud: 4.607683967477323,
    longitud: -73.8008203466492,
  )
];

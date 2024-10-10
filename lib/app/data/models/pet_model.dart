import 'package:get/get.dart';

class Pet {
  final RxString id;
  final RxString name;
  final RxString type;
  final RxString breed;
  final RxInt age;
  final RxString imageUrl;
  final RxDouble weight; // Tambahkan weight

  Pet({
    String? id,
    required String name,
    required String type,
    required String breed,
    required int age,
    double weight = 0.0, // Default weight 0.0
    String imageUrl = '',
  }) : 
    id = RxString(id ?? DateTime.now().millisecondsSinceEpoch.toString()),
    name = RxString(name),
    type = RxString(type),
    breed = RxString(breed),
    age = RxInt(age),
    weight = RxDouble(weight), // Inisialisasi weight
    imageUrl = RxString(imageUrl);

  // Convert Pet object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id.value,
      'name': name.value,
      'type': type.value,
      'breed': breed.value,
      'age': age.value,
      'weight': weight.value, // Tambahkan weight
      'imageUrl': imageUrl.value,
    };
  }

  // Create a Pet object from a Map
  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      breed: json['breed'],
      age: json['age'],
      weight: json['weight'], // Tambahkan weight
      imageUrl: json['imageUrl'],
    );
  }

  // Create a copy of the Pet object with updated fields
  Pet copyWith({
    String? name,
    String? type,
    String? breed,
    int? age,
    double? weight, // Tambahkan weight
    String? imageUrl,
  }) {
    return Pet(
      id: this.id.value,
      name: name ?? this.name.value,
      type: type ?? this.type.value,
      breed: breed ?? this.breed.value,
      age: age ?? this.age.value,
      weight: weight ?? this.weight.value, // Tambahkan weight
      imageUrl: imageUrl ?? this.imageUrl.value,
    );
  }
}

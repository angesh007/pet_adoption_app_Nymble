// pet.dart
class Pet {
  final String name;
  final int age;
  final double price;
  final String image;

  bool isAdopted;
  bool isHovered; // Add this line for the isHovered property

  Pet({
    required this.name,
    required this.age,
    required this.price,
    required this.image,
    this.isAdopted = false,
    this.isHovered = false, // Set the default value to false
  });
}

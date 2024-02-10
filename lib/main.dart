import 'package:flutter/material.dart';
import 'package:pet_adoption_app/screens/home_screen.dart';
import 'package:pet_adoption_app/screens/history_screen.dart';
import 'package:pet_adoption_app/models/pet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Pet> pets = [
    Pet(name: 'Fluffy', age: 2, price: 60, image: 'assets/pets/cat.jpg'),
    Pet(name: 'Buddy', age: 1, price: 15, image: 'assets/pets/dog.jpg'),
    Pet(name: 'Sparky', age: 8, price: 80, image: 'assets/pets/dog2.jpg'),
    Pet(name: 'Max', age: 6, price: 40, image: 'assets/pets/dog3.JPG'),
    Pet(name: 'Bella', age: 7, price: 60, image: 'assets/pets/dog4.jpg'),
    Pet(name: 'Rocky', age: 9, price: 30, image: 'assets/pets/dog5.jpg'),
    Pet(name: 'Luna', age: 9, price: 70, image: 'assets/pets/cat2.jpg'),
    Pet(name: 'Oliver', age: 2, price: 10, image: 'assets/pets/cat3.jpg'),
    Pet(name: 'Chloe', age: 7, price: 25, image: 'assets/pets/cat4.jpg'),
    Pet(name: 'Simba', age: 3, price: 70, image: 'assets/pets/cat5.jpg'),
    Pet(name: 'reo', age: 3, price: 70, image: 'assets/pets/cat6.jpg'),
    Pet(name: 'jon', age: 7, price: 54, image: 'assets/pets/dog6.jpg'),

    // Add more pets if needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Add your light theme configurations here
      ),
      themeMode: ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(),
        body: HomeScreen(pets: pets),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Implement adoption action or navigate to adoption screen
          },
          child: Icon(Icons.pets),
        ),
      ),
      routes: {
        '/history': (context) => Scaffold(
              appBar: AppBar(
                title: Text('Adopted Pets'),
              ),
              body: HistoryScreen(adoptedPets: pets),
            ),
      },
    );
  }
}

// history_screen.dart
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/models/pet.dart';

class HistoryScreen extends StatelessWidget {
  final List<Pet> adoptedPets;

  HistoryScreen({required this.adoptedPets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adoption History'),
      ),
      body: adoptedPets.isEmpty
          ? Center(
              child: Text('No adopted pets yet.'),
            )
          : ListView.builder(
              itemCount: adoptedPets.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(adoptedPets[index].name),
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: AssetImage(adoptedPets[index].image),
                  ),
                  trailing: Icon(Icons.favorite, color: Colors.red),
                  onTap: () {
                    // Add any additional action on tap if needed
                  },
                );
              },
            ),
    );
  }
}

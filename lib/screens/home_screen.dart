import 'package:flutter/material.dart';
import 'package:pet_adoption_app/models/pet.dart';
import 'package:pet_adoption_app/screens/details_screen.dart';
import 'package:pet_adoption_app/screens/history_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<Pet> pets;

  HomeScreen({required this.pets});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pet> filteredPets = [];
  int currentPage = 1;
  int itemsPerPage = 9;
  TextEditingController searchController = TextEditingController();
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  void _loadPets() {
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;

    endIndex = endIndex.clamp(0, widget.pets.length);

    setState(() {
      filteredPets = widget.pets.sublist(startIndex, endIndex);
    });
  }

  void filterPets(String query) {
    setState(() {
      filteredPets = widget.pets
          .where((pet) => pet.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void nextPage() {
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;

    endIndex = endIndex.clamp(0, widget.pets.length);

    if (startIndex < widget.pets.length) {
      setState(() {
        currentPage++;
        _loadPets();
      });
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        _loadPets();
      });
    }
  }

  void markAsAdopted(Pet pet) {
    setState(() {
      pet.isAdopted = true;
    });
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pet Adoption App'),
          actions: [
            IconButton(
              icon: Icon(Icons.history),
              onPressed: () {
                List<Pet> adoptedPets =
                    widget.pets.where((pet) => pet.isAdopted).toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HistoryScreen(adoptedPets: adoptedPets),
                  ),
                );
              },
            ),
            Spacer(),
            IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: toggleTheme,
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Pet Adoption App',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: filteredPets.length,
                    itemBuilder: (context, index) {
                      return MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            filteredPets[index].isHovered = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            filteredPets[index].isHovered = false;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              if (filteredPets[index].isHovered)
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10.0,
                                ),
                            ],
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                if (!filteredPets[index].isAdopted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        pet: filteredPets[index],
                                        onAdopted: () =>
                                            markAsAdopted(filteredPets[index]),
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "This pet has already been adopted."),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: filteredPets[index].isHovered
                                        ? 50.0
                                        : 40.0,
                                    backgroundImage:
                                        AssetImage(filteredPets[index].image),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    filteredPets[index].name,
                                    style: TextStyle(
                                      color: filteredPets[index].isAdopted
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    filteredPets[index].isAdopted
                                        ? 'Already Adopted'
                                        : '',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: previousPage,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                        ),
                        child: Text('Previous'),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: nextPage,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                        ),
                        child: Text('Next'),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    List<Pet> adoptedPets =
                        widget.pets.where((pet) => pet.isAdopted).toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HistoryScreen(adoptedPets: adoptedPets),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                  ),
                  child: Text('History Page'),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: IconButton(
                icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                onPressed: toggleTheme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pet_adoption_app/models/pet.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DetailsScreen extends StatelessWidget {
  final Pet pet;
  final Function onAdopted;

  DetailsScreen({required this.pet, required this.onAdopted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Details'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'petImage${pet.name}',
                  child: GestureDetector(
                    onTap: () {
                      _showImageDialog(context);
                    },
                    child: CircleAvatar(
                      radius: 80.0,
                      backgroundImage: AssetImage(pet.image),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  pet.name,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Age: ${pet.age} years',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Price: \$${pet.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _showAdoptedPopup(context);
                    onAdopted();
                    Navigator.pop(context);
                  },
                  child: Text('Adopt'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 300.0,
            child: PhotoViewGallery.builder(
              itemCount: 1,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: AssetImage(pet.image),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
              scrollPhysics: BouncingScrollPhysics(),
              backgroundDecoration: BoxDecoration(
                color: Colors.black,
              ),
              pageController: PageController(),
            ),
          ),
        );
      },
    );
  }

  void _showAdoptedPopup(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("You've now adopted ${pet.name}"),
        duration: Duration(seconds: 3),
      ),
    );
  }
}

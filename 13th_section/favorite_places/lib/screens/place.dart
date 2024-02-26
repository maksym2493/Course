import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:flutter/material.dart';

class PlaceScreen extends StatelessWidget {
  const PlaceScreen({
    super.key,
    required this.place,
  });

  final Place place;

  String get _locationImageLink {
    final lat = place.location.latitude;
    final lng = place.location.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=13&size=300x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyBcK6_hgY8xCQsIpusEsznU_UZpCHOWFjQ';
  }

  void _openMap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
          location: place.location,
          isSelecting: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _openMap(context),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(_locationImageLink),
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(place.location.address,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place.dart';
import 'package:flutter/material.dart';

class MainItem extends StatelessWidget {
  const MainItem({
    super.key,
    required this.place,
  });

  final Place place;

  void _openPlaceScreen(BuildContext context, Place place) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PlaceScreen(
          place: place,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: InkSplash.splashFactory,
      borderRadius: BorderRadius.circular(16),
      onTap: () => _openPlaceScreen(context, place),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: FileImage(place.image),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                Text(
                  place.location.address,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

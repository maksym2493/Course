import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE favorite_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)',
      );
    },
    version: 1,
  );

  return db;
}

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('favorite_places');

    state = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
              address: row['address'] as String,
              latitude: row['lat'] as double,
              longitude: row['lng'] as double,
            ),
          ),
        )
        .toList();
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final fileName = path.basename(image.path);
    final appDir = await syspath.getApplicationDocumentsDirectory();

    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace = Place(
      title: title,
      image: copiedImage,
      location: location,
    );

    final db = await _getDatabase();

    db.insert(
      'favorite_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'lat': newPlace.location.latitude,
        'lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );

    state = [newPlace, ...state];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
  (ref) => PlacesNotifier(),
);

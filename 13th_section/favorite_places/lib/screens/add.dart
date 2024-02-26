import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddScreen extends ConsumerStatefulWidget {
  const AddScreen({super.key});

  @override
  ConsumerState<AddScreen> createState() {
    return _AddScreenState();
  }
}

class _AddScreenState extends ConsumerState<AddScreen> {
  File? _takenImage;
  PlaceLocation? _pickedLocation;
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(message),
      ),
    );
  }

  void _addPlace() {
    final enteredTitle = _titleController.text.trim();

    if (enteredTitle.isEmpty) {
      _showMessage('Length of title must be higer than 0.');
      return;
    }

    if (_takenImage == null) {
      _showMessage('Image must be provided.');
      return;
    }

    if (_pickedLocation == null) {
      _showMessage('Location must be provided.');
      return;
    }

    final notifier = ref.read(placesProvider.notifier);
    notifier.addPlace(enteredTitle, _takenImage!, _pickedLocation!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 20),
            ImageInput(
              onImageTaken: (takenImage) => _takenImage = takenImage,
            ),
            const SizedBox(height: 20),
            LocationInput(
              onLocationPicked: (pickedLocation) =>
                  _pickedLocation = pickedLocation,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _addPlace,
              label: const Text('Add Place'),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
    required this.onLocationPicked,
  });

  final void Function(PlaceLocation pickedLocation) onLocationPicked;

  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  bool _isGettingLocation = false;

  String get _locationImageLink {
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=13&size=600x200&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyBcK6_hgY8xCQsIpusEsznU_UZpCHOWFjQ';
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

  void _getCurrentLocation() async {
    setState(() => _isGettingLocation = true);

    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        setState(() => _isGettingLocation = false);
        _showMessage('Service is not enable.');
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        setState(() => _isGettingLocation = false);
        _showMessage('Permission rejected.');
        return;
      }
    }

    try {
      locationData = await location.getLocation();

      final lat = locationData.latitude;
      final lng = locationData.longitude;

      if (lat == null || lng == null) {
        setState(() => _isGettingLocation = false);
        _showMessage('Failed to get location.');
        return;
      }

      final address = await _getAddress(lat, lng);

      setState(
        () {
          _isGettingLocation = false;
          _pickedLocation = PlaceLocation(
            address: address,
            latitude: lat,
            longitude: lng,
          );
        },
      );
      widget.onLocationPicked(_pickedLocation!);
    } catch (error) {
      setState(() => _isGettingLocation = false);
      _showMessage('Something went wrong.');
    }
  }

  Future<String> _getAddress(double lat, double lng) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=AIzaSyBcK6_hgY8xCQsIpusEsznU_UZpCHOWFjQ',
    );

    final response = await http.get(url);
    final decodedBody = json.decode(response.body);

    return decodedBody['results'][0]['formatted_address'];
  }

  void _getLocationFromMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => _pickedLocation == null
            ? const MapScreen()
            : MapScreen(location: _pickedLocation!),
      ),
    );

    if (pickedLocation != null) {
      setState(() => _isGettingLocation = true);

      try {
        final lat = pickedLocation.latitude;
        final lng = pickedLocation.longitude;
        final address = await _getAddress(lat, lng);

        setState(
          () {
            _isGettingLocation = false;
            _pickedLocation = PlaceLocation(
              address: address,
              latitude: lat,
              longitude: lng,
            );
          },
        );
        widget.onLocationPicked(_pickedLocation!);
      } catch (error) {
        setState(() => _isGettingLocation = false);
        _showMessage('Something went wrong.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _getLocationFromMap,
          child: Container(
            width: double.infinity,
            height: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              ),
            ),
            child: _isGettingLocation
                ? const CircularProgressIndicator()
                : _pickedLocation != null
                    ? Image.network(
                        _locationImageLink,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Text(
                        'No location chosen.',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _isGettingLocation ? null : _getCurrentLocation,
              label: const Text('Get current location.'),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: _isGettingLocation ? null : _getLocationFromMap,
              label: const Text('Select on Map.'),
              icon: const Icon(Icons.map),
            )
          ],
        )
      ],
    );
  }
}

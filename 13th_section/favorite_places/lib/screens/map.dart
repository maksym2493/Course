import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.isSelecting = true,
    this.location = const PlaceLocation(
      address: '',
      latitude: 37.422,
      longitude: -122.084,
    ),
  });

  final bool isSelecting;
  final PlaceLocation location;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  late LatLng _pickedLocation;

  @override
  void initState() {
    super.initState();

    _pickedLocation = LatLng(
      widget.location.latitude,
      widget.location.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? 'Select Location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () => Navigator.of(context).pop(_pickedLocation),
              icon: const Icon(Icons.save),
            )
        ],
      ),
      body: GoogleMap(
        onTap: widget.isSelecting
            ? (location) {
                setState(() => _pickedLocation = location);
              }
            : null,
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 13,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('marker'),
            position: widget.isSelecting
                ? _pickedLocation
                : LatLng(
                    widget.location.latitude,
                    widget.location.longitude,
                  ),
          ),
        },
      ),
    );
  }
}

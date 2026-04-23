import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};

  final LatLng _center = const LatLng(46.0569, 14.5058); // Slovenia example

  @override
  void initState() {
    super.initState();
    _addSampleFlightSites();
  }

  void _addSampleFlightSites() {
    _markers.addAll([
      Marker(
        markerId: const MarkerId('site1'),
        position: const LatLng(46.0569, 14.5058),
        infoWindow: const InfoWindow(
          title: 'Flight Site 1',
          snippet: 'Beginner friendly',
        ),
      ),
      Marker(
        markerId: const MarkerId('site2'),
        position: const LatLng(46.1569, 14.6058),
        infoWindow: const InfoWindow(
          title: 'Flight Site 2',
          snippet: 'Advanced',
        ),
      ),
    ]);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('logo.webp', height: 32),
            const SizedBox(width: 12),
            const Text('Flight Sites'),
          ],
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers,
      ),
    );
  }
}

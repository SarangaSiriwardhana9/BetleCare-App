import 'package:betlecare/widgets/appbar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class ManualLandMeasurementPage extends StatefulWidget {
  const ManualLandMeasurementPage({super.key});

  @override
  _ManualLandMeasurementPageState createState() => _ManualLandMeasurementPageState();
}

class _ManualLandMeasurementPageState extends State<ManualLandMeasurementPage> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = {};
  final List<LatLng> _polygonPoints = [];
  final int _polygonIdCounter = 1;
  int _markerIdCounter = 1;
  double? _area;
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled. Please enable the services')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    _currentLocation = LatLng(position.latitude, position.longitude);

    if (_mapController != null) {
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _currentLocation!,
            zoom: 18,
          ),
        ),
      );
    }

    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_currentLocation != null) {
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _currentLocation!,
            zoom: 18,
          ),
        ),
      );
    }
  }

  void _addMarker(LatLng pos) {
    final String markerIdVal = 'marker_$_markerIdCounter';
    _markerIdCounter++;

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: pos,
        ),
      );
      _polygonPoints.add(pos);
      _updatePolygon();
    });
  }

  void _updatePolygon() {
    setState(() {
      _polygons.clear();
      _polygons.add(Polygon(
        polygonId: PolygonId('polygon_$_polygonIdCounter'),
        points: _polygonPoints,
        strokeWidth: 2,
        strokeColor: Colors.red,
        fillColor: Colors.red.withOpacity(0.15),
      ));
    });
  }

  void _calculateArea() {
    if (_polygonPoints.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least 3 points to calculate the area.')),
      );
      return;
    }

    double area = 0;
    for (int i = 0; i < _polygonPoints.length; i++) {
      int j = (i + 1) % _polygonPoints.length;
      area += (_polygonPoints[i].latitude * _polygonPoints[j].longitude) -
          (_polygonPoints[j].latitude * _polygonPoints[i].longitude);
    }
    area = (area.abs() * 111319.9 * 111319.9) / 2; // Convert to square meters
    //convert in to acres
    area = area / 4046.86;

    setState(() {
      _area = area;
    });
  }

  void _resetMeasurement() {
    setState(() {
      _markers.clear();
      _polygons.clear();
      _polygonPoints.clear();
      _area = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentLocation ?? const LatLng(0, 0),
              zoom: 14.4746,
            ),
            markers: _markers,
            polygons: _polygons,
            onTap: _addMarker,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 72, // Adjusted to make space for FABs
            child: _area != null
                ? Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Calculated Area: ${_area!.toStringAsFixed(2)} Acres',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: _calculateArea,
              backgroundColor: Colors.blue[100]!,
              heroTag: 'calculate',
              child: const Icon(Icons.calculate),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: _resetMeasurement,
              backgroundColor: Colors.green[100]!,
              heroTag: 'reset',
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:math';

class ManualLandMeasurementPage extends StatefulWidget {
  @override
  _ManualLandMeasurementPageState createState() => _ManualLandMeasurementPageState();
}

class _ManualLandMeasurementPageState extends State<ManualLandMeasurementPage> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polygon> _polygons = {};
  List<LatLng> _polygonPoints = [];
  int _polygonIdCounter = 1;
  int _markerIdCounter = 1;
  double? _area;

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location services are disabled. Please enable the services')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 18,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
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
        SnackBar(content: Text('Please select at least 3 points to calculate the area.')),
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
      appBar: AppBar(
        title: Text('Manual Land Measurement'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
            markers: _markers,
            polygons: _polygons,
            onTap: _addMarker,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_area != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Calculated Area: ${_area!.toStringAsFixed(2)} sq meters',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _calculateArea,
                        child: Text('Calculate Area'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _resetMeasurement,
                        child: Text('Reset'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


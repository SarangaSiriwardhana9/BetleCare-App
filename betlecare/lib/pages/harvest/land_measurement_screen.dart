import 'package:betlecare/widgets/appbar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:math';

class LandMeasurementScreen extends StatefulWidget {
  @override
  _LandMeasurementScreenState createState() => _LandMeasurementScreenState();
}

class _LandMeasurementScreenState extends State<LandMeasurementScreen> {
  GoogleMapController? _mapController;
  List<LatLng> _polygonPoints = [];
  Set<Polygon> _polygons = {};
  Set<Polyline> _polylines = {};
  bool _isRecording = false;
  StreamSubscription<Position>? _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLocationPermission();
    });
  }

  Future<void> _checkLocationPermission() async {
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

    // Permission granted, get initial position
    try {
      Position position = await Geolocator.getCurrentPosition();
      _updateCameraPosition(position);
    } catch (e) {
      print("Error getting current position: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get current location. Please try again.')),
      );
    }
  }

  void _updateCameraPosition(Position position) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 18,
        ),
      ),
    );
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _polygonPoints.clear();
      _polygons.clear();
      _polylines.clear();
    });

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position position) {
      setState(() {
        _polygonPoints.add(LatLng(position.latitude, position.longitude));
        _updatePolygon();
        _updatePolyline();
      });
      _updateCameraPosition(position);
    });
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
    });
    _positionStreamSubscription?.cancel();
    _calculateArea();
  }

  void _updatePolygon() {
    _polygons.clear();
    if (_polygonPoints.length >= 3) {
      _polygons.add(Polygon(
        polygonId: PolygonId('land'),
        points: _polygonPoints,
        strokeWidth: 2,
        strokeColor: Colors.red,
        fillColor: Colors.red.withOpacity(0.3),
      ));
    }
  }

  void _updatePolyline() {
    _polylines.clear();
    _polylines.add(Polyline(
      polylineId: PolylineId('landBoundary'),
      points: _polygonPoints,
      color: Colors.blue,
      width: 3,
    ));
  }

  void _calculateArea() {
    if (_polygonPoints.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Not enough points to calculate area. Please walk around the entire perimeter.')),
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

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Land Area'),
        content: Text('The measured land area is approximately ${area.toStringAsFixed(2)} square meters.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(),
      body: GoogleMap(
        onMapCreated: (controller) => _mapController = controller,
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 18,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        polygons: _polygons,
        polylines: _polylines,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              backgroundColor: (_isRecording ? Colors.red[100]! : Colors.green[100]!),
              child: Icon(_isRecording ? Icons.stop : Icons.play_arrow),
              heroTag: Text(_isRecording ? 'Stop' : 'Start'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    _mapController?.dispose();
    super.dispose();
  }
}


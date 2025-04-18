import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class HospitalMapScreen extends StatefulWidget {
  @override
  _HospitalMapScreenState createState() => _HospitalMapScreenState();
}

class _HospitalMapScreenState extends State<HospitalMapScreen> {
  late MapController _mapController;
  List<Marker> _hospitalMarkers = [];
  LatLng? _userLocation;
  bool _loading = true;
  List<Map<String, dynamic>> _nearbyHospitals = [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _initLocationAndHospitals();
  }


  Future<void> _initLocationAndHospitals() async {
    try {
      Location location = Location();

      // Get user location
      final userLocation = await location.getLocation();
      _userLocation = LatLng(userLocation.latitude!, userLocation.longitude!);


      final hospitals = await _fetchNearbyHospitals(_userLocation!);

      setState(() {
        _hospitalMarkers = hospitals.map((hospital) {
          final location = hospital['location'];
          final name = hospital['name'];

          return Marker(
            point: location,
            width: 40,
            height: 40,
            child: Tooltip(
              message: name,
              child: Icon(Icons.local_hospital, color: Colors.red, size: 30),
            ),
          );
        }).toList();
        _nearbyHospitals = hospitals;
        _loading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() => _loading = false);
    }
  }

  Future<List<Map<String, dynamic>>> _fetchNearbyHospitals(LatLng location) async {
    final lat = location.latitude;
    final lon = location.longitude;

    final radius = 100000;

    final overpassQuery = '''
      [out:json];
      node(around:$radius,$lat,$lon)["amenity"="hospital"];
      out body;
    ''';

    final response = await http.post(
      Uri.parse('https://overpass-api.de/api/interpreter'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'data': overpassQuery},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> hospitals = data['elements'];

      List<Map<String, dynamic>> nearbyHospitals = [];

      for (var hospital in hospitals) {
        final lat = hospital['lat'];
        final lon = hospital['lon'];
        final hospitalLocation = LatLng(lat, lon);

        if (hospital['tags']?['name'] == null || hospital['lat'] == null || hospital['lon'] == null) {
          continue;
        }


        double distance = await _calculateDistance(hospitalLocation);

        nearbyHospitals.add({
          'name': hospital['tags']?['name'] ?? 'Hospital',
          'location': hospitalLocation,
          'distance': distance,
        });
      }

      nearbyHospitals.sort((a, b) => a['distance'].compareTo(b['distance']));

      return nearbyHospitals;
    } else {
      throw Exception("Failed to load hospitals");
    }
  }

  Future<double> _calculateDistance(LatLng hospitalLocation) async {
    if (_userLocation != null) {
      double lat1 = _userLocation!.latitude;
      double lon1 = _userLocation!.longitude;
      double lat2 = hospitalLocation.latitude;
      double lon2 = hospitalLocation.longitude;

      const double R = 6371000;
      double phi1 = _toRadians(lat1);
      double phi2 = _toRadians(lat2);
      double deltaPhi = _toRadians(lat2 - lat1);
      double deltaLambda = _toRadians(lon2 - lon1);

      double a = (sin(deltaPhi / 2) * sin(deltaPhi / 2)) +
          cos(phi1) * cos(phi2) * (sin(deltaLambda / 2) * sin(deltaLambda / 2));
      double c = 2 * atan2(sqrt(a), sqrt(1 - a));

      double distance = R * c;
      return distance;
    }
    return 0.0;
  }

  double _toRadians(double degree) {
    return degree * (pi / 180.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nearby Hospitals")),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: _userLocation,
                zoom: 14.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.curemate',
                ),
                MarkerLayer(
                  markers: [
                    if (_userLocation != null)
                      Marker(
                        point: _userLocation!,
                        width: 40,
                        height: 40,
                        child: Icon(Icons.my_location, color: Colors.blue, size: 30),
                      ),
                    ..._hospitalMarkers,
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _nearbyHospitals.length,
              itemBuilder: (context, index) {
                final hospital = _nearbyHospitals[index];
                final name = hospital['name'];
                final distance = hospital['distance'] / 1000;
                return Card(
                  child: ListTile(
                    title: Text(name),
                    subtitle: Text("${distance.toStringAsFixed(2)} km away"),
                    onTap: () {
                      _mapController.move(hospital['location'], 14.0);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

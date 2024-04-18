import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geocoding Example',
      home: GeocodingExample(),
    );
  }
}

class GeocodingExample extends StatefulWidget {
  @override
  _GeocodingExampleState createState() => _GeocodingExampleState();
}

class _GeocodingExampleState extends State<GeocodingExample> {
  String _address = '';
  String _latitude = '';
  String _longitude = '';

  Future<void> _getCoordinates(String address) async {
    List<Location> locations = await locationFromAddress(address);
    setState(() {
      if (locations.isNotEmpty) {
        _latitude = locations[0].latitude.toString();
        _longitude = locations[0].longitude.toString();
        _address = address;
      } else {
        _address = 'Address not found';
        _latitude = '';
        _longitude = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geocoding Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Enter Address'),
              onSubmitted: (value) => _getCoordinates(value),
            ),
            SizedBox(height: 20),
            Text('Address: $_address'),
            Text('Latitude: $_latitude'),
            Text('Longitude: $_longitude'),
          ],
        ),
      ),
    );
  }
}

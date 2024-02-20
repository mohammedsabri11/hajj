import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../styles.dart';

class ParamedicHomePage extends StatefulWidget {
  const ParamedicHomePage({Key? key}) : super(key: key);

  @override
  _ParamedicHomePageState createState() => _ParamedicHomePageState();
}

class _ParamedicHomePageState extends State<ParamedicHomePage> {
  late GoogleMapController mapController;

  List<Pilgrim> _pilgrams = [];
  Timer? _timer;
  LatLng? _currentLocation;
  bool serviceEnabled = false;
  final IPilgramProvider _locationProvider = PilgramProvider();

  @override
  void initState() {
    super.initState();
    checkLocationStatus();
    _fetchData();

    // Set up a timer to refresh the data every 5 minutes
    _startDataRefreshTimer();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> _fetchData() async {
    try {
      final locations = await _locationProvider.fetchLocations();
      setState(() {
        _pilgrams = locations;
      });
    } catch (e) {
      // Handle error case
    }
  }
  void _startDataRefreshTimer() {
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      _fetchData();
    });
  }







  Future<void> checkLocationStatus() async {
    LocationPermission permission = await _requestLocationPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      // Location permission not granted, handle accordingly
      checkLocationStatus();
    }
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location service is disabled, handle accordingly
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        checkLocationStatus();
      }
    }

    getCurrentLocation();
  }

  void getCurrentLocation() async {
    /*  LocationPermission permission = await _requestLocationPermission();

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (serviceEnabled) { */
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    return statusToPermission(status);
  }

  LocationPermission statusToPermission(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return LocationPermission.always;
      case PermissionStatus.denied:
        return LocationPermission.denied;
      case PermissionStatus.restricted:
        return LocationPermission.deniedForever;
      default:
        return LocationPermission.denied;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentLocation == null) {
      return _buildLoadingScreen();
    }
    return _buildMapScreen();
  }
  Widget _buildLoadingScreen() {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildMapScreen() {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildMap(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.green,
      title: const Text('حج امن'),
      elevation: 2,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.logout_outlined),
        ),
      ],
    );
  }
  Widget _buildMap() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      initialCameraPosition: CameraPosition(
        target: _currentLocation!,
        zoom: 15.0,
      ),
      markers: _getMarkers(),
      circles: _getCircle(),
    );
  }
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  //Set<Marker>
 /* _getMarkers() {
    final markers = <Marker>{};
    markers.addAll(
      _pilgrams.map(
            (pilgrim) => Marker(
            markerId: MarkerId(pilgrim.location.toString()),
            position: pilgrim.location,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    content:
                    Container(height: 160, child: HealthVitulsList(pilgrim)),
                    alignment: Alignment.center,
                    titleTextStyle: ThemeText.textBody2,
                    contentTextStyle: ThemeText.textBody2,
                    actionsAlignment: MainAxisAlignment.center,
                    actionsOverflowButtonSpacing: 8.0,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Hide'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: getMarkerForPilgrimStatus(pilgrim.status)
        ),
      ),
    );
    return markers;
  }*/
  //Set<Circle>
  _getCircle() {
    final circles = <Circle>{};
    circles.add(Circle(
        circleId: CircleId('idfd'),
        center: _currentLocation!,
        radius: 400,
        fillColor: Color.fromARGB(255, 231, 211, 211)));
    return circles;
  }
  Set<Marker> _getMarkers() {
    final markers = <Marker>{};
    markers.addAll(_pilgrams.map((pilgrim) => _createMarker(pilgrim)));
    return markers;
  }

  Marker _createMarker(Pilgrim pilgrim) {
    return Marker(
      markerId: MarkerId(pilgrim.location.toString()),
      position: pilgrim.location,
      onTap: () => _showPilgrimDialog(pilgrim),
      icon: getMarkerForPilgrimStatus(pilgrim.status),
    );
  }

  void _showPilgrimDialog(Pilgrim pilgrim) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Container(
            height: 160,
            child: HealthVitulsList(pilgrim),
          ),
          alignment: Alignment.center,
          titleTextStyle: ThemeText.textBody2,
          contentTextStyle: ThemeText.textBody2,
          actionsAlignment: MainAxisAlignment.center,
          actionsOverflowButtonSpacing: 8.0,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hide'),
            ),
          ],
        );
      },
    );
  }
   BitmapDescriptor getMarkerForPilgrimStatus(String status) {
    // BitmapDescriptor markerIcon=
    if (status == 'critical') {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }else
      return  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    //return markerIcon; // Default color
  }


}

abstract class IPilgramProvider {
  Future<List<Pilgrim>> fetchLocations();
}

class PilgramProvider implements IPilgramProvider {
  @override
  Future<List<Pilgrim>> fetchLocations() async {
    final response =
    await http.get(Uri.parse('http://172.19.16.47:8000/pilgrim2/'));

    if (response.statusCode == 200) {
      final Map dataObj = json.decode(response.body);

      final data = dataObj["nearest_pilgrim"] as List<dynamic>;


      return data.map((item) {
        final latitude = item['latitude'] as double;
        final longitude = item['longitude'] as double;
        final  pulse= item['heart_rate'] .toDouble();
        final heartRate= item['heart_rate'] .toDouble();
        final temperature= item['heart_rate'] .toDouble();
        //final status= item['status'] ;
        return Pilgrim(
          name:"hi" ,//item['name'],
          age:22 ,//item['age'],
          pulse: pulse,
          heartRate:heartRate,
          temperature: temperature,
          location: LatLng(latitude, longitude),
          status: 'normal'//status
        );
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class Pilgrim {
  final String name;
  final int age;
  final double pulse;
  final double heartRate;
  final double temperature;
  final LatLng location;
  final String status;
  Pilgrim({
    required this.name,
    required this.age,
    required this.pulse,
    required this.heartRate,
    required this.temperature,
    required this.location,
    required this.status,
  });
}

class HealthVitulsList extends StatelessWidget {
  final Pilgrim pilgram;
  const HealthVitulsList(this.pilgram, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(5.0),
      children: [
        HealthIndicatorCard(
          title: 'Heart Rate',
          value: '${pilgram.pulse} bpm',
          icon: Icons.favorite,
          color: Colors.red,
        ),
        SizedBox(height: 10.0),
        HealthIndicatorCard(
          title: 'Temperature',
          value: '${pilgram.temperature}',
          icon: Icons.healing,
          color: Colors.green,
        ),
      ],
    );
  }
}

class HealthIndicatorCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const HealthIndicatorCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 32.0,
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

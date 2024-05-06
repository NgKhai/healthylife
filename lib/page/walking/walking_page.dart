// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';
//
// class WalkingPage extends StatefulWidget {
//   const WalkingPage({super.key});
//
//   @override
//   State<WalkingPage> createState() => _WalkingPageState();
// }
//
// class _WalkingPageState extends State<WalkingPage> {
//   MapController mapController = MapController();
//   Location location = Location();
//   List<LatLng> routeCoordinates = [];
//   bool isTracking = false;
//   double currentSpeed = 0.0; // in meters per second
//   late StreamSubscription<LocationData> locationSubscription;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Walking'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: FlutterMap(
//               options: MapOptions(
//                 center: LatLng(10.776183323564736, 106.66732187988492),
//                 zoom: 12,
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate:
//                   "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                   subdomains: ['a', 'b', 'c'],
//                 ),
//                 PolylineLayer(
//                   polylines: [
//                     Polyline(
//                       points: routeCoordinates,
//                       color: Colors.blue,
//                       strokeWidth: 4.0,
//                     ),
//                   ],
//                 ),
//                 MarkerLayer(
//                   markers: [
//                     if (isTracking && routeCoordinates.isNotEmpty)
//                       Marker(
//                         point: LatLng(
//                           routeCoordinates.last.latitude,
//                           routeCoordinates.last.longitude,
//                         ),
//                         child: Icon(
//                           Icons.location_on,
//                           color: Colors.red,
//                           size: 30.0,
//                         ),
//                       )
//                   ],
//                 ),
//               ],
//               mapController: mapController,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   if (!isTracking) {
//                     startTracking();
//                   } else {
//                     stopTracking();
//                   }
//                 },
//                 child: Text(isTracking ? 'Stop' : 'Start'),
//               ),
//               Text('Speed: ${convertSpeed(currentSpeed).toInt()} km/h'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   void startTracking() {
//     setState(() {
//       isTracking = true;
//       routeCoordinates.clear();
//     });
//
//     // Start tracking location
//     locationSubscription =
//         location.onLocationChanged.listen((LocationData currentLocation) {
//           if (isTracking) {
//             setState(() {
//               final LatLng newLatLng =
//               LatLng(currentLocation.latitude!, currentLocation.longitude!);
//               routeCoordinates.add(newLatLng);
//               mapController.move(newLatLng, 15.0);
//
//               // Calculate speed in meters per second
//               currentSpeed = currentLocation.speed ?? 0.0;
//
//               print(
//                   'latitude: ${currentLocation.latitude} | longitude: ${currentLocation.longitude} | speed: $currentSpeed');
//             });
//           }
//         });
//   }
//
//   void stopTracking() {
//     setState(() {
//       isTracking = false;
//       currentSpeed = 0.0;
//     });
//
//     // Cancel the location subscription
//     locationSubscription.cancel();
//   }
//
//   // Convert speed from meters per second to kilometers per hour
//   int convertSpeed(double speedInMetersPerSecond) {
//     return (speedInMetersPerSecond * 3.6).toInt();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'dart:math' as math;


class WalkingPage extends StatefulWidget {
  const WalkingPage({super.key});

  @override
  State<WalkingPage> createState() => _WalkingPageState();
}

class _WalkingPageState extends State<WalkingPage> {
  final MapController _mapController = MapController();
  LatLng? currentLocation;
  List<LatLng> positions = []; // List to store tracked positions
  bool isTracking = false;
  double speed = 0.0; // Movement speed in m/s

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clearTrackingData();
  }

  void clearTrackingData() {
    positions.clear();
    _stopTracking();
  }

  Future<void> _getCurrentLocation() async {
    final locationData = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(locationData.latitude, locationData.longitude);
      print("Latitude: " + locationData.latitude.toString() + " | Longitude: " + locationData.longitude.toString());
    });
  }

  void _startTracking() async {
    positions.clear();
    await _getCurrentLocation();
    positions.add(currentLocation!); // Add initial position
    setState(() {
      isTracking = true;
    });
    _trackLocation();
  }

  void _stopTracking() {
    setState(() {
      isTracking = false;
      speed = 0;
    });
  }

  void _trackLocation() async {
    if (isTracking) {

      final locationData = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final newPosition = LatLng(locationData.latitude, locationData.longitude);
      positions.add(newPosition); // Add new position to trail

      print("Latitude: ${locationData.latitude} | Longitude: ${locationData.longitude}");
      print("This is speed: " + locationData.speed.toString());

      // Update current speed with the instantaneous speed provided by locationData
      setState(() {
        speed = locationData.speed ?? 0.0; // Use 0.0 as default speed if speed is null
        currentLocation = newPosition;
      });

      _mapController.move(
          currentLocation!, 18); // Keep map centered on current location

      // Schedule next location update (adjust interval as needed for performance)
      Future.delayed(const Duration(milliseconds: 500), _trackLocation); // Update every 500ms

      _calculateCalorieBurn(speed, 175, 70);

    }
  }

  double _calculateCalorieBurn(double speed, double weight, double height) {
    // Constants
    const double speedFactor = 2.0;
    const double weightFactor = 0.035;
    const double heightFactor = 0.029;

    // Calculate calorie burn per minute
    double calorieBurnPerMinute = (weightFactor * weight) +
        ((speed * speedFactor) / height) * heightFactor * weight;

    // Convert calorie burn per minute to total calorie burn
    calorieBurnPerMinute *= 60; // Convert to per hour

    print("Speed: " + speed.toString());

    print(calorieBurnPerMinute);

    return calorieBurnPerMinute;
  }



  final timestamps = Map<LatLng,
      DateTime>(); // Map positions to timestamps for speed calculation

  double distanceBetween(LatLng p1, LatLng p2) {
    // Haversine formula to calculate distance between two LatLng points (in meters)
    final R = 6371e3; // Earth's radius in meters
    final lat1 = degreesToRadians(p1.latitude);
    final lon1 = degreesToRadians(p1.longitude);
    final lat2 = degreesToRadians(p2.latitude);
    final lon2 = degreesToRadians(p2.longitude);

    final dLat = lat2 - lat1;
    final dLon = lon2 - lon1;

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) * math.cos(lat2) * math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    final distance = R * c;

    return distance;
  }

  double degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(10.776183323564736, 106.66732187988492),
                zoom: 16,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: positions,
                      color: Colors.blue,
                      strokeWidth: 6,
                    ),
                  ],
                ),

                CurrentLocationLayer(
                  alignDirectionOnUpdate: AlignOnUpdate.always,
                  followOnLocationUpdate: FollowOnLocationUpdate.always,
                  turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
                  style: LocationMarkerStyle(
                    marker: const DefaultLocationMarker(
                      child: Icon(
                        Icons.navigation,
                        color: Colors.white,
                      ),
                    ),
                    markerSize: const Size(40, 40),
                    markerDirection: MarkerDirection.heading,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (!isTracking) {
                    _startTracking();
                  } else {
                    _stopTracking();
                  }
                },
                child: Text(isTracking ? 'Stop' : 'Start'),
              ),
              Text('Speed: ${speed.toStringAsFixed(2)} m/s'),
            ],
          ),
        ],
      ),
      
    );
  }
}

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
import 'package:latlong2/latlong.dart';

class WalkingPage extends StatefulWidget {
  const WalkingPage({super.key});

  @override
  State<WalkingPage> createState() => _WalkingPageState();
}

class _WalkingPageState extends State<WalkingPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(10.776183323564736, 106.66732187988492),
        zoom: 20,
      ),
      children: [

        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
    );
  }
}

import 'dart:async';

import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  String _colorName = 'No';
  Color _color = Colors.black;

  final LatLng sourceLocation = LatLng(20.545053, -100.776742);
  final LatLng destLocation = LatLng(20.539126, -100.819196);
  LatLng? myPosition;



  List<LatLng> polylineCoordinates = [];

  /*void getPolyPoints() async{
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates("AIzaSyC64V8r4Aqvqgz-_zt3dg9-4UsZq_nhXkA", 
    PointLatLng(sourceLocation.latitude,destLocation.latitude),
    PointLatLng(destLocation.latitude, sourceLocation.latitude)
    );

    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng point ) { 
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      
    });
  }*/

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    if (mounted) {
    setState(() {
    myPosition = LatLng(position.latitude, position.longitude);
    print(myPosition);
    });
    }
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void startTimer() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      // Esta función se ejecutará cada 5 segundos
      getCurrentLocation();
    });
  }

  @override
  void initState(){
    // TODO: implement initState
    //getPolyPoints();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: myPosition == null
          ? Center(child: const CircularProgressIndicator())
          :/*GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),*/
          CircularMenu(
        alignment: Alignment.bottomCenter,
        radius: 100,
        /*startingAngleInRadian: 0,
        endingAngleInRadian: (2 * pi),*/
        items: [
          CircularMenuItem(
            badgeRadius: 15,
            onTap: () {},
            icon: Icons.map,
            color: Colors.green,
          ),
          CircularMenuItem(
            badgeRadius: 15,
            onTap: () {},
            icon: Icons.store,
            color: Colors.blue,
          ),
          CircularMenuItem(
            badgeRadius: 15,
            onTap: () {},
            icon: Icons.holiday_village,
            color: Colors.greenAccent,
          ),
          CircularMenuItem(
            badgeRadius: 15,
            onTap: () {},
            icon: Icons.access_alarm,
            color: Colors.red,
          )
        ],
        backgroundWidget: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(target: myPosition!, zoom: 14.5),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
          markers: {
            Marker(
            markerId: const MarkerId("Origen"),
            position: sourceLocation,
            infoWindow: InfoWindow(
              title: "Ubicación Origen"
            )
            ),
            Marker(
            markerId: const MarkerId("Destino"),
            position: destLocation,
            infoWindow: InfoWindow(
              title: "Ubicación destino"
            )
            ),
            Marker(
            markerId: const MarkerId("Ubicación Actual"),
            position: myPosition!,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
            infoWindow: InfoWindow(
              title: "Ubicación actual"
            )
            ),
          },
          polylines: {
            Polyline(
              polylineId: PolylineId("Ruta"),
              points: polylineCoordinates,
            ),
          },
        ),
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),*/
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
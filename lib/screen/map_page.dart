import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyMapPageState();
}
class MyMapPageState extends State<MyMapPage> {

  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'lib/images/destination_map_marker.png');
  }

  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(-22.220647, 166.510217);

    // these are the minimum required values to set
    // the camera position
    CameraPosition initialLocation = CameraPosition(
        zoom: 18,
        bearing: 30,
        target: pinPosition
    );

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Localisez-nous',
            style: GoogleFonts.indieFlower(
              textStyle: TextStyle(
                fontSize: 24,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.green[600],
        ),
      body: GoogleMap(
        myLocationEnabled: true,
        compassEnabled: true,
        markers: _markers,
        initialCameraPosition: initialLocation,
        mapType: MapType.hybrid,
        onMapCreated: (GoogleMapController controller) {
          //controller.setMapStyle(Utils.mapStyles);
          _controller.complete(controller);
          setState(() {
            _markers.add(
                Marker(
                    markerId: MarkerId('<MARKER_ID>'),
                    position: pinPosition,
                    icon: pinLocationIcon
                ),
            );
          });
        }),
      );
    }
}
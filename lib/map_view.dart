import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  static const _initialCameraPos =
      CameraPosition(target: LatLng(37.773972, -122.431297), zoom: 11.5);
  @override
  Widget build(BuildContext context) {
    return const GoogleMap(
      initialCameraPosition: _initialCameraPos,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
    );
  }
}

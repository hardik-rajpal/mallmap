import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mallmap/comps/uifuncs.dart';
import 'package:mallmap/comps/values.dart';
import 'package:mallmap/data_service.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);
  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController _controller;
  static const mapState = 0;
  static const shopState = 1;
  int viewState = mapState;
  int floor = 0;
  String shopMapUrl = '';
  DataService dataService = DataService();
  final CameraPosition _initialCameraPos =
      const CameraPosition(target: LatLng(37.773972, -122.431297), zoom: 11.5);
  @override
  void initState() {
    super.initState();
    getUserLocation().then((value) {
      _controller.moveCamera(
          CameraUpdate.newLatLng(LatLng(value.latitude, value.longitude)));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getMainView(viewState, floor);
  }

  Widget getMainView(int viewstate, int floorn) {
    if (viewstate == shopState) {
      return Scaffold(
        appBar: AppBar(
            title: IconButton(
                onPressed: () {
                  setState(() {
                    viewState = mapState;
                  });
                },
                icon: const Icon(Icons.exit_to_app))),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Image.network(
            shopMapUrl,
            fit: BoxFit.fill,
            height: 800,
          ),
        ),
      );
    }
    return GoogleMap(
      initialCameraPosition: _initialCameraPos,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: (controller) {
        _controller = controller;
        _controller.setMapStyle(MapStyles.retail1);
      },
      indoorViewEnabled: true,
      onTap: switchToShop,
    );
  }

  Future<Position> getUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        UIFuncs.toast(context: context, text: 'Permission denied');
      }
    }
    return Geolocator.getCurrentPosition();
  }

  void switchToShop(LatLng argument) async {
    String url =
        await dataService.getShopMapUrl(argument.latitude, argument.longitude);
    if (url.isNotEmpty) {
      setState(() {
        shopMapUrl = url;
        viewState = shopState;
      });
    } else {
      UIFuncs.toast(context: context, text: 'No shop found here');
    }
    //get shop map in latlng from dataservice
    /*
        if(shop map exists){
          confirm switch to shop
        }
        
        */
  }
}

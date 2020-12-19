import 'dart:async';
import 'package:car_tracker_flutter/models/user.dart';
import 'package:car_tracker_flutter/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserService _userService = UserService();

  Location location = Location();

  static LatLng _initialPosition = LatLng(23.8103, 90.4125);

  static LatLng _currentPosition = _initialPosition;

  Completer<GoogleMapController> _controller = Completer();

  double _direction;
  BitmapDescriptor carIcon;
  Set<Marker> markers = Set();

  Future<User> getUser() async {
    var user = await _userService.getUser();
    return user;
  }

  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentPosition,
          zoom: 14.4746,
        ),
      ),
    );
  }

  void openDialog(User user) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.only(top: 160),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.data.avatar),
                    ),
                    Text(
                      '${user.data.firstName} ${user.data.lastName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(user.data.email),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
                platform: TargetPlatform.android, size: Size(16, 16)),
            "assets/images/car_icon.png")
        .then((value) => carIcon = value);

    location.onLocationChanged.listen((event) {
      _goToCurrentLocation();
      setState(() {
        _currentPosition = LatLng(event.latitude, event.longitude);
        _direction = event.heading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    markers.addAll([
      Marker(
        markerId: MarkerId('value'),
        position: _currentPosition,
        icon: carIcon,
        flat: true,
        rotation: _direction,
        onTap: () {
          getUser().then((value) {
            openDialog(value);
          });
        },
      )
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          target: _currentPosition,
          zoom: 14.4746,
        ),
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        compassEnabled: true,
        myLocationButtonEnabled: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCurrentLocation,
        child: Icon(Icons.location_on),
      ),
    );
  }
}

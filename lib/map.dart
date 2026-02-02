import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  GoogleMapController? mapController;
  LatLng _currentLocation = const LatLng(37.7749, -122.4194); // Initial location (San Francisco)
  loc.Location location = loc.Location();
  String _currentAddress = "Fetching address...";

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  void _requestLocationPermission() async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    // Check if location services are enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check for location permission
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    // Get the user's current location
    final locData = await location.getLocation();
    setState(() {
      _currentLocation = LatLng(locData.latitude!, locData.longitude!);
      _getAddressFromLatLng();
    });

    // Move the map camera to the current location
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentLocation, zoom: 15.0),
      ),
    );
  }

  void _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentLocation.latitude,
        _currentLocation.longitude,
      );

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
        "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      setState(() {
        _currentAddress = "Address not available";
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Map Display
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentLocation,
              zoom: 15.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: {
              Marker(
                markerId: const MarkerId('current_location'),
                position: _currentLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                infoWindow: const InfoWindow(
                  title: 'You are here',
                ),
              ),
              const Marker(
                markerId: MarkerId('responder_location'),
                position: LatLng(37.7849, -122.4094),
                infoWindow: InfoWindow(
                  title: '2nd Responder',
                ),
              ),
            },
          ),

          // "Emergency Place" Title
          Positioned(
            left: 14,
            top: 48,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: const Text(
                'Emergency Place',
                style: TextStyle(
                  color: Color(0xFF2B2828),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Address Information Display
          Positioned(
            left: 14,
            top: 710,
            child: SizedBox(
              width: 386,
              height: 156,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 386,
                      height: 156,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 70,
                    top: 20,
                    child: Container(
                      width: 302,
                      height: 43,
                      padding: const EdgeInsets.only(right: 5),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'You are here',
                            style: TextStyle(
                              color: Color(0xFF2B2828),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _currentAddress,
                            style: const TextStyle(
                              color: Color(0xFFA39D9D),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 14,
                    top: 20,
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFFFBBBA),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 2,
                            top: 2,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFFFEAE9),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 14,
                    top: 94,
                    child: Container(
                      width: 171,
                      height: 48,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 171,
                              height: 48,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFEC6461),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 69.50,
                            top: 16,
                            child: Text(
                              'CALL',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 201,
                    top: 94,
                    child: Container(
                      width: 171,
                      height: 48,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 171,
                              height: 48,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1, color: Color(0xFFEC6461)),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 55,
                            top: 15,
                            child: Text(
                              'MESSAGE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFEC6461),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

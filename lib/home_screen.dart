import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import 'package:telephony/telephony.dart';
import 'login.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}




class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 20.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showEmergencyOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Emergency Service',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.local_hospital, color: Colors.red),
                title: const Text('Ambulance'),
                onTap: () {
                  _callEmergencyNumber('102'); // Replace with ambulance number
                },
              ),
              ListTile(
                leading: const Icon(Icons.local_police, color: Colors.blue),
                title: const Text('Police'),
                onTap: () {
                  _callEmergencyNumber('100'); // Replace with police number
                },
              ),
              ListTile(
                leading: const Icon(Icons.wc, color: Colors.pink),
                title: const Text('Women Safety'),
                onTap: () {
                  _handleWomenSafety();
                },
              ),
              ListTile(
                leading: const Icon(Icons.fire_truck, color: Colors.orange),
                title: const Text('Fire Brigade'),
                onTap: () {
                  _callEmergencyNumber('101'); // Replace with fire brigade number
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _callEmergencyNumber(String number) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    await launchUrl(launchUri);
  }

  void _handleWomenSafety() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // Check if location services are enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check location permissions
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Get the location data
    _locationData = await location.getLocation();

    // Send SMS with location to favorite contacts and local authorities
    String message = 'I am in danger, please help. My location is: '
        'https://www.google.com/maps/search/?api=1&query=${_locationData.latitude},${_locationData.longitude}';

    // List of favorite contacts' phone numbers
    List<String> contacts = ['+919876543210', '+911234567890']; // Replace with actual numbers

    final Telephony telephony = Telephony.instance;

    for (String contact in contacts) {
      await telephony.sendSms(
        to: contact,
        message: message,
      );
    }

    // Optionally, send this message to local authorities via an API call if available
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight,
              decoration: const BoxDecoration(color: Color(0xFFFAFAFA)),
              child: Stack(
                children: [
                  Positioned(
                    left: screenWidth * 0.034,
                    top: screenHeight * 0.05,
                    child: SizedBox(
                      width: screenWidth * 0.93,
                      height: screenHeight * 0.06,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: screenHeight * 0.016,
                            child: SizedBox(
                              width: screenWidth * 0.056,
                              height: screenHeight * 0.02,
                              child: const Icon(Icons.menu),
                            ),
                          ),
                          Positioned(
                            left: screenWidth * 0.4,
                            top: screenHeight * 0.00010,
                            child: Text(
                              'Home',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF2B2828),
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: _navigateToLogin,
                              child: Container(
                                width: screenWidth * 0.12,
                                height: screenHeight * 0.06,
                                decoration: const ShapeDecoration(
                                  color: Color(0xFFFFEAE9),
                                  shape: OvalBorder(),
                                ),
                                child: const Icon(Icons.person),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.15,
                    top: screenHeight * 0.12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.6,
                          child: Text(
                            'Are you in an emergency?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF35393B),
                              fontSize: screenWidth * 0.07,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: screenWidth * 0.75,
                          child: Text(
                            'Press the button below and help will reach you shortly.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFA39D9D),
                              fontSize: screenWidth * 0.035,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Animated SOS Button
                  Positioned(
                    left: screenWidth * 0.18,
                    top: screenHeight * 0.35,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return GestureDetector(
                          onTap: _showEmergencyOptions, // Show options on tap
                          child: Container(
                            width: screenWidth * 0.65,
                            height: screenWidth * 0.65,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFEC6461),
                              shape: OvalBorder(
                                side: BorderSide(
                                  width: 20 + _animation.value,
                                  color: const Color(0xFFFFD5D4),
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'SOS',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.1,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.03,
                    top: screenHeight * 0.80,
                    child: Container(
                      width: screenWidth * 0.93,
                      height: screenHeight * 0.1,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 48,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Current Address',
                              style: TextStyle(
                                color: const Color(0xFF2B2828),
                                fontSize: screenWidth * 0.035,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Anurag University, Venkatapur',
                              style: TextStyle(
                                color: const Color(0xFFA39D9D),
                                fontSize: screenWidth * 0.03,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

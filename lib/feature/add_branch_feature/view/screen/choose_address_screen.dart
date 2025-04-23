import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:supplies/core/components/custom_floating_action_button.dart';
import 'package:supplies/core/constant/app_colors.dart'; // Import the dio package

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => GoogleMapsState();
}

class GoogleMapsState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  LatLng? _currentLocation;
  bool _isLoading = true;
  Set<Marker> _markers = {};
  String _address = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permissions are permanently denied. Please enable them in app settings.'),
        ),
      );
      return;
    }

    // Fetch the current location
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _isLoading = false;
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: _currentLocation!,
          infoWindow: const InfoWindow(title: 'Your Location'),
        ),
      );
    });

    // Move the map camera to the current location
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(_currentLocation!, 14.4746),
    );

    // Set the map language to Arabic
    await _setMapLanguage(controller, 'ar');
  }

  // Handle long press to update the marker
  void _onMapLongPress(LatLng latLng) {
    setState(() {
      _markers.clear(); // Clear existing markers
      _markers.add(
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: latLng,
          infoWindow: InfoWindow(title: 'Selected Location', snippet: '${latLng.latitude}, ${latLng.longitude}'),
        ),
      );
    });
  }

  // Convert latitude and longitude to an address in Arabic
  Future<void> _convertLocationToAddress(LatLng latLng) async {
    const apiKey = 'AIzaSyAAOcn3r6DVavhuoPatQvNGg5kUuV1zAFo'; // Replace with your API key
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&language=ar&key=$apiKey';

    final dio = Dio(); // Create a Dio instance

    try {
      // Make an HTTP GET request to the Geocoding API
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final data = response.data;

        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          // Extract the formatted address in Arabic
          final formattedAddress = data['results'][0]['formatted_address'];

          setState(() {
            _address = formattedAddress;
          });

          // Return the address to the previous screen
          Navigator.pop(context, _address);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('فشل في جلب العنوان.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل في الاتصال بالخادم.')),
        );
      }
    } catch (e) {
      print('Error converting location to address: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل في جلب العنوان.')),
      );
    }
  }

  // Set the map language to Arabic
  Future<void> _setMapLanguage(GoogleMapController controller, String language) async {
    await controller.setMapStyle('''
      [
        {
          "featureType": "all",
          "elementType": "all",
          "stylers": [
            { "language": "$language" }
          ]
        }
      ]
    ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Choose Location'),
        leading: BackButton(),
        elevation: 0,
      ),
      body: Stack(
        children: [
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: _markers, // Use the _markers set
                  onLongPress: _onMapLongPress, // Handle long press
                ),
          // Confirm Button at the bottom of the screen
          Positioned(
            bottom: 20, // Adjust the position as needed
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () async {
                if (_markers.isNotEmpty) {
                  LatLng selectedLocation = _markers.first.position;
                  await _convertLocationToAddress(selectedLocation);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('الرجاء تحديد موقع على الخريطة')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary, // Button color
                padding: EdgeInsets.symmetric(vertical: 16), // Button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Button border radius
                ),
              ),
              child: Text(
                'Confirm Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          _getCurrentLocation();
        },
        icon: Icons.my_location,
        iconColor: AppColors.white,
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:graduationproject/core/theme/app_colors.dart';

class EgyptMapScreen extends StatefulWidget {
  const EgyptMapScreen({super.key});

  @override
  State<EgyptMapScreen> createState() => _EgyptMapScreenState();
}

class _EgyptMapScreenState extends State<EgyptMapScreen> {

  // ================= LOGIC =================
  LatLng? selectedLocation;
  LatLng? myLocation;
  LatLng currentLocation = LatLng(31.0409, 31.3785);

  final MapController mapController = MapController();
  double currentZoom = 10.0;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _goToCurrentLocation();
  }

  // ================= GPS =================
  Future<void> _goToCurrentLocation() async {

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (position.latitude >= 22 &&
        position.latitude <= 31.7 &&
        position.longitude >= 25 &&
        position.longitude <= 35) {

      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        myLocation = currentLocation;
      });

      mapController.move(currentLocation, 14);
    }
  }

  // ================= SEARCH =================
  Future<void> searchPlace(String query) async {

    if (query.isEmpty) return;

    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query+egypt&format=json&limit=1');

    final response = await http.get(url, headers: {
      "User-Agent": "com.example.rased"
    });

    if (response.statusCode == 200) {

      final data = json.decode(response.body);

      if (data.isNotEmpty) {

        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);

        if (lat >= 22 && lat <= 31.7 && lon >= 25 && lon <= 35) {

          final point = LatLng(lat, lon);

          setState(() {
            selectedLocation = point;
          });

          mapController.move(point, 14);
        }
      }
    }
  }

  // ================= REVERSE =================
  Future<String> getPlaceName(double lat, double lon) async {

    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lon&format=json');

    final response = await http.get(url, headers: {
      "User-Agent": "com.example.rased"
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['display_name'] ?? "مكان غير معروف";
    }

    return "مكان غير معروف";
  }

  // ================= ZOOM =================
  void zoomIn() {
    setState(() {
      if (currentZoom < 18) currentZoom++;
      mapController.move(mapController.center, currentZoom);
    });
  }

  void zoomOut() {
    setState(() {
      if (currentZoom > 5) currentZoom--;
      mapController.move(mapController.center, currentZoom);
    });
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),

      body: Column(
        children: [

          // ================= HEADER =================
          Container(
            padding: const EdgeInsets.only(top: 50, right: 16, left: 16),
            height: 140,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              children: const [
                Text(
                  'تحديد موقع الشكوى',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Icon(Icons.keyboard_arrow_left,
                    color: Colors.white, size: 32),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // ================= MAP =================
          Center(
            child: SizedBox(
              width: 393,
              height: 426,
              child: Stack(
                children: [

                  FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      center: currentLocation,
                      zoom: currentZoom,
                      minZoom: 5,
                      maxZoom: 18,

                      onTap: (tapPosition, point) {

                        if (point.latitude >= 22 &&
                            point.latitude <= 31.7 &&
                            point.longitude >= 25 &&
                            point.longitude <= 35) {

                          setState(() {
                            selectedLocation = point;
                          });

                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("اختار موقع داخل مصر"),
                            ),
                          );
                        }
                      },
                    ),

                    children: [

                      TileLayer(
                        urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'com.example.rased',
                      ),

                      if (myLocation != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: myLocation!,
                              width: 60,
                              height: 60,
                              child: const Icon(
                                Icons.my_location,
                                color: Colors.green,
                                size: 40,
                              ),
                            ),
                          ],
                        ),

                      if (selectedLocation != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: selectedLocation!,
                              width: 80,
                              height: 80,
                              child: const Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 45,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),

                  // ================= SEARCH =================
                  Positioned(
                    top: 10,
                    left: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [

                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: const InputDecoration(
                                hintText: "ابحث عن مكان...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              searchPlace(searchController.text);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ================= ZOOM =================
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: Column(
                      children: [

                        FloatingActionButton(
                          heroTag: "z1",
                          mini: true,
                          onPressed: zoomIn,
                          child: const Icon(Icons.add),
                        ),

                        const SizedBox(height: 8),

                        FloatingActionButton(
                          heroTag: "z2",
                          mini: true,
                          onPressed: zoomOut,
                          child: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 120),

          // ================= CONFIRM =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              onPressed: () async {

                if (selectedLocation != null) {

                  String name = await getPlaceName(
                      selectedLocation!.latitude,
                      selectedLocation!.longitude);

                  Navigator.pop(context, {
                    "lat": selectedLocation!.latitude,
                    "lng": selectedLocation!.longitude,
                    "name": name
                  });
                }
              },

              child: const Text(
                "تأكيد الموقع",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:graduationproject3/core/theme/app_colors.dart';

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
  double currentZoom = 12.0;

  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

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
        // نعتبر الموقع الحالي هو المختار مبدئياً
        selectedLocation = currentLocation;
      });

      mapController.move(currentLocation, 14);
    }
  }

  // ================= SEARCH =================
  Future<void> searchPlace(String query) async {

    if (query.isEmpty) return;

    setState(() {
      isSearching = true;
    });

    try {
      final url = Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(query)}+egypt&format=json&limit=1&accept-language=ar');

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

            mapController.move(point, 15);
          }
        } else {
           if(mounted) {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("لم يتم العثور على المكان")),
            );
           }
        }
      }
    } catch (e) {
       if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("حدث خطأ أثناء البحث")),
          );
       }
    } finally {
      setState(() {
        isSearching = false;
      });
    }
  }

  // ================= REVERSE =================
  Future<String> getPlaceName(double lat, double lon) async {
    try {
      final url = Uri.parse(
          'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lon&format=json&addressdetails=1&accept-language=ar');

      final response = await http.get(url, headers: {
        "User-Agent": "com.example.rased"
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data['address'];
        
        if (address != null) {
          List<String> parts = [];
          
          // ترتيب العناوين من الأصغر للأكبر
          if (address['road'] != null) parts.add(address['road']);
          if (address['neighbourhood'] != null) parts.add(address['neighbourhood']);
          if (address['suburb'] != null) parts.add(address['suburb']);
          if (address['city_district'] != null) parts.add(address['city_district']);
          if (address['town'] != null) parts.add(address['town']);
          if (address['city'] != null) parts.add(address['city']);
          if (address['state'] != null) parts.add(address['state']);

          if (parts.isNotEmpty) {
            // لو العنوان طويل جداً، ناخد أول 3 أو 4 أجزاء بس
            return parts.length > 3 ? parts.take(4).join('، ') : parts.join('، ');
          }
        }
        return data['display_name']?.toString().split(',').first ?? "موقع محدد";
      }
    } catch (e) {
      return "موقع محدد";
    }

    return "موقع محدد";
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
              children: [
                const Text(
                  'تحديد موقع الشكوى',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.keyboard_arrow_left,
                      color: Colors.white, size: 32),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // ================= MAP =================
          Expanded(
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
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
                        ]
                      ),
                      child: Row(
                        children: [

                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: "ابحث عن مكان...",
                                border: InputBorder.none,
                                suffixIcon: isSearching ? const SizedBox(width: 20, height: 20, child: Padding(padding: EdgeInsets.all(10), child: CircularProgressIndicator(strokeWidth: 2))) : null,
                              ),
                              onSubmitted: (val) => searchPlace(val),
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
                    bottom: 100,
                    right: 15,
                    child: Column(
                      children: [

                        FloatingActionButton(
                          heroTag: "z1",
                          mini: true,
                          onPressed: zoomIn,
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.add, color: AppColors.primary),
                        ),

                        const SizedBox(height: 8),

                        FloatingActionButton(
                          heroTag: "z2",
                          mini: true,
                          onPressed: zoomOut,
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.remove, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),

                  // ================= CONFIRM BUTTON ON MAP =================
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
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
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(child: CircularProgressIndicator()),
                          );

                          String name = await getPlaceName(
                              selectedLocation!.latitude,
                              selectedLocation!.longitude);

                          if (mounted) {
                            Navigator.pop(context); // Close dialog
                            Navigator.pop(context, {
                              "lat": selectedLocation!.latitude,
                              "lng": selectedLocation!.longitude,
                              "name": name
                            });
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("يرجى تحديد موقع أولاً")),
                          );
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
          ),
        ],
      ),
    );
  }
}

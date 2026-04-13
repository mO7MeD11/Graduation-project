import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gap/gap.dart';
import 'package:graduationproject/core/style/font_style.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  bool isSharing = true;

  LatLng? currentLocation;

  final MapController mapController = MapController();

  final List<LatLng> drivers = [
    LatLng(31.0440, 31.3720),
    LatLng(31.0380, 31.3850),
    LatLng(31.0460, 31.3810),
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<void> getLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition();

    final LatLng newPos = LatLng(position.latitude, position.longitude);

    setState(() {
      currentLocation = newPos;
    });

    mapController.move(newPos, 16);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EDF8),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 150, 16, 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xFF0D5DA5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Icon(Icons.arrow_forward_ios, color: Colors.white)],
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      initialCenter:
                          currentLocation ?? LatLng(31.0409, 31.3785),
                      initialZoom: 14,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png",
                        userAgentPackageName: 'com.example.app',
                        retinaMode: true,
                      ),

                      MarkerLayer(
                        markers: drivers
                            .map(
                              (e) => Marker(
                                point: e,
                                width: 40,
                                height: 40,
                                child: const Icon(
                                  Icons.directions_car,
                                  color: Colors.orange,
                                ),
                              ),
                            )
                            .toList(),
                      ),

                      if (currentLocation != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: currentLocation!,
                              width: 50,
                              height: 50,
                              child: const Icon(
                                Icons.location_pin,
                                size: 40,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),

                  Positioned(
                    top: 16,
                    right: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "لايف دلوقتي",
                                style: FontStyles.regular20,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 4,
                                    backgroundColor: isSharing
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  const Gap(4),
                                  Text(
                                    isSharing
                                        ? "موقعك ظاهر دلوقتي"
                                        : "موقعك مخفي دلوقتي",
                                    style: FontStyles.regular16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Text("راكب"),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Gap(10),

                           
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "مشاركة المكان لايف",
                                  style: FontStyles.regular20,
                                ),
                              ),
                              Switch(
                                activeThumbColor: Colors.green,
                                value: isSharing,
                                onChanged: (val) {
                                  setState(() => isSharing = val);
                                },
                              ),
                            ],
                          ),

                          const Spacer(),

                          
                          GestureDetector(
                            onTap: () {
                              getLocation();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: const BoxDecoration(
                                color: Color(0xFF0D5DA5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "هات مكاني",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }
}

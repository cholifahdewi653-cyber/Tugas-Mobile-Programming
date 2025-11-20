import 'package:flutter/material.dart';
import 'dart:math';

class CompassScreen extends StatefulWidget {
  const CompassScreen({Key? key}) : super(key: key);

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _rotation = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Simulasi perubahan heading
    _simulateCompass();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _simulateCompass() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _updateHeading(45.0); // Ubah ke 45 derajat
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            _updateHeading(90.0); // Ubah ke 90 derajat
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                _updateHeading(0.0); // Kembali ke 0 derajat
              }
            });
          }
        });
      }
    });
  }

  void _updateHeading(double newHeading) {
    final difference = newHeading - _rotation;
    final normalizedDifference =
        ((difference + 180) % 360) - 180; // Jarak terpendek

    _animationController.forward(from: 0.0);
    _animationController.addListener(() {
      setState(() {
        _rotation = _rotation + (normalizedDifference * _animationController.value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Kompas Qibla',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Arah menuju Ka\'bah (Qibla)',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 30),

            // Compass Card
            _buildCompass(),

            const SizedBox(height: 30),

            // Info Cards
            _buildInfoSection(),

            const SizedBox(height: 20),

            // Location Info
            _buildLocationInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildCompass() {
    return Center(
      child: Container(
        width: 280,
        height: 280,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Compass Background
            Transform.rotate(
              angle: -_rotation * pi / 180,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 3),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Directions
                    Positioned(
                      top: 20,
                      child: Text(
                        'Utara',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      child: Text(
                        'Selatan',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      child: Text(
                        'Barat',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      child: Text(
                        'Timur',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),

                    // Cardinal Points Dots
                    Positioned(
                      top: 35,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 35,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 35,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 35,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),

                    // Degree markers
                    _buildDegreeMarkers(),
                  ],
                ),
              ),
            ),

            // Qibla Arrow (Red/Green arrow pointing up)
            Transform.rotate(
              angle: -_rotation * pi / 180,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),

            // Center Circle
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.shade700,
              ),
              child: const Icon(
                Icons.my_location,
                color: Colors.white,
                size: 24,
              ),
            ),

            // Degree Display
            Positioned(
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_rotation.toStringAsFixed(0)}°',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDegreeMarkers() {
    return Stack(
      alignment: Alignment.center,
      children: [
        for (int i = 0; i < 360; i += 30)
          Transform.rotate(
            angle: i * pi / 180,
            child: Positioned(
              top: 15,
              child: Container(
                width: 2,
                height: 12,
                color: i % 90 == 0 ? Colors.green.shade700 : Colors.grey,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Arah Qibla',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_getDirection(_rotation)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Derajat',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_rotation.toStringAsFixed(1)}°',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInfo() {
    return Card(
      color: Colors.green.shade600,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informasi Lokasi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Jakarta, Indonesia',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_city, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Latitude: -6.2088 | Longitude: 106.8456',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.info, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Arah ke Ka\'bah: Utara-Barat Laut',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getDirection(double rotation) {
    final normalized = rotation % 360;
    if (normalized < 22.5 || normalized >= 337.5) return 'Utara';
    if (normalized < 67.5) return 'Utara Timur';
    if (normalized < 112.5) return 'Timur';
    if (normalized < 157.5) return 'Selatan Timur';
    if (normalized < 202.5) return 'Selatan';
    if (normalized < 247.5) return 'Selatan Barat';
    if (normalized < 292.5) return 'Barat';
    return 'Utara Barat';
  }
}
